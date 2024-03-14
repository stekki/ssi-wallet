import 'package:frontend/services/queries.dart';
import 'dart:developer';
import 'graphql_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'fragments.dart';

class EventNotification {
  static final EventNotification _instance = EventNotification._();

  EventNotification._();

  factory EventNotification() {
    return _instance;
  }
  static GraphQLClient client = GraphQLService().client;
  static final subscriptionDocument = gql("""
  subscription OnEventAdded {
    eventAdded {
      ...FullEventEdgeFragment
    }
  }
  ${event["fullEdge"]}
  """);

  static String getItemType(String itemName) {
    switch (itemName) {
      case "connections":
        return "PairwiseConnection";
      case "proofs":
        return "ProofConnection";
      case "credentials":
        return "CredentialConnection";
      case "messages":
        return "BasicMessageConnection";
      case "events":
        return "EventConnection";
      case "jobs":
        return "JobConnection";
      default:
        // Handle the case when itemName doesn't match any of the specified values
        throw Exception("Unknown itemName: $itemName");
    }
  }

  static Map<String, dynamic>? stateWithNewItem(Map<String, dynamic> prevState,
      String itemName, Map<String, dynamic> newItem, bool last) {
    final itemType = getItemType(itemName);
    final Map<String, dynamic> state =
        prevState.isNotEmpty && prevState.containsKey(itemName)
            ? prevState
            : {
                itemName: {
                  "__typename": itemType,
                  "edges": [],
                  "pageInfo": <String, dynamic>{"__typename": "PageInfo"}
                }
              };
    final items = state[itemName];
    if (newItem.isEmpty ||
        items["edges"]
            .any((element) => element["node"]["id"] == newItem["node"]["id"])) {
      return {"state": state, "updated": false};
    }
    if (last) {
      items["pageInfo"]["endCursor"] = newItem["cursor"];
    } else {
      items["pageInfo"]["startCursor"] = newItem["cursor"];
    }
    if (prevState.isEmpty) {
      items["pageInfo"]["startCursor"] = newItem["cursor"];
      items["pageInfo"]["endCursor"] = newItem["cursor"];
      items["pageInfo"]["hasPreviousPage"] = false;
      items["pageInfo"]["hasNextPage"] = false;
    }
    final List<dynamic> updatedEdges = items["edges"];
    updatedEdges.add(newItem);
    return {
      "state": {
        itemName: {
          "__typename": itemType,
          "edges": updatedEdges,
          "pageInfo": items["pageInfo"]
        }
      },
      "updated": true
    };
  }

  static void updateState(
    Map<String, dynamic> prevState,
    String itemName,
    Map<String, dynamic> newItem,
    bool last,
    String parentName,
    Map<dynamic, dynamic> query,
  ) {
    final newState = stateWithNewItem(prevState, itemName, newItem, last);
    final queryRequest = Request(
        operation: Operation(document: query["query"]),
        variables: query["variables"]);
    if (newState?["updated"]) {
      if (parentName == "") {
        final wsState = {
          "__typename": "Query",
          itemName: newState?["state"][itemName]
        };
        client.writeQuery(queryRequest, data: wsState);
      } else {
        final wState = {
          "__typename": "Query",
          "connection": {
            "__typename": "Pairwise",
            itemName: newState?["state"][itemName]
          }
        };
        client.writeQuery(queryRequest, data: wState);
      }
    }
  }

  static void updateCacheWithNewItem(
    String itemName,
    Map<String, dynamic> newItem,
    bool last,
    String parentName,
    Map<dynamic, dynamic> query,
  ) {
    final queryRequest = Request(
        operation: Operation(document: query["query"]),
        variables: query["variables"]);
    dynamic state = client.readQuery(queryRequest);
    if (state == null) {
      updateState({}, itemName, newItem, last, parentName, query);
      return;
    }
    final items =
        (parentName == "") ? state[itemName] : state[parentName][itemName];
    if (!items["pageInfo"]["hasNextPage"]) {
      (parentName == "")
          ? updateState(state, itemName, newItem, last, parentName, query)
          : updateState(
              state[parentName], itemName, newItem, last, parentName, query);
    }
  }

  static void updateProtocolItem(
      String connectionID, Map<String, dynamic> jobEdge) {
    final job = jobEdge["node"];
    updateCacheWithNewItem("jobs", jobEdge, true, "connection", {
      "query": connectionJobsQuery,
      "variables": {"id": connectionID}
    });
    if (job["protocol"] == "CONNECTION" &&
        (job["output"]["connection"] != null)) {
      updateCacheWithNewItem(
          "connections",
          job["output"]["connection"],
          true,
          '',
          {"query": connectionsQuery, "variables": const <String, dynamic>{}});
    } else if (job["protocol"] == "BASIC_MESSAGE" &&
        (job["output"]["message"] != null)) {
      updateCacheWithNewItem(
          "messages", job["output"]["message"], true, "connection", {
        "query": messagesQuery,
        "variables": {"id": connectionID}
      });
    } else if (job["protocol"] == "CREDENTIAL" &&
        (job["output"]["credential"] != null) &&
        (job["status"] == "COMPLETE") &&
        (job["result"] == "SUCCESS")) {
      updateCacheWithNewItem(
          "credentials",
          job["output"]["credential"],
          true,
          "",
          {"query": credentialQuery, "variables": const <String, dynamic>{}});
      updateCacheWithNewItem(
          "credentials", job["output"]["credential"], true, "connection", {
        "query": connectionCredentialQuery,
        "variables": {"id": connectionID}
      });
    } else if (job["protocol"] == "PROOF" &&
        (job["output"]["proof"] != null) &&
        (job["status"] == "COMPLETE") &&
        (job["result"] == "SUCCESS")) {
      updateCacheWithNewItem(
          "proofs", job["output"]["proof"], true, "connection", {
        "query": proofsQuery,
        "variables": {"id": connectionID}
      });
    }
  }

  static void updateSubScription(Map<dynamic, dynamic>? data) {
    if (data == null) {
      log('Subscription: No data');
      return;
    }
    final prevEventState = client
            .readQuery(Request(operation: Operation(document: eventsQuery))) ??
        {};
    final newState =
        stateWithNewItem(prevEventState, "events", data["eventAdded"], true);
    if (newState?["updated"]) {
      final eventAdded = data["eventAdded"];
      final node = data["eventAdded"]["node"];
      final connection = data["eventAdded"]["node"]["connection"];
      if (connection != null) {
        updateCacheWithNewItem("events", eventAdded, true, "connection", {
          "query": connectionEventsQuery,
          "variables": {"id": connection["id"]}
        });
      }
      if (node["job"] != null) {
        updateCacheWithNewItem("jobs", node["job"], true, "",
            {"query": jobsQuery, "variables": const <String, dynamic>{}});
        if (connection != null) {
          updateProtocolItem(connection["id"], node["job"]);
        }
      }
    }
  }

  final subscription = client
      .subscribe(SubscriptionOptions(document: subscriptionDocument))
      .listen((event) {
    updateSubScription(event.data);
  });
}
