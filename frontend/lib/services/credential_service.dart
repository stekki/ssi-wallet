import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/models.dart';
import '../services/graphql_service.dart';
import '../services/queries.dart';

class CredentialService {
  static List<Credential> gqlCredentials = [];
  static Map<String, dynamic> pageInfo = {};
  static Future<void> getCredentials() async {
    try {
      await GraphQLService.getQueryResult(
        credentialQuery,
        {},
      );
    } catch (e) {
      throw Exception(e);
    }
  }

StreamProvider<List<Credential>> credentialStreamProvider() =>
    StreamProvider<List<Credential>>((ref) {
      final stream = GraphQLConfig.client!
          .watchQuery(WatchQueryOptions(
            fetchResults: true,
            document: credentialQuery,
          ))
          .stream
          .map((event) {
        try {
          final List<dynamic> res = event.data?["credentials"]["edges"];
          gqlCredentials = res
          .where((element) => element["node"]["schemaId"].toString().toLowerCase().contains("receipt"))
          .map((e) {
            final node = e?["node"];
            return Credential.fromJson(node);
          }).toList();
          pageInfo = event.data?["credentials"]["pageInfo"];
          return gqlCredentials;
        } catch (e) {
          gqlCredentials = [];
          pageInfo = {};
          return gqlCredentials;
        }
      });
      return stream;
    });
}
