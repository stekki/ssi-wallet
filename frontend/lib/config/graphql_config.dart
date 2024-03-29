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

  static var httpLink = HttpLink(baseURL, defaultHeaders: {'Authorization': 'Bearer $token'});

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
  

  static dynamic relayMerge(
      dynamic existing, dynamic incoming, FieldFunctionOptions options) {
    if (incoming == null ||
        incoming["edges"] == null ||
        incoming["pageInfo"] == null) {
      return existing;
    }
    if (existing == null) {
      return incoming;
    }
    dynamic merged = existing;
    merged["__typename"] = merged["__typename"] ?? incoming["__typename"];
    final cursores = merged["edges"].map((e) => e["cursor"]);
    final Map<String, dynamic> incPageInfo = incoming["pageInfo"];
    final bool containStart = cursores.contains(incPageInfo["startCursor"]);
    final bool containEnd = cursores.contains(incPageInfo["endCursor"]);
    if (containStart) {
      if (containEnd) {
        return existing;
      } else {
        final i = incoming["edges"].indexWhere(
            (e) => e["cursor"] == existing["pageInfo"]["endCursor"]);
        merged["edges"] = merged["edges"] + incoming["edges"].sublist(i + 1);
        merged["pageInfo"]["endCursor"] = incPageInfo["endCursor"];
        merged["pageInfo"]["hasNextPage"] = incPageInfo["hasNextPage"];
      }
    } else {
      if (containEnd) {
        final i = incoming["edges"].indexWhere(
            (e) => e["cursor"] == existing["pageInfo"]["startCursor"]);
        merged["edges"] = incoming["edges"].sublist(0, i) + merged["edges"];
        merged["pageInfo"]["startCursor"] = incPageInfo["startCursor"];
        merged["pageInfo"]["hasPreviousPage"] = incPageInfo["hasPreviousPage"];
      } else {
        return incoming;
      }
    }
    return merged;
  }

  static final FieldPolicy relayPolicy = FieldPolicy(
    merge: (existing, incoming, options) =>
        relayMerge(existing, incoming, options),
  );
  final GraphQLCache cache = GraphQLCache(
    store: InMemoryStore(),
    typePolicies: {
      "Pairwise": TypePolicy(
        keyFields: {},
        fields: {
          "messages": relayPolicy,
          "credentials": relayPolicy,
          "proofs": relayPolicy,
          "jobs": relayPolicy,
          "events": relayPolicy
        },
      ),
      "Query": TypePolicy(
          keyFields: {},
          queryType: true,
          fields: {
            "events": relayPolicy,
            "connections": relayPolicy,
            "credentials": relayPolicy,
            "jobs": relayPolicy,
            "connection": FieldPolicy(
              merge: (existing, incoming, options) {
                if (existing == null) {
                  return incoming;
                } else {
                  final mergedData = existing;
                  for (final key in incoming.keys) {
                    if (!mergedData.containsKey(key)) {
                      mergedData[key] = incoming[key];
                    }
                  }
                  return mergedData;
                }
              },
            )
            // "activeConnectionName": FieldPolicy()
          })
    },
  );

  GraphQLClient clientToQuery() => GraphQLClient(
        cache: cache,
        link: _link,
      );
}
