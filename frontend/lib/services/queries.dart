import 'package:graphql_flutter/graphql_flutter.dart';

import 'fragments.dart';

final proofsQuery = gql("""
  query GetConnectionProofs(\$id: ID!, \$cursor: String) {
    connection(id: \$id) {
      proofs(last: 3, before: \$cursor) {
        edges {
          ...ProofEdgeFragment
        }
        pageInfo {
          ...PageInfoFragment
        }
      }
    }
  }
  ${proof["edge"]}
  $pageInfo
""");

final messagesQuery = gql("""
  query GetMessages(\$id: ID!, \$cursor: String) {
    connection(id: \$id) {
      messages(last: 5, before: \$cursor) {
        edges {
          ...MessageEdgeFragment
        }
        pageInfo {
          ...PageInfoFragment
        }
      }
    }
  }
  ${message["edge"]}
  $pageInfo
""");

final credentialQuery = gql("""
query GetCredentials(\$cursor: String) {
    credentials(last: 10, before: \$cursor) {
      edges {
        ...CredentialEdgeFragment
      }
      pageInfo {
        ...PageInfoFragment
      }
    }
  }
  ${credential["edge"]}
  $pageInfo
""");

final connectionCredentialQuery = gql("""
query GetConnectionCredentials(\$id: ID!, \$cursor: String) {
    connection(id: \$id) {
      credentials(last: 3, before: \$cursor) {
        edges {
          ...CredentialEdgeFragment
        }
        pageInfo {
          ...PageInfoFragment
        }
      }
    }
  }
  ${credential["edge"]}
  $pageInfo
""");

final jobsQuery = gql("""
  query GetJobs(\$cursor: String) {
    jobs(last: 2, before: \$cursor) {
      edges {
        ...JobEdgeFragment
      }
      pageInfo {
        ...PageInfoFragment
      }
    }
  }
  ${job["edge"]}
  $pageInfo
""");

final connectionJobsQuery = gql("""
  query GetConnectionJobs(\$id: ID!, \$cursor: String) {
    connection(id: \$id) {
      jobs(last: 3, before: \$cursor) {
        edges {
          ...JobEdgeFragment
        }
        pageInfo {
          ...PageInfoFragment
        }
      }
    }
  }
  ${job["edge"]}
  $pageInfo
""");

final eventsQuery = gql("""
  query GetEvents(\$cursor: String) {
    events(last: 5, before: \$cursor) {
      edges {
        ...EventEdgeFragment
      }
      pageInfo {
        ...PageInfoFragment
      }
    }
  }
  ${event["edge"]}
  $pageInfo
""");

final connectionEventsQuery = gql("""
  query GetConnectionEvents(\$id: ID!, \$cursor: String) {
    connection(id: \$id) {
      events(last: 3, before: \$cursor) {
        edges {
          ...EventEdgeFragment
        }
        pageInfo {
          ...PageInfoFragment
        }
      }
    }
  }
  ${event["edge"]}
  $pageInfo
""");

final resumeJobMutation = gql("""
  mutation ResumeJob(\$input: ResumeJobInput!) {
    resume(input: \$input) {
      ok
    }
  }
""");

final sendMessageMutation = gql("""
  mutation SendMessage(\$input: MessageInput!) {
    sendMessage(input: \$input) {
      ok
    }
  }
""");

final markEventReadMutation = gql("""
  mutation MarkEventRead(\$input: MarkReadInput!) {
    markEventRead(input: \$input) {
      ...EventNodeFragment
    }
  }
  ${event["node"]}
""");

final connectionQuery = gql("""
  query GetConnection(\$id: ID!, \$cursor: String) {
    connection(id: \$id) {
      ...PairwiseNodeFragment
      events(last: 20, before: \$cursor) {
        edges {
          ...FullEventEdgeFragment
        }
        pageInfo {
          ...PageInfoFragment
        }
      }
    }
  }
  ${event["fullEdge"]}
  $pageInfo
""");

final invitationMutation = gql("""
  mutation Invitation {
    invite {
      id,
      endpoint,
      label,
      raw,
      imageB64
    }
  }
""");

final connectionMutation = gql("""
  mutation Connect(\$input: ConnectInput!) {
    connect(input: \$input) {
      ok
    }
  }
""");

final connectionsQuery = gql("""
query GetConnections(\$cursor: String) {
    connections(last: 10, before: \$cursor) {
      edges {
        ...PairwiseEdgeFragment
      }
      pageInfo {
        ...PageInfoFragment
      }
    }
  }
  ${pairwise["edge"]}
  $pageInfo
""");
