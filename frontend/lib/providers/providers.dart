import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/widgets/credential.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../services/graphql_service.dart';

/**
     return await Future.delayed(
        const Duration(seconds: 1),
        () => [
              "Pisshead",
              "Heikki",
              "Janne",
            ]);
 */

Map? result = {};
late List<dynamic> gqlConnections;

void getConnections() async {
  result = await GraphQLService()
      .getQueryResult(GraphQLService().getConnectionsQuery, {});

  gqlConnections = result!['connections']['nodes'];
  print("PRINTINGGGGGG $gqlConnections");
}

final connectionsFutureProvider = FutureProvider<List<dynamic>>(
  (ref) async {
    //getConnections();
    return await Future.delayed(
        const Duration(seconds: 1),
        //() => gqlConnections
        () => [
              "Pisshead",
              "Heikki",
              "Janne",
            ]);
  },
);

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
