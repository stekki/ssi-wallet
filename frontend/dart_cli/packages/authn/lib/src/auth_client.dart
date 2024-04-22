import 'dart:convert';

import 'package:authn/src/command.dart';
import 'package:authn/src/config.dart';
import 'package:authn/src/fido_command.dart';

import 'generated/authn.pbgrpc.dart';
import 'package:grpc/grpc.dart';
import 'package:fixnum/fixnum.dart'; // NOTE. for Int64

import 'package:basic_utils/basic_utils.dart';
import 'package:cbor/cbor.dart';
import 'dart:typed_data';

import 'dart:async';
import 'dart:io';

const String curve = 'prime256v1';
Int64 keyHandleId = Int64(1);

// --- memory vales ---
// URL: to contact aka WebAuthn server
// aAGUID: our authn ID
// salt: for pin code
// Cert: all files // do we need only client files? how about bundle?

// --- clean up ---
// what happens when ..

Xorel? seal;

class PemPair {
  String? pemPub;
  String? pemPriv;

  AsymmetricKeyPair? pair;

  ECPrivateKey get privateKey => pair!.privateKey as ECPrivateKey;
  ECPublicKey get publicKey => pair!.publicKey as ECPublicKey;

  List<int> get data => utf8.encode('$pemPriv\n$pemPub');

  PemPair.generate() {
    pair = CryptoUtils.generateEcKeyPair(curve: curve);
    pemPriv = CryptoUtils.encodeEcPrivateKeyToPem(privateKey);
    pemPub = CryptoUtils.encodeEcPublicKeyToPem(publicKey);
  }

  PemPair.load(Uint8List d) {
    final strData = utf8.decode(d);

    final lines = LineSplitter.split(strData);
    var pemPrivStr = '';
    var pemPubStr = '';
    var pub = false;

    for (var lineStr in lines) {
      if (CryptoUtils.BEGIN_PUBLIC_KEY == lineStr) {
        pub = true;
      }
      if (pub) {
        pemPubStr += '$lineStr\n';
      } else {
        pemPrivStr += '$lineStr\n';
      }
    }
    pemPriv = pemPrivStr;
    pemPub = pemPubStr;
    final privateKey = CryptoUtils.ecPrivateKeyFromPem(pemPrivStr);
    final tmpPubKey = CryptoUtils.ecPublicKeyFromPem(pemPubStr);
    pair = AsymmetricKeyPair(tmpPubKey, privateKey);
  }
}

class Xorel {
  int salt = 56; // todo:
  int key;

  Xorel(this.key, {this.salt = 0});

  Uint8List xor(Uint8List d) {
    Uint8List xorData = Uint8List(d.length);
    int i = 0;
    for (var e in d) {
      xorData[i++] = e ^ (salt + key);
    }
    return xorData;
  }
}

class Handle {
  Int64 id;
  ECPrivateKey? privateKey;
  List<int>? _data; // is credID todo: rename?
  ECPublicKey? publicKey;

  // should we rename to Xor todo: or XorData
  Uint8List get credID => seal!.xor(_data! as Uint8List);

  Handle.load(Uint8List d) : id = keyHandleId {
    var credData = seal!.xor(d);
    final kp = PemPair.load(credData);
    privateKey = kp.privateKey;
    publicKey = kp.publicKey;
    _data = d;
  }

  Handle() : id = keyHandleId {
    final akp = PemPair.generate();

    privateKey = akp.privateKey;
    publicKey = akp.publicKey;
    _data = akp.data;
  }

  List<int> toCbor() {
    final ecPublicKey = publicKey!;
    final cborMap = CborMap({
      const CborSmallInt(kty): const CborSmallInt(2),
      const CborSmallInt(alg): const CborSmallInt(-7),
      const CborSmallInt(crvCOSE): const CborSmallInt(1),
      const CborSmallInt(xCOSE):
          CborBytes(CborBigInt(ecPublicKey.Q!.x!.toBigInteger()!).bytes),
      const CborSmallInt(yCOSE):
          CborBytes(CborBigInt(ecPublicKey.Q!.y!.toBigInteger()!).bytes),
    });
    final cborBytes = cbor.encode(cborMap);
    return cborBytes;
  }

  List<int> sign(List<int> data) {
    final toSign = Uint8List.fromList(data);
    final /*ECSignature*/ sig =
        CryptoUtils.ecSign(privateKey!, toSign, algorithmName: 'SHA-256/ECDSA');
    final b64 = CryptoUtils.ecSignatureToBase64(sig);
    return base64Decode(b64);
  }
}

Handle? myHandle;
Config? cfg;
Command? baseCmd;
FidoCommand? fidoCommand;

const keyPath =
    '/home/parallels/go/src/github.com/findy-network/cert/server/server.key';
const certPath =
    '/home/parallels/go/src/github.com/findy-network/cert/server/server.crt';

// '/home/parallels/go/src/github.com/findy-network/cert/client/client.crt';

class SecurityContextChannelCredentials extends ChannelCredentials {
  final SecurityContext _securityContext;

  SecurityContextChannelCredentials(SecurityContext securityContext,
      {super.authority, super.onBadCertificate})
      : _securityContext = securityContext,
        super.secure();

  @override
  SecurityContext get securityContext => _securityContext;

  static SecurityContext baseSecurityContext() {
    return createSecurityContext(false);
  }
}

void setDefs(Config c, Command base, FidoCommand fido) {
  cfg = c;
  baseCmd = base;
  fidoCommand = fido;
}

Future<String> exec(String cmd, name, xorKey) async {
  assert(cfg != null);
  assert(baseCmd != null);
  assert(fidoCommand != null);

  //final cert = File(certPath).readAsBytesSync();

  final channelContext =
      SecurityContextChannelCredentials.baseSecurityContext();
  channelContext.useCertificateChain(cfg!.certFile);
  channelContext.usePrivateKey(cfg!.keyFile);
  final channelCredentials = SecurityContextChannelCredentials(channelContext,
      onBadCertificate: (cert, s) {
    return true;
  });
  final channel = ClientChannel(
    baseCmd!.address,
    port: baseCmd!.port,
    options: ChannelOptions(
      credentials: channelCredentials,
    ),
    //CodecRegistry(codecs: const [GzipCodec()]),
  );
  final stub = AuthnServiceClient(channel,
      options: CallOptions(timeout: Duration(seconds: 5)));

  final myCMD = cmd == 'login' ? Cmd_Type.LOGIN : Cmd_Type.REGISTER;
  final keyHandleID = Int64(1);
  seal = Xorel(int.parse(xorKey));
  keyHandleId = keyHandleID;

  print('keyHandleID: $keyHandleID');

  var tokenPayload = '';

  try {
    print('for starts');
    await for (var cmdStat in stub.enter(
      Cmd(
        type: myCMD, //type: Cmd_Type.REGISTER,
        userName: name,
        uRL: fidoCommand!.url, // todo: argument/var
        aAGUID: fidoCommand!.aaguid, // todo: argument/var
      ),
      //options: CallOptions(compression: const GzipCodec()), // this works!!
    )) {
      print('status msg arrives: ${cmdStat.type}');
      switch (cmdStat.type) {
        case CmdStatus_Type.READY_OK:
          tokenPayload = cmdStat.ok.jWT;
          break;
        case CmdStatus_Type.READY_ERR:
          final msg = cmdStat.err;
          print('cmd status ERR, throwing-> "$msg"');
          throw 'Exp: error';
        //break;
        case CmdStatus_Type.STATUS:
          print('==> Has OK: ${cmdStat.type}');
          print('--> received ${cmdStat.secType}');

          switch (cmdStat.secType) {
            case SecretMsg_Type.IS_KEY_HANDLE:
              final myID = keyHandleId;
              final credID = cmdStat.enclave.credID as Uint8List;
              myHandle = Handle.load(credID);
              assert(myHandle != null);
              stub.enterSecret(SecretMsg(
                  cmdID: cmdStat.cmdID,
                  type: cmdStat.secType,
                  handle: SecretMsg_HandleMsg(iD: myID)));
              break;

            case SecretMsg_Type.CBOR_PUB_KEY:
              final handleID = cmdStat.handle.iD;
              assert(handleID != 0);
              assert(myHandle != null);
              final handle = myHandle!;
              final keyData = handle.toCbor();
              stub.enterSecret(SecretMsg(
                  cmdID: cmdStat.cmdID,
                  type: cmdStat.secType,
                  handle: SecretMsg_HandleMsg(iD: handle.id, data: keyData)));
              break;

            case SecretMsg_Type.NEW_HANDLE:
              final myID = keyHandleId;
              myHandle = Handle();
              final handle = myHandle!;
              final keyData = handle.credID;
              stub.enterSecret(SecretMsg(
                  cmdID: cmdStat.cmdID,
                  type: cmdStat.secType,
                  handle: SecretMsg_HandleMsg(iD: myID, data: keyData)));
              break;

            case SecretMsg_Type.ID:
              final handleID = cmdStat.handle.iD;
              assert(handleID != 0);
              final handle = myHandle!;
              final keyData = handle.credID;
              stub.enterSecret(SecretMsg(
                  cmdID: cmdStat.cmdID,
                  type: cmdStat.secType,
                  handle: SecretMsg_HandleMsg(iD: handle.id, data: keyData)));
              break;

            case SecretMsg_Type.SIGN:
              final handleID = cmdStat.handle.iD;
              final toSignData = cmdStat.handle.data;
              assert(handleID != 0);
              final handle = myHandle!;
              final signData = handle.sign(toSignData);
              stub.enterSecret(SecretMsg(
                  cmdID: cmdStat.cmdID,
                  type: cmdStat.secType,
                  handle: SecretMsg_HandleMsg(iD: handle.id, sign: signData)));
              break;

            default:
              print('ERROR: unknown sec type');
          }
          break;
        default:
          print('ERR: type');
      }
    }
  } catch (e) {
    print('Caught error: $e');
  }
  await channel.shutdown();

  switch (myCMD) {
    case Cmd_Type.LOGIN:
      final token = jsonDecode(tokenPayload);
      final jwt = token['token'] as String;
      return jwt;
    default:
      return 'Registering OK';
  }
}

const int crvCOSE = -1;
const int xCOSE = -2;
const int yCOSE = -3;

/// Constant for the Key Type.
const int kty = 1;

/// Constant for the Key ID.
const int kid = 2;

/// Constant for the Key Algorithm.
const int alg = 3;
