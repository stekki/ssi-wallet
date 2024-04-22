//
//  Generated code. Do not modify.
//  source: authn.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

class SecretMsg_Type extends $pb.ProtobufEnum {
  static const SecretMsg_Type ERROR = SecretMsg_Type._(0, _omitEnumNames ? '' : 'ERROR');
  static const SecretMsg_Type NEW_HANDLE = SecretMsg_Type._(1, _omitEnumNames ? '' : 'NEW_HANDLE');
  static const SecretMsg_Type IS_KEY_HANDLE = SecretMsg_Type._(2, _omitEnumNames ? '' : 'IS_KEY_HANDLE');
  static const SecretMsg_Type ID = SecretMsg_Type._(3, _omitEnumNames ? '' : 'ID');
  static const SecretMsg_Type CBOR_PUB_KEY = SecretMsg_Type._(4, _omitEnumNames ? '' : 'CBOR_PUB_KEY');
  static const SecretMsg_Type SIGN = SecretMsg_Type._(5, _omitEnumNames ? '' : 'SIGN');
  static const SecretMsg_Type VERIFY = SecretMsg_Type._(6, _omitEnumNames ? '' : 'VERIFY');

  static const $core.List<SecretMsg_Type> values = <SecretMsg_Type> [
    ERROR,
    NEW_HANDLE,
    IS_KEY_HANDLE,
    ID,
    CBOR_PUB_KEY,
    SIGN,
    VERIFY,
  ];

  static final $core.Map<$core.int, SecretMsg_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static SecretMsg_Type? valueOf($core.int value) => _byValue[value];

  const SecretMsg_Type._($core.int v, $core.String n) : super(v, n);
}

class Cmd_Type extends $pb.ProtobufEnum {
  static const Cmd_Type LOGIN = Cmd_Type._(0, _omitEnumNames ? '' : 'LOGIN');
  static const Cmd_Type REGISTER = Cmd_Type._(1, _omitEnumNames ? '' : 'REGISTER');

  static const $core.List<Cmd_Type> values = <Cmd_Type> [
    LOGIN,
    REGISTER,
  ];

  static final $core.Map<$core.int, Cmd_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Cmd_Type? valueOf($core.int value) => _byValue[value];

  const Cmd_Type._($core.int v, $core.String n) : super(v, n);
}

class CmdStatus_Type extends $pb.ProtobufEnum {
  static const CmdStatus_Type STATUS = CmdStatus_Type._(0, _omitEnumNames ? '' : 'STATUS');
  static const CmdStatus_Type READY_OK = CmdStatus_Type._(1, _omitEnumNames ? '' : 'READY_OK');
  static const CmdStatus_Type READY_ERR = CmdStatus_Type._(2, _omitEnumNames ? '' : 'READY_ERR');

  static const $core.List<CmdStatus_Type> values = <CmdStatus_Type> [
    STATUS,
    READY_OK,
    READY_ERR,
  ];

  static final $core.Map<$core.int, CmdStatus_Type> _byValue = $pb.ProtobufEnum.initByValue(values);
  static CmdStatus_Type? valueOf($core.int value) => _byValue[value];

  const CmdStatus_Type._($core.int v, $core.String n) : super(v, n);
}


const _omitEnumNames = $core.bool.fromEnvironment('protobuf.omit_enum_names');
