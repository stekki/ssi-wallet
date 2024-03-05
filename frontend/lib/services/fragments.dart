const pairwiseNodeFragment = """
  fragment PairwiseNodeFragment on Pairwise {
    id
    ourDid
    theirDid
    theirEndpoint
    theirLabel
    createdMs
    approvedMs
    invited
  }
""";

final pairwise = {
  "node": pairwiseNodeFragment,
  "edge": """
    fragment PairwiseEdgeFragment on PairwiseEdge {
      cursor
      node {
        ...PairwiseNodeFragment
      }
    }
    $pairwiseNodeFragment
  """
};

// events(last: 1) {
//   nodes {
//     read
//   }
// }

const credentialNodeFragment = """
  fragment CredentialNodeFragment on Credential {
    id
    role
    schemaId
    credDefId
    attributes {
      id
      name
      value
    }
    initiatedByUs
    createdMs
    approvedMs
    issuedMs
  }
""";

final credential = {
  "node": credentialNodeFragment,
  "edge": """
    fragment CredentialEdgeFragment on CredentialEdge {
      cursor
      node {
        ...CredentialNodeFragment
      }
    }
    $credentialNodeFragment
  """
};

const proofNodeFragment = """
  fragment ProofNodeFragment on Proof {
    id
    role
    attributes {
      id
      name
      credDefId
    }
    initiatedByUs
    result
    createdMs
    approvedMs
    verifiedMs
    values {
      attributeId
      value
    }
  }
  """;

final proof = {
  "node": proofNodeFragment,
  "edge": """
    fragment ProofEdgeFragment on ProofEdge {
      cursor
      node {
        ...ProofNodeFragment
      }
    }
    $proofNodeFragment
  """
};

const messageNodeFragment = """
  fragment MessageNodeFragment on BasicMessage {
    id
    message
    sentByMe
    delivered
    createdMs
  }
""";

final message = {
  "node": messageNodeFragment,
  "edge": """
    fragment MessageEdgeFragment on BasicMessageEdge {
      cursor
      node {
        ...MessageNodeFragment
      }
    }
    $messageNodeFragment
  """
};

final jobNodeFragment = """
  fragment JobNodeFragment on Job {
    id
    protocol
    initiatedByUs
    status
    result
    createdMs
    updatedMs
    output {
      connection {
        ...PairwiseEdgeFragment
      }
      message {
        ...MessageEdgeFragment
      }
      credential {
        ...CredentialEdgeFragment
      }
      proof {
        ...ProofEdgeFragment
      }
    }
  }
  ${pairwise["edge"]}
  ${message["edge"]}
  ${credential["edge"]}
  ${proof["edge"]}
""";

final job = {
  "node": jobNodeFragment,
  "edge": """
    fragment JobEdgeFragment on JobEdge {
      node {
        ...JobNodeFragment
      }
      cursor
    }
    $jobNodeFragment
  """
};

const eventNodeFragment = """
  fragment EventNodeFragment on Event {
    id
    read
    description
    createdMs
    connection {
      id
      theirLabel
    }
  }
""";

final fullEventNodeFragment = """
  fragment FullEventNodeFragment on Event {
    ...EventNodeFragment
    job {
      ...JobEdgeFragment
    }
  }
  $eventNodeFragment
  ${job["edge"]}
""";

final event = {
  "node": eventNodeFragment,
  "fullNode": fullEventNodeFragment,
  "edge": """
    fragment EventEdgeFragment on EventEdge {
      cursor
      node {
        ...EventNodeFragment
      }
    }
    $eventNodeFragment
  """,
  "fullEdge": """
    fragment FullEventEdgeFragment on EventEdge {
      cursor
      node {
        ...FullEventNodeFragment
      }
    }
    $fullEventNodeFragment
  """
};
const pageInfo = """
  fragment PageInfoFragment on PageInfo {
    endCursor
    startCursor
    hasPreviousPage
    hasNextPage
  }
""";
