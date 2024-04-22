### Generated Prefix

A sample command-line application with an entrypoint in `bin/`, library code
in `lib/`, and example unit test in `test/`.

# Authn Package

The actual package is in `packages/authn`. To use it add following to your
`dependencies:` section in the `pupspec.yaml` file.

```
  authn:
    path: packages/authn
```

See the [example file](./pubspec.yaml).

## Run CLI

Until you know where you gRPC translator to WebAuthn is up and running you enter
something like this to the command-line in the repo's root:

```shell
dart bin/cli.dart login elli200 10 cfg.yaml
dart bin/cli.dart login elli200 10
```

## Flutter Usage

The Authn package works with the Flutter as well. However, your deployment
bundle and your target OS defines how you should use and configure the Authn
package. The current version is tested with the desktop implementations for
Flutter and CLI version for pure Dart (this repo).

For the Flutter update your `dependencies:` with the relative path:

```
  authn:
    path: ../dart_cli/packages/authn
```

Note the prefix `../dart_cli/`, relative path, could absolute but makes life
easier when playing with others. However, when the Authn package is mature
enough it will get it's own repo and maybe even be registered into package
manager.

## Configurations

The current implementation uses YAML files for package Configurations. If you're
targeting mobile OS, you probably prefer something else like installation
bundle. Same goes with the mTLS certification files. You can use Flutter to read
both of those informations from bundle. See the documentation, you can google,
can you?

Happy coding!

# Appendix

## Configuration File Example

```yaml
---
keyFile: /home/.../github.com/.../client.key
certFile: /home/.../github.com/.../client.crt
salt: 99
address: localhost
port: 50051
url: http://localhost:8090
aaguid: 12.....8-4..f-47.d-..1f-f192871a1511
```

### Explanations:

```yaml
---
keyFile: <tls-client-key-file> # see other documentation
certFile: <tls-client-cert-file> # see other documentation
salt: NN # two digit security salt
address: <grpc-service-addr>
port: <grpc-port>
url: <FIDO2-server-URL> # e.g. http://localhost:8090
aaguid: <your-authenticators-UUID> # just generate and keep the same
```
