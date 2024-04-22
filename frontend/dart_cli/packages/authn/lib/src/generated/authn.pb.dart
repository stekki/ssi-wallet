//
//  Generated code. Do not modify.
//  source: authn.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:core' as $core;

import 'package:fixnum/fixnum.dart' as $fixnum;
import 'package:protobuf/protobuf.dart' as $pb;

import 'authn.pbenum.dart';

export 'authn.pbenum.dart';

class SecretMsg_ErrorMsg extends $pb.GeneratedMessage {
  factory SecretMsg_ErrorMsg({
    $core.String? info,
  }) {
    final $result = create();
    if (info != null) {
      $result.info = info;
    }
    return $result;
  }
  SecretMsg_ErrorMsg._() : super();
  factory SecretMsg_ErrorMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecretMsg_ErrorMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SecretMsg.ErrorMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'info')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecretMsg_ErrorMsg clone() => SecretMsg_ErrorMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecretMsg_ErrorMsg copyWith(void Function(SecretMsg_ErrorMsg) updates) => super.copyWith((message) => updates(message as SecretMsg_ErrorMsg)) as SecretMsg_ErrorMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecretMsg_ErrorMsg create() => SecretMsg_ErrorMsg._();
  SecretMsg_ErrorMsg createEmptyInstance() => create();
  static $pb.PbList<SecretMsg_ErrorMsg> createRepeated() => $pb.PbList<SecretMsg_ErrorMsg>();
  @$core.pragma('dart2js:noInline')
  static SecretMsg_ErrorMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SecretMsg_ErrorMsg>(create);
  static SecretMsg_ErrorMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get info => $_getSZ(0);
  @$pb.TagNumber(1)
  set info($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasInfo() => $_has(0);
  @$pb.TagNumber(1)
  void clearInfo() => clearField(1);
}

class SecretMsg_EnclaveMsg extends $pb.GeneratedMessage {
  factory SecretMsg_EnclaveMsg({
    $core.List<$core.int>? credID,
  }) {
    final $result = create();
    if (credID != null) {
      $result.credID = credID;
    }
    return $result;
  }
  SecretMsg_EnclaveMsg._() : super();
  factory SecretMsg_EnclaveMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecretMsg_EnclaveMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SecretMsg.EnclaveMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, _omitFieldNames ? '' : 'credID', $pb.PbFieldType.OY, protoName: 'credID')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecretMsg_EnclaveMsg clone() => SecretMsg_EnclaveMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecretMsg_EnclaveMsg copyWith(void Function(SecretMsg_EnclaveMsg) updates) => super.copyWith((message) => updates(message as SecretMsg_EnclaveMsg)) as SecretMsg_EnclaveMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecretMsg_EnclaveMsg create() => SecretMsg_EnclaveMsg._();
  SecretMsg_EnclaveMsg createEmptyInstance() => create();
  static $pb.PbList<SecretMsg_EnclaveMsg> createRepeated() => $pb.PbList<SecretMsg_EnclaveMsg>();
  @$core.pragma('dart2js:noInline')
  static SecretMsg_EnclaveMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SecretMsg_EnclaveMsg>(create);
  static SecretMsg_EnclaveMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get credID => $_getN(0);
  @$pb.TagNumber(1)
  set credID($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCredID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCredID() => clearField(1);
}

class SecretMsg_HandleMsg extends $pb.GeneratedMessage {
  factory SecretMsg_HandleMsg({
    $fixnum.Int64? iD,
    $core.List<$core.int>? data,
    $core.List<$core.int>? sign,
  }) {
    final $result = create();
    if (iD != null) {
      $result.iD = iD;
    }
    if (data != null) {
      $result.data = data;
    }
    if (sign != null) {
      $result.sign = sign;
    }
    return $result;
  }
  SecretMsg_HandleMsg._() : super();
  factory SecretMsg_HandleMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecretMsg_HandleMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SecretMsg.HandleMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..aInt64(1, _omitFieldNames ? '' : 'ID', protoName: 'ID')
    ..a<$core.List<$core.int>>(2, _omitFieldNames ? '' : 'data', $pb.PbFieldType.OY)
    ..a<$core.List<$core.int>>(3, _omitFieldNames ? '' : 'sign', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecretMsg_HandleMsg clone() => SecretMsg_HandleMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecretMsg_HandleMsg copyWith(void Function(SecretMsg_HandleMsg) updates) => super.copyWith((message) => updates(message as SecretMsg_HandleMsg)) as SecretMsg_HandleMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecretMsg_HandleMsg create() => SecretMsg_HandleMsg._();
  SecretMsg_HandleMsg createEmptyInstance() => create();
  static $pb.PbList<SecretMsg_HandleMsg> createRepeated() => $pb.PbList<SecretMsg_HandleMsg>();
  @$core.pragma('dart2js:noInline')
  static SecretMsg_HandleMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SecretMsg_HandleMsg>(create);
  static SecretMsg_HandleMsg? _defaultInstance;

  @$pb.TagNumber(1)
  $fixnum.Int64 get iD => $_getI64(0);
  @$pb.TagNumber(1)
  set iD($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasID() => $_has(0);
  @$pb.TagNumber(1)
  void clearID() => clearField(1);

  @$pb.TagNumber(2)
  $core.List<$core.int> get data => $_getN(1);
  @$pb.TagNumber(2)
  set data($core.List<$core.int> v) { $_setBytes(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasData() => $_has(1);
  @$pb.TagNumber(2)
  void clearData() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<$core.int> get sign => $_getN(2);
  @$pb.TagNumber(3)
  set sign($core.List<$core.int> v) { $_setBytes(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSign() => $_has(2);
  @$pb.TagNumber(3)
  void clearSign() => clearField(3);
}

enum SecretMsg_Info {
  err, 
  enclave, 
  handle, 
  notSet
}

/// SecretMsg tells how proceed after CmdStatus has been received.
class SecretMsg extends $pb.GeneratedMessage {
  factory SecretMsg({
    $fixnum.Int64? cmdID,
    SecretMsg_Type? type,
    SecretMsg_ErrorMsg? err,
    SecretMsg_EnclaveMsg? enclave,
    SecretMsg_HandleMsg? handle,
  }) {
    final $result = create();
    if (cmdID != null) {
      $result.cmdID = cmdID;
    }
    if (type != null) {
      $result.type = type;
    }
    if (err != null) {
      $result.err = err;
    }
    if (enclave != null) {
      $result.enclave = enclave;
    }
    if (handle != null) {
      $result.handle = handle;
    }
    return $result;
  }
  SecretMsg._() : super();
  factory SecretMsg.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecretMsg.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, SecretMsg_Info> _SecretMsg_InfoByTag = {
    3 : SecretMsg_Info.err,
    4 : SecretMsg_Info.enclave,
    5 : SecretMsg_Info.handle,
    0 : SecretMsg_Info.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SecretMsg', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..oo(0, [3, 4, 5])
    ..aInt64(1, _omitFieldNames ? '' : 'cmdID', protoName: 'cmdID')
    ..e<SecretMsg_Type>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: SecretMsg_Type.ERROR, valueOf: SecretMsg_Type.valueOf, enumValues: SecretMsg_Type.values)
    ..aOM<SecretMsg_ErrorMsg>(3, _omitFieldNames ? '' : 'err', subBuilder: SecretMsg_ErrorMsg.create)
    ..aOM<SecretMsg_EnclaveMsg>(4, _omitFieldNames ? '' : 'enclave', subBuilder: SecretMsg_EnclaveMsg.create)
    ..aOM<SecretMsg_HandleMsg>(5, _omitFieldNames ? '' : 'handle', subBuilder: SecretMsg_HandleMsg.create)
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecretMsg clone() => SecretMsg()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecretMsg copyWith(void Function(SecretMsg) updates) => super.copyWith((message) => updates(message as SecretMsg)) as SecretMsg;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecretMsg create() => SecretMsg._();
  SecretMsg createEmptyInstance() => create();
  static $pb.PbList<SecretMsg> createRepeated() => $pb.PbList<SecretMsg>();
  @$core.pragma('dart2js:noInline')
  static SecretMsg getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SecretMsg>(create);
  static SecretMsg? _defaultInstance;

  SecretMsg_Info whichInfo() => _SecretMsg_InfoByTag[$_whichOneof(0)]!;
  void clearInfo() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get cmdID => $_getI64(0);
  @$pb.TagNumber(1)
  set cmdID($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCmdID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCmdID() => clearField(1);

  @$pb.TagNumber(2)
  SecretMsg_Type get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(SecretMsg_Type v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  SecretMsg_ErrorMsg get err => $_getN(2);
  @$pb.TagNumber(3)
  set err(SecretMsg_ErrorMsg v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasErr() => $_has(2);
  @$pb.TagNumber(3)
  void clearErr() => clearField(3);
  @$pb.TagNumber(3)
  SecretMsg_ErrorMsg ensureErr() => $_ensure(2);

  @$pb.TagNumber(4)
  SecretMsg_EnclaveMsg get enclave => $_getN(3);
  @$pb.TagNumber(4)
  set enclave(SecretMsg_EnclaveMsg v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasEnclave() => $_has(3);
  @$pb.TagNumber(4)
  void clearEnclave() => clearField(4);
  @$pb.TagNumber(4)
  SecretMsg_EnclaveMsg ensureEnclave() => $_ensure(3);

  @$pb.TagNumber(5)
  SecretMsg_HandleMsg get handle => $_getN(4);
  @$pb.TagNumber(5)
  set handle(SecretMsg_HandleMsg v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasHandle() => $_has(4);
  @$pb.TagNumber(5)
  void clearHandle() => clearField(5);
  @$pb.TagNumber(5)
  SecretMsg_HandleMsg ensureHandle() => $_ensure(4);
}

/// SecretResult is message to return EnterSecret results.
class SecretResult extends $pb.GeneratedMessage {
  factory SecretResult({
    $core.bool? ok,
    $core.String? result,
  }) {
    final $result = create();
    if (ok != null) {
      $result.ok = ok;
    }
    if (result != null) {
      $result.result = result;
    }
    return $result;
  }
  SecretResult._() : super();
  factory SecretResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory SecretResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'SecretResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..aOB(1, _omitFieldNames ? '' : 'ok')
    ..aOS(2, _omitFieldNames ? '' : 'result')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  SecretResult clone() => SecretResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  SecretResult copyWith(void Function(SecretResult) updates) => super.copyWith((message) => updates(message as SecretResult)) as SecretResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static SecretResult create() => SecretResult._();
  SecretResult createEmptyInstance() => create();
  static $pb.PbList<SecretResult> createRepeated() => $pb.PbList<SecretResult>();
  @$core.pragma('dart2js:noInline')
  static SecretResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<SecretResult>(create);
  static SecretResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.bool get ok => $_getBF(0);
  @$pb.TagNumber(1)
  set ok($core.bool v) { $_setBool(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasOk() => $_has(0);
  @$pb.TagNumber(1)
  void clearOk() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get result => $_getSZ(1);
  @$pb.TagNumber(2)
  set result($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasResult() => $_has(1);
  @$pb.TagNumber(2)
  void clearResult() => clearField(2);
}

class Cmd extends $pb.GeneratedMessage {
  factory Cmd({
    Cmd_Type? type,
    $core.String? userName,
    $core.String? publicDIDSeed,
    $core.String? uRL,
    $core.String? aAGUID,
    $fixnum.Int64? counter,
    $core.String? jWT,
    $core.String? origin,
  }) {
    final $result = create();
    if (type != null) {
      $result.type = type;
    }
    if (userName != null) {
      $result.userName = userName;
    }
    if (publicDIDSeed != null) {
      $result.publicDIDSeed = publicDIDSeed;
    }
    if (uRL != null) {
      $result.uRL = uRL;
    }
    if (aAGUID != null) {
      $result.aAGUID = aAGUID;
    }
    if (counter != null) {
      $result.counter = counter;
    }
    if (jWT != null) {
      $result.jWT = jWT;
    }
    if (origin != null) {
      $result.origin = origin;
    }
    return $result;
  }
  Cmd._() : super();
  factory Cmd.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Cmd.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'Cmd', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..e<Cmd_Type>(1, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: Cmd_Type.LOGIN, valueOf: Cmd_Type.valueOf, enumValues: Cmd_Type.values)
    ..aOS(2, _omitFieldNames ? '' : 'userName', protoName: 'userName')
    ..aOS(3, _omitFieldNames ? '' : 'publicDIDSeed', protoName: 'publicDIDSeed')
    ..aOS(4, _omitFieldNames ? '' : 'URL', protoName: 'URL')
    ..aOS(5, _omitFieldNames ? '' : 'AAGUID', protoName: 'AAGUID')
    ..a<$fixnum.Int64>(7, _omitFieldNames ? '' : 'counter', $pb.PbFieldType.OU6, defaultOrMaker: $fixnum.Int64.ZERO)
    ..aOS(8, _omitFieldNames ? '' : 'JWT', protoName: 'JWT')
    ..aOS(9, _omitFieldNames ? '' : 'origin')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Cmd clone() => Cmd()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Cmd copyWith(void Function(Cmd) updates) => super.copyWith((message) => updates(message as Cmd)) as Cmd;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static Cmd create() => Cmd._();
  Cmd createEmptyInstance() => create();
  static $pb.PbList<Cmd> createRepeated() => $pb.PbList<Cmd>();
  @$core.pragma('dart2js:noInline')
  static Cmd getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Cmd>(create);
  static Cmd? _defaultInstance;

  @$pb.TagNumber(1)
  Cmd_Type get type => $_getN(0);
  @$pb.TagNumber(1)
  set type(Cmd_Type v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasType() => $_has(0);
  @$pb.TagNumber(1)
  void clearType() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get userName => $_getSZ(1);
  @$pb.TagNumber(2)
  set userName($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasUserName() => $_has(1);
  @$pb.TagNumber(2)
  void clearUserName() => clearField(2);

  @$pb.TagNumber(3)
  $core.String get publicDIDSeed => $_getSZ(2);
  @$pb.TagNumber(3)
  set publicDIDSeed($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasPublicDIDSeed() => $_has(2);
  @$pb.TagNumber(3)
  void clearPublicDIDSeed() => clearField(3);

  @$pb.TagNumber(4)
  $core.String get uRL => $_getSZ(3);
  @$pb.TagNumber(4)
  set uRL($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasURL() => $_has(3);
  @$pb.TagNumber(4)
  void clearURL() => clearField(4);

  @$pb.TagNumber(5)
  $core.String get aAGUID => $_getSZ(4);
  @$pb.TagNumber(5)
  set aAGUID($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasAAGUID() => $_has(4);
  @$pb.TagNumber(5)
  void clearAAGUID() => clearField(5);

  @$pb.TagNumber(7)
  $fixnum.Int64 get counter => $_getI64(5);
  @$pb.TagNumber(7)
  set counter($fixnum.Int64 v) { $_setInt64(5, v); }
  @$pb.TagNumber(7)
  $core.bool hasCounter() => $_has(5);
  @$pb.TagNumber(7)
  void clearCounter() => clearField(7);

  @$pb.TagNumber(8)
  $core.String get jWT => $_getSZ(6);
  @$pb.TagNumber(8)
  set jWT($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(8)
  $core.bool hasJWT() => $_has(6);
  @$pb.TagNumber(8)
  void clearJWT() => clearField(8);

  @$pb.TagNumber(9)
  $core.String get origin => $_getSZ(7);
  @$pb.TagNumber(9)
  set origin($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(9)
  $core.bool hasOrigin() => $_has(7);
  @$pb.TagNumber(9)
  void clearOrigin() => clearField(9);
}

class CmdStatus_OKResult extends $pb.GeneratedMessage {
  factory CmdStatus_OKResult({
    $core.String? jWT,
  }) {
    final $result = create();
    if (jWT != null) {
      $result.jWT = jWT;
    }
    return $result;
  }
  CmdStatus_OKResult._() : super();
  factory CmdStatus_OKResult.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CmdStatus_OKResult.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CmdStatus.OKResult', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..aOS(1, _omitFieldNames ? '' : 'JWT', protoName: 'JWT')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CmdStatus_OKResult clone() => CmdStatus_OKResult()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CmdStatus_OKResult copyWith(void Function(CmdStatus_OKResult) updates) => super.copyWith((message) => updates(message as CmdStatus_OKResult)) as CmdStatus_OKResult;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CmdStatus_OKResult create() => CmdStatus_OKResult._();
  CmdStatus_OKResult createEmptyInstance() => create();
  static $pb.PbList<CmdStatus_OKResult> createRepeated() => $pb.PbList<CmdStatus_OKResult>();
  @$core.pragma('dart2js:noInline')
  static CmdStatus_OKResult getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CmdStatus_OKResult>(create);
  static CmdStatus_OKResult? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get jWT => $_getSZ(0);
  @$pb.TagNumber(1)
  set jWT($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasJWT() => $_has(0);
  @$pb.TagNumber(1)
  void clearJWT() => clearField(1);
}

enum CmdStatus_Info {
  enclave, 
  handle, 
  ok, 
  err, 
  notSet
}

/// CmdStatus is structure to return cmd statuses.
class CmdStatus extends $pb.GeneratedMessage {
  factory CmdStatus({
    $fixnum.Int64? cmdID,
    CmdStatus_Type? type,
    Cmd_Type? cmdType,
    SecretMsg_Type? secType,
    SecretMsg_EnclaveMsg? enclave,
    SecretMsg_HandleMsg? handle,
    CmdStatus_OKResult? ok,
    $core.String? err,
  }) {
    final $result = create();
    if (cmdID != null) {
      $result.cmdID = cmdID;
    }
    if (type != null) {
      $result.type = type;
    }
    if (cmdType != null) {
      $result.cmdType = cmdType;
    }
    if (secType != null) {
      $result.secType = secType;
    }
    if (enclave != null) {
      $result.enclave = enclave;
    }
    if (handle != null) {
      $result.handle = handle;
    }
    if (ok != null) {
      $result.ok = ok;
    }
    if (err != null) {
      $result.err = err;
    }
    return $result;
  }
  CmdStatus._() : super();
  factory CmdStatus.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory CmdStatus.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);

  static const $core.Map<$core.int, CmdStatus_Info> _CmdStatus_InfoByTag = {
    5 : CmdStatus_Info.enclave,
    6 : CmdStatus_Info.handle,
    7 : CmdStatus_Info.ok,
    8 : CmdStatus_Info.err,
    0 : CmdStatus_Info.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(_omitMessageNames ? '' : 'CmdStatus', package: const $pb.PackageName(_omitMessageNames ? '' : 'authn.v1'), createEmptyInstance: create)
    ..oo(0, [5, 6, 7, 8])
    ..aInt64(1, _omitFieldNames ? '' : 'cmdID', protoName: 'cmdID')
    ..e<CmdStatus_Type>(2, _omitFieldNames ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: CmdStatus_Type.STATUS, valueOf: CmdStatus_Type.valueOf, enumValues: CmdStatus_Type.values)
    ..e<Cmd_Type>(3, _omitFieldNames ? '' : 'cmdType', $pb.PbFieldType.OE, defaultOrMaker: Cmd_Type.LOGIN, valueOf: Cmd_Type.valueOf, enumValues: Cmd_Type.values)
    ..e<SecretMsg_Type>(4, _omitFieldNames ? '' : 'secType', $pb.PbFieldType.OE, defaultOrMaker: SecretMsg_Type.ERROR, valueOf: SecretMsg_Type.valueOf, enumValues: SecretMsg_Type.values)
    ..aOM<SecretMsg_EnclaveMsg>(5, _omitFieldNames ? '' : 'enclave', subBuilder: SecretMsg_EnclaveMsg.create)
    ..aOM<SecretMsg_HandleMsg>(6, _omitFieldNames ? '' : 'handle', subBuilder: SecretMsg_HandleMsg.create)
    ..aOM<CmdStatus_OKResult>(7, _omitFieldNames ? '' : 'ok', subBuilder: CmdStatus_OKResult.create)
    ..aOS(8, _omitFieldNames ? '' : 'err')
    ..hasRequiredFields = false
  ;

  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  CmdStatus clone() => CmdStatus()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  CmdStatus copyWith(void Function(CmdStatus) updates) => super.copyWith((message) => updates(message as CmdStatus)) as CmdStatus;

  $pb.BuilderInfo get info_ => _i;

  @$core.pragma('dart2js:noInline')
  static CmdStatus create() => CmdStatus._();
  CmdStatus createEmptyInstance() => create();
  static $pb.PbList<CmdStatus> createRepeated() => $pb.PbList<CmdStatus>();
  @$core.pragma('dart2js:noInline')
  static CmdStatus getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<CmdStatus>(create);
  static CmdStatus? _defaultInstance;

  CmdStatus_Info whichInfo() => _CmdStatus_InfoByTag[$_whichOneof(0)]!;
  void clearInfo() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $fixnum.Int64 get cmdID => $_getI64(0);
  @$pb.TagNumber(1)
  set cmdID($fixnum.Int64 v) { $_setInt64(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasCmdID() => $_has(0);
  @$pb.TagNumber(1)
  void clearCmdID() => clearField(1);

  @$pb.TagNumber(2)
  CmdStatus_Type get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(CmdStatus_Type v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  Cmd_Type get cmdType => $_getN(2);
  @$pb.TagNumber(3)
  set cmdType(Cmd_Type v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasCmdType() => $_has(2);
  @$pb.TagNumber(3)
  void clearCmdType() => clearField(3);

  @$pb.TagNumber(4)
  SecretMsg_Type get secType => $_getN(3);
  @$pb.TagNumber(4)
  set secType(SecretMsg_Type v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasSecType() => $_has(3);
  @$pb.TagNumber(4)
  void clearSecType() => clearField(4);

  @$pb.TagNumber(5)
  SecretMsg_EnclaveMsg get enclave => $_getN(4);
  @$pb.TagNumber(5)
  set enclave(SecretMsg_EnclaveMsg v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasEnclave() => $_has(4);
  @$pb.TagNumber(5)
  void clearEnclave() => clearField(5);
  @$pb.TagNumber(5)
  SecretMsg_EnclaveMsg ensureEnclave() => $_ensure(4);

  @$pb.TagNumber(6)
  SecretMsg_HandleMsg get handle => $_getN(5);
  @$pb.TagNumber(6)
  set handle(SecretMsg_HandleMsg v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasHandle() => $_has(5);
  @$pb.TagNumber(6)
  void clearHandle() => clearField(6);
  @$pb.TagNumber(6)
  SecretMsg_HandleMsg ensureHandle() => $_ensure(5);

  @$pb.TagNumber(7)
  CmdStatus_OKResult get ok => $_getN(6);
  @$pb.TagNumber(7)
  set ok(CmdStatus_OKResult v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasOk() => $_has(6);
  @$pb.TagNumber(7)
  void clearOk() => clearField(7);
  @$pb.TagNumber(7)
  CmdStatus_OKResult ensureOk() => $_ensure(6);

  @$pb.TagNumber(8)
  $core.String get err => $_getSZ(7);
  @$pb.TagNumber(8)
  set err($core.String v) { $_setString(7, v); }
  @$pb.TagNumber(8)
  $core.bool hasErr() => $_has(7);
  @$pb.TagNumber(8)
  void clearErr() => clearField(8);
}


const _omitFieldNames = $core.bool.fromEnvironment('protobuf.omit_field_names');
const _omitMessageNames = $core.bool.fromEnvironment('protobuf.omit_message_names');
