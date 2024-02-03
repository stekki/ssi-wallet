import 'dart:convert';
import 'dart:developer';

Map<String, dynamic> parseJwt(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('Invalid token');
  }

  final payload = base64Url.normalize(parts[1]);
  final resp = utf8.decode(base64Url.decode(payload));
  final payloadMap = json.decode(resp);
  log('JWT payload: $payloadMap');

  return payloadMap;
}

String? getUsernameJwt(String token) {
  try {
    final parsedToken = parseJwt(token);
    return parsedToken['label'];
  } catch (e) {
    return null;
  }
}