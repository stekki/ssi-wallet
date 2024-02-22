import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/graphql_service.dart';

import '../Models/models.dart';

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
}

final connectionsFutureProvider = FutureProvider<List<Connection>>(
  (ref) async {
    final connectionService = ConnectionService();
    await connectionService.getConnections();
    await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
    return connectionService.fetchConnections();
  },
);
