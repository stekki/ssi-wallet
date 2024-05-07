# Credi - SSI Wallet App

This SSI Wallet app is a Flutter-based mobile application designed to leverage self-sovereign identity capabilities. It uses [**Findy Agency**](https://github.com/findy-network) as its backend service to handle identity operations and GraphQL for efficient data querying and management. This app enables users to securely manage their digital credentials.

## Features
* Making pairwise connections via invitation link or QR code (code scanning tested with Chrome/iOS/macOS)
* Authenticacion with custom Dart CLI package (works on Linux Desktop build only so far, sandboxing must be disabled to work on macOS)
* Messaging between Findy agents
* Proof request functionality
  * [**Findy Issuer Tool**](https://github.com/findy-network/findy-issuer-tool) is required to first issue a credential to an agent
  * Not fully supported by UI, e.g text displayed in the proof request for receipts is not correct (state management issue)

## Getting Started

### Prequisites

* Flutter >= 3.22.0-0.1.pre • channel beta
* Dart SDK >= 3.4.0 (build 3.4.0-282.1.beta)
* [Findy Agency CLI tools](https://github.com/findy-network/findy-agent-cli)
* (Optional) Docker for hosting the backend services locally

### Installation

1. Setup Flutter, Dart SDK and Findy Agency CLI (see [Installation](https://github.com/findy-network/findy-agent-cli?tab=readme-ov-file#installation))

2. Clone the repository `git clone https://github.com/stekki/ssi-wallet`

3. Get dependencies `flutter pub get`

### Running the App

1. `cd scripts`

2. `./run.sh` or `source run-as-user.sh <username> <findy|local>`
---
**NOTE:**
if you are using `run.sh` you must make sure that:

1. Correct GraphQL endpoint is set in `frontend/lib/config/graphql_config.dart` on line 4 `const baseURL = <URL>` such as `https://findy-agency.op-ai.fi/query` for cloud or `http://localhost:8085/query` for locally deployed Findy Agency
2. Correct [dart_cli configuration](https://github.com/lainio/dart_cli?tab=readme-ov-file#configurations) is used

or if you are using `run-as-user.sh` you must copy the JWT token from the terminal output and sign-in using dev option in the bottom right corner. Most errors are fixed by starting with fresh username from new shell session. Make sure that your `cli-env` variables are correctly set

### Other

* Under `tools` run `./pull-cli-tools.sh` to clone the latest `findy-agent-cli` repository to the project
* Under `sripts` run `source .setup-cli-env-findy.sh` or `source .setup-cli-env-local.sh` to setup Findy environment for your shell session
* You can run Findy backend microservices locally using Docker. One way to do this is to clone the `findy-agent-cli` navigate to `findy-agent-cli/scripts/fullstack/` and run
  `make pull-up`. Also make sure that your Docker daemon is running (`systemctl start docker` on Linux)
* The `host_address` parameter should be updated to the IP address or hostname of a machine within your local network that is running the Findy Agency backend (default `localhost`)

## Thanks to
* OP Lab team for providing the [backend infrastructure](https://github.com/findy-network)
* Other developers behind open-source package and libraries that are used in this project :)


