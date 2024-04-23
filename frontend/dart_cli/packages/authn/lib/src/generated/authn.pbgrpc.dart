//
//  Generated code. Do not modify.
//  source: authn.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:async' as $async;
import 'dart:core' as $core;

import 'package:grpc/service_api.dart' as $grpc;
import 'package:protobuf/protobuf.dart' as $pb;

import 'authn.pb.dart' as $0;

export 'authn.pb.dart';

@$pb.GrpcServiceName('authn.v1.AuthnService')
class AuthnServiceClient extends $grpc.Client {
  static final _$enter = $grpc.ClientMethod<$0.Cmd, $0.CmdStatus>(
      '/authn.v1.AuthnService/Enter',
      ($0.Cmd value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.CmdStatus.fromBuffer(value));
  static final _$enterSecret = $grpc.ClientMethod<$0.SecretMsg, $0.SecretResult>(
      '/authn.v1.AuthnService/EnterSecret',
      ($0.SecretMsg value) => value.writeToBuffer(),
      ($core.List<$core.int> value) => $0.SecretResult.fromBuffer(value));

  AuthnServiceClient($grpc.ClientChannel channel,
      {$grpc.CallOptions? options,
      $core.Iterable<$grpc.ClientInterceptor>? interceptors})
      : super(channel, options: options,
        interceptors: interceptors);

  $grpc.ResponseStream<$0.CmdStatus> enter($0.Cmd request, {$grpc.CallOptions? options}) {
    return $createStreamingCall(_$enter, $async.Stream.fromIterable([request]), options: options);
  }

  $grpc.ResponseFuture<$0.SecretResult> enterSecret($0.SecretMsg request, {$grpc.CallOptions? options}) {
    return $createUnaryCall(_$enterSecret, request, options: options);
  }
}

@$pb.GrpcServiceName('authn.v1.AuthnService')
abstract class AuthnServiceBase extends $grpc.Service {
  $core.String get $name => 'authn.v1.AuthnService';

  AuthnServiceBase() {
    $addMethod($grpc.ServiceMethod<$0.Cmd, $0.CmdStatus>(
        'Enter',
        enter_Pre,
        false,
        true,
        ($core.List<$core.int> value) => $0.Cmd.fromBuffer(value),
        ($0.CmdStatus value) => value.writeToBuffer()));
    $addMethod($grpc.ServiceMethod<$0.SecretMsg, $0.SecretResult>(
        'EnterSecret',
        enterSecret_Pre,
        false,
        false,
        ($core.List<$core.int> value) => $0.SecretMsg.fromBuffer(value),
        ($0.SecretResult value) => value.writeToBuffer()));
  }

  $async.Stream<$0.CmdStatus> enter_Pre($grpc.ServiceCall call, $async.Future<$0.Cmd> request) async* {
    yield* enter(call, await request);
  }

  $async.Future<$0.SecretResult> enterSecret_Pre($grpc.ServiceCall call, $async.Future<$0.SecretMsg> request) async {
    return enterSecret(call, await request);
  }

  $async.Stream<$0.CmdStatus> enter($grpc.ServiceCall call, $0.Cmd request);
  $async.Future<$0.SecretResult> enterSecret($grpc.ServiceCall call, $0.SecretMsg request);
}
