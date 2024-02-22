import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/connection_service.dart';
import 'package:frontend/widgets/credential.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/graphql_service.dart';
import '../Models/models.dart';

Map? result = {};
List<Connection> gqlConnections = [];

void getConnections() async {
  result = await GraphQLService()
      .getQueryResult(GraphQLService().getConnectionsQuery, {});

  for (var con in result!['connections']['nodes']) {
    gqlConnections.add(Connection.fromJson(con));
  }
}

final connectionServiceProvider = Provider((ref) => ConnectionService());

final credentialsFutureProvider = FutureProvider<List<Credential>>(
  (ref) async {
    return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              Credential(name: "Verkkokauppa"),
              Credential(name: "Aalto University"),
              Credential(name: "Findy Agency"),
            ]);
  },
);
