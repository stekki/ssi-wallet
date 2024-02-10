import 'package:graphql_flutter/graphql_flutter.dart';

/*
const String _token = '';
const String _baseUrl = 'https://api.github.com/graphql';

class GraphQLConfig {
  static final GraphQLConfig _instance = GraphQLConfig._();

  GraphQLConfig._();

  factory GraphQLConfig() {
    return _instance;
  }

  late final GraphQLClient client;

  final Link _httpLink = HttpLink(_baseUrl);

  final Link _authLink = AuthLink(getToken: () {
    return _token;
  });

  final GraphQLCache cache = GraphQLCache();

  init() {
    client = GraphQLClient(
        link: _authLink.concat(_httpLink),
        cache: cache,
        defaultPolicies: DefaultPolicies(
            query: Policies.safe(FetchPolicy.cacheAndNetwork, ErrorPolicy.none,
                CacheRereadPolicy.ignoreOptimisitic)));
  }
}
*/

const String _token = '';
const String _baseUrl = "https://rickandmortyapi.com/graphql";

class GraphQLConfig {
  static final GraphQLConfig _instance = GraphQLConfig._();

  GraphQLConfig._();

  factory GraphQLConfig() {
    return _instance;
  }

  final Link _authLink = AuthLink(getToken: () {
    return _token;
  });

  final HttpLink _httpLink = HttpLink(_baseUrl);

  GraphQLClient clientToQuery() =>
      GraphQLClient(link: _authLink.concat(_httpLink), cache: GraphQLCache());
}
