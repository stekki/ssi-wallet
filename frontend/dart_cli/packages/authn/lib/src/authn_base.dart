import 'dart:io';
import 'package:yaml/yaml.dart';

import 'config.dart';
import 'fido_command.dart';
import 'command.dart';

import 'auth_client.dart';

const clientKeyPath =
    '../../findy-network/cert/client/client.key';
const clientCertPath =
    '../../findy-network/cert/client/client.crt';

class AuthnCommand extends Command {
  AuthnCommand(super.addr, super.port);
}

void setup(Config cfg, Command base, FidoCommand fido) {
  setDefs(cfg, base, fido);
}

void setupDefaults() {
  final cfg = Config(56, clientCertPath, clientKeyPath);
  final baseCmd = Command('localhost', 50051);
  final fidoCmd = FidoCommand(
      'http://localhost:8090', '12c85a48-4baf-47bd-b51f-f192871a1511');
  setDefs(cfg, baseCmd, fidoCmd);
}

void setupFromYAML(String filename) {
  final data = File(filename).readAsStringSync();
  Map map = loadYaml(data);
  // to correct map type: <dynamic, dynamic> -> <string, dynamic>
  Map<String, dynamic> yaml =
      map.map((key, value) => MapEntry(key!.toString(), value));

  final cfg = Config.loadMap(yaml);
  final baseCmd = Command.loadMap(yaml);
  final fidoCmd = FidoCommand.loadMap(yaml);

  setDefs(cfg, baseCmd, fidoCmd);
}

Future<String> authnWithDefs(String cmd, name, xorKey) async {
  setupDefaults();
  return exec(cmd, name, xorKey);
}

Future<String> authnCmd(String cmd, name, xorKey) async {
  return exec(cmd, name, xorKey);
}
