import 'package:graphql_flutter/graphql_flutter.dart';
import '../config/graphql_config.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

  GraphQLClient client = graphQLConfig.clientToQuery();

final getIdQuery = gql("""
  query {
    user {
      id,
      name,
    }

  }
""");
final invitationQuery = gql("""
  mutation {
      invite {
          id,
          endpoint,
          label,
          raw,
          imageB64
      }
  }
  """);

final queryForQR = gql("""
  mutation {
      invite {
          imageB64
      }
  }
  """);

  Future<Map<String, dynamic>> getQueryResult(dynamic query, Map<String, dynamic> variables) async {

    try {
      QueryResult result = await client.query(
      QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document: query,
        variables: variables
      )
      );
      if (result.hasException) {
        throw Exception(result.exception);
      }
      Map<String, dynamic>? res = result.data;
      if (res == null) {
        return {};
      } else {
        return res;
      }
    }
    catch (error) {
      throw Exception(error);
    }
  }
}