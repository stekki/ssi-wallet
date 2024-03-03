import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/graphql_service.dart';

import '../models/models.dart';

class ConnectionService {
  late Map<String, dynamic> _result;
  late List<Connection> _gqlConnections;

  Future<Map<String, dynamic>> getConnections() async {
    _result = await GraphQLService().getQueryResult(
      GraphQLService().getConnectionsQuery,
      {},
    );

    _gqlConnections = _result['connections']['nodes']
        .map<Connection>((con) => Connection.fromJson(con))
        .toList();

    return _result;
  }

  Future<List<Connection>> fetchConnections() async {
    await getConnections();
    return _gqlConnections;
  }

  Future<bool> acceptConnection(String? invitation) async {
    final variables = {
      'input': {
        'invitation': invitation,
      },
    };
    final result = await GraphQLService()
        .performMutation(GraphQLService().acceptConnectionMutation, variables);
    //TODO - debug print
    //print(result);
    return result['connect']['ok'];
  }
}

final connectionsFutureProvider = FutureProvider<List<Connection>>(
  (ref) async {
    final connectionService = ConnectionService();
    await connectionService.getConnections();
    await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
    return connectionService.fetchConnections();
  },
);
