import 'package:graphql_flutter/graphql_flutter.dart';

    const token = String.fromEnvironment('TOKEN');
    const baseURL = String.fromEnvironment('BASE_URL');
    var httpLink = HttpLink(baseURL,
        defaultHeaders: {'Authorization': 'Bearer $token'});

class GraphQLConfig {

  GraphQLClient clientToQuery() =>
      GraphQLClient(
        cache: GraphQLCache(),
        link: httpLink,
      );
}