import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/graphql_service.dart';
import 'package:frontend/services/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../models/models.dart';

class ConnectionService {
  late Map<String, dynamic> _result;
  late Map<String, dynamic> _boolResult;
  late List<Connection> _gqlConnections;

  Future<Map<String, dynamic>> getConnections() async {
    _result = await GraphQLService().getQueryResult(
      connectionsQuery,
      {},
    );

    try {
      final List<dynamic> res = _result["connections"]["edges"];
      _gqlConnections = res.map((e) {
        final node = e?["node"];
        return Connection.fromJson(node);
      }).toList();
    } catch (e) {
      _gqlConnections = <Connection>[];
    }
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

  Future<bool> getInviter(String nodeID) async {
    try {
      _boolResult = await GraphQLService().getInviterByNodeId(nodeID);
      return _boolResult['connection']['invited'];
    } catch (e) {
      return false;
    }
  }
}


final connectionsFutureProvider = FutureProvider<List<Connection>>(
  (ref) async {
    // mock data for those who can't work with the backend
    /*
    const connection = Connection(
      id: "111",
      ourDid: "111",
      theirDid: "2222",
      theirEndpoint: "ewtert",
      theirLabel: "Bob",
      createdMs: "1232531251",
      approvedMs: "sdgd",
      invited: true,
    );
    */
    // These lines call the query twice, should it be kept ?
    final connectionService = ConnectionService();
    await connectionService.getConnections();
    await Future.delayed(const Duration(seconds: 1)); // Wait for 1 second
    return connectionService.fetchConnections();
  },
);

final connectionStreamProvider = StreamProvider<List<Connection>>((ref) {
  final stream = GraphQLService()
      .client
      .watchQuery(WatchQueryOptions(
        fetchResults: true,
        document: connectionsQuery,
      ))
      .stream
      .map((event) {
    try {
      final List<dynamic> res = event.data?["connections"]["edges"];
      final List<Connection> connections = res.map((e) {
        final node = e?["node"];
        return Connection.fromJson(node);
      }).toList();
      return connections;
    } catch (e) {
      return <Connection>[];
    }
  });
  return stream;
});
