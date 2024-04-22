//import 'package:cli/auth_client.dart';
import 'package:authn/authn.dart';

const neededArgsSizeForCloud = 4;

Future<void> main(List<String> args) async {
  if (args.length < neededArgsSizeForCloud - 1 ||
      args.length > neededArgsSizeForCloud) {
    print('Usage: <login/register> <name> <keyID> [your-cfg-file.yaml]\n');
    print('       your-cfg-file.yaml: enter your configurations in YAML,');
    print('                           or defauls are used\n');
    return;
  }

  final cmd = args[0];
  final name = args[1];
  final pin = args[2];
  print('cmd: $cmd, name: $name, keyID: $pin');
  if (args.length == neededArgsSizeForCloud) {
    setupFromYAML(args[3]);
  } else {
    setupDefaults();
  }
  final jwt = await authnCmd(cmd, name, pin);
  print(jwt);

  return;
}
