import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/services/graphql_service.dart';
import 'package:frontend/services/queries.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class JobService {
  static final JobService _instance = JobService._();
  JobService._();
  factory JobService() {
    return _instance;
  }
  static QueryResult? fullResult;
  static List<Map<String, dynamic>> gqlJobs = [];
  static Map<String, dynamic> pageInfo = {};

  Future<void> getJobs(String connectionID) async {
    try {
      await GraphQLService().getQueryResult(
        connectionQuery,
        {'id': connectionID},
      );
    } catch (e) {
      throw Exception(e);
    }
  }

  final jobStreamProvider =
      StreamProvider.family<List<Map<String, dynamic>>, String>(
          (ref, connectionID) {
    final stream = GraphQLService()
        .client
        .watchQuery(
          WatchQueryOptions(
            fetchResults: true,
            document: connectionJobsQuery,
            variables: {'id': connectionID},
          ),
        )
        .stream
        .map((job) {
      try {
        fullResult = job;
        final List<dynamic> res = job.data?["connection"]["jobs"]["edges"];
        gqlJobs = res.map((e) {
          final Map<String, dynamic> node = e?["node"];
          return node;
        }).toList();
        pageInfo = job.data?["connection"]["jobs"]["pageInfo"];
        return gqlJobs;
      } catch (e) {
        fullResult = null;
        gqlJobs = [];
        pageInfo = {};
        return gqlJobs;
        //throw Exception("No data returned");
      }
    });
    return stream;
  });
}
