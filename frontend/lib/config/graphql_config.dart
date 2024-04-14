import 'package:frontend/utils/secure_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
  static final GraphQLConfig _instance = GraphQLConfig._();

  GraphQLConfig._();

  factory GraphQLConfig() {
    return _instance;
  }
  static GraphQLClient? client;
  Future<void> createClient() async {
    final String? token = await SecureStorageUtil().getToken();
    if (token == null) {
      throw Exception("The token registered in secure storage is null");
    }
    try {
      final httpLink = HttpLink(baseURL);
      final authLink = AuthLink(getToken: () {
        return 'Bearer $token';
      });
      final wsLink = WebSocketLink("$webSocketLink?access_token=$token",
          config: SocketClientConfig(autoReconnect: true, initialPayload: {
            'header': {'Authorization': 'Bearer $token'}
          }));
      final link = Link.split((request) => request.isSubscription, wsLink,
          authLink.concat(httpLink));
      client = GraphQLClient(
          link: link, cache: GraphQLCache(store: InMemoryStore()));
    } catch (e) {
      throw Exception(e);
    }
  }
}
