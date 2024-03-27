import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:ferry/ferry.dart';

const token = String.fromEnvironment('TOKEN');
const baseURL = String.fromEnvironment('BASE_URL');

String initializeWsLink() {
  if (baseURL.startsWith('https://')) {
    return 'wss://${baseURL.substring(8)}';
  } else if (baseURL.startsWith('http://')) {
    return 'ws://${baseURL.substring(7)}';
  } else {
    throw Exception('URL must start with either http or https');
  }
}

final webSocketLink = initializeWsLink();

class GraphQLConfig {
  static var httpLink =
      HttpLink(baseURL, defaultHeaders: {'Authorization': 'Bearer $token'});

  static final GraphQLConfig _instance = GraphQLConfig._();

  GraphQLConfig._();

  factory GraphQLConfig() {
    return _instance;
  }

  static final _wsLink = WebSocketLink("$webSocketLink?access_token=$token",
      config: const SocketClientConfig(autoReconnect: true, initialPayload: {
        'header': {'Authorization': 'Bearer $token'}
      }));

  static final Link _authLink = AuthLink(getToken: () {
    return 'Bearer $token';
  });
  static final HttpLink _httpLink = HttpLink(baseURL);
  final _link = Link.split((request) => request.isSubscription, _wsLink,
      _authLink.concat(_httpLink));

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: GraphQLCache(store: InMemoryStore()),
        link: _link,
      );
}
