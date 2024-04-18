import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/config/graphql_config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/models.dart';
import '../services/graphql_service.dart';
import '../services/queries.dart';

class ConnectionService {
  static final ConnectionService _instance = ConnectionService._();
  ConnectionService._();
  factory ConnectionService() {
    return _instance;
  }
  static QueryResult? fullResult;
  static List<Connection> gqlConnections = [];
  static Map<String, dynamic> pageInfo = {};
  static final acceptConnectionMutation = gql("""
        mutation connect(\$input: ConnectInput!) {
          connect(input: \$input) {
            ok
          }
        }""");

  Future<void> getConnections() async {
    try {
      await GraphQLService.getQueryResult(
        connectionsQuery,
        {},
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<bool> acceptConnection(String? invitation) async {
    final variables = {
      'input': {
        'invitation': invitation,
      },
    };
    final result = await GraphQLService.performMutation(
        acceptConnectionMutation, variables);
    return result['connect']['ok'];
  }

  Future<List<Connection>> fetchConnections() async {
    await getConnections();
    return gqlConnections;
  }

  StreamProvider<List<Connection>> connectionStreamProvider() =>
      StreamProvider<List<Connection>>((ref) {
        final stream = GraphQLConfig.client!
            .watchQuery(WatchQueryOptions(
              fetchResults: true,
              document: connectionsQuery,
            ))
            .stream
            .map((event) {
          try {
            final List<dynamic> res = event.data?["connections"]["edges"];
            gqlConnections = res.map((e) {
              final node = e?["node"];
              return Connection.fromJson(node);
            }).toList();
            pageInfo = event.data?["connections"]["pageInfo"];
            return gqlConnections;
          } catch (e) {
            gqlConnections = [];
            pageInfo = {};
            return gqlConnections;
          }
        });
        return stream;
      });
}
