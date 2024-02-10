import 'package:graphql_flutter/graphql_flutter.dart';
import '../character.dart';

import '../graphql_config.dart';

class GraphQLService {
  static GraphQLConfig graphQLConfig = GraphQLConfig();

  GraphQLClient client = graphQLConfig.clientToQuery();

  Future<List<Character>> getCharacters(page, name) async {
    try {
      QueryResult result = await client.query(
        QueryOptions(
          fetchPolicy: FetchPolicy.noCache,
          document: gql("""
            query Query(\$page: Int, \$name: String) {
              characters(page: \$page, filter: { name: \$name }) {
                results {
                  name
                }
              }
            }
            """),
          variables: {"page": page, "name": name},
        ),
      );

      if (result.hasException) {
        throw Exception(result.exception);
      }

      List? res = result.data?['characters']['results'];

      if (res == null || res.isEmpty) {
        return [];
      }

      List<Character> characters =
          res.map((char) => Character.fromMap(char)).toList();

      return characters;
    } catch (error) {
      throw Exception(error);
    }
  }
}
