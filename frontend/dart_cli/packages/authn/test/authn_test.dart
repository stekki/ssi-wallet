import 'package:authn/authn.dart';
import 'package:test/test.dart';

void main() {
  group('A group of tests', () {
    final awesome = FidoCommand('test', 'aaguid', origin: 'origin');

    setUp(() {
      // Additional setup goes here.
    });

    test('First Test', () {
      expect(awesome.url, 'test');
      expect(awesome.aaguid, 'aaguid');
      expect(awesome.origin, 'origin');
    });
  });
}
