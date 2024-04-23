//
//  Generated code. Do not modify.
//  source: authn.proto
//
// @dart = 2.12

// ignore_for_file: annotate_overrides, camel_case_types, comment_references
// ignore_for_file: constant_identifier_names, library_prefixes
// ignore_for_file: non_constant_identifier_names, prefer_final_fields
// ignore_for_file: unnecessary_import, unnecessary_this, unused_import

import 'dart:convert' as $convert;
import 'dart:core' as $core;
import 'dart:typed_data' as $typed_data;

@$core.Deprecated('Use secretMsgDescriptor instead')
const SecretMsg$json = {
  '1': 'SecretMsg',
  '2': [
    {'1': 'cmdID', '3': 1, '4': 1, '5': 3, '10': 'cmdID'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.authn.v1.SecretMsg.Type', '10': 'type'},
    {'1': 'err', '3': 3, '4': 1, '5': 11, '6': '.authn.v1.SecretMsg.ErrorMsg', '9': 0, '10': 'err'},
    {'1': 'enclave', '3': 4, '4': 1, '5': 11, '6': '.authn.v1.SecretMsg.EnclaveMsg', '9': 0, '10': 'enclave'},
    {'1': 'handle', '3': 5, '4': 1, '5': 11, '6': '.authn.v1.SecretMsg.HandleMsg', '9': 0, '10': 'handle'},
  ],
  '3': [SecretMsg_ErrorMsg$json, SecretMsg_EnclaveMsg$json, SecretMsg_HandleMsg$json],
  '4': [SecretMsg_Type$json],
  '8': [
    {'1': 'Info'},
  ],
};

@$core.Deprecated('Use secretMsgDescriptor instead')
const SecretMsg_ErrorMsg$json = {
  '1': 'ErrorMsg',
  '2': [
    {'1': 'info', '3': 1, '4': 1, '5': 9, '10': 'info'},
  ],
};

@$core.Deprecated('Use secretMsgDescriptor instead')
const SecretMsg_EnclaveMsg$json = {
  '1': 'EnclaveMsg',
  '2': [
    {'1': 'credID', '3': 1, '4': 1, '5': 12, '10': 'credID'},
  ],
};

@$core.Deprecated('Use secretMsgDescriptor instead')
const SecretMsg_HandleMsg$json = {
  '1': 'HandleMsg',
  '2': [
    {'1': 'ID', '3': 1, '4': 1, '5': 3, '10': 'ID'},
    {'1': 'data', '3': 2, '4': 1, '5': 12, '10': 'data'},
    {'1': 'sign', '3': 3, '4': 1, '5': 12, '10': 'sign'},
  ],
};

@$core.Deprecated('Use secretMsgDescriptor instead')
const SecretMsg_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'ERROR', '2': 0},
    {'1': 'NEW_HANDLE', '2': 1},
    {'1': 'IS_KEY_HANDLE', '2': 2},
    {'1': 'ID', '2': 3},
    {'1': 'CBOR_PUB_KEY', '2': 4},
    {'1': 'SIGN', '2': 5},
    {'1': 'VERIFY', '2': 6},
  ],
};

/// Descriptor for `SecretMsg`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List secretMsgDescriptor = $convert.base64Decode(
    'CglTZWNyZXRNc2cSFAoFY21kSUQYASABKANSBWNtZElEEiwKBHR5cGUYAiABKA4yGC5hdXRobi'
    '52MS5TZWNyZXRNc2cuVHlwZVIEdHlwZRIwCgNlcnIYAyABKAsyHC5hdXRobi52MS5TZWNyZXRN'
    'c2cuRXJyb3JNc2dIAFIDZXJyEjoKB2VuY2xhdmUYBCABKAsyHi5hdXRobi52MS5TZWNyZXRNc2'
    'cuRW5jbGF2ZU1zZ0gAUgdlbmNsYXZlEjcKBmhhbmRsZRgFIAEoCzIdLmF1dGhuLnYxLlNlY3Jl'
    'dE1zZy5IYW5kbGVNc2dIAFIGaGFuZGxlGh4KCEVycm9yTXNnEhIKBGluZm8YASABKAlSBGluZm'
    '8aJAoKRW5jbGF2ZU1zZxIWCgZjcmVkSUQYASABKAxSBmNyZWRJRBpDCglIYW5kbGVNc2cSDgoC'
    'SUQYASABKANSAklEEhIKBGRhdGEYAiABKAxSBGRhdGESEgoEc2lnbhgDIAEoDFIEc2lnbiJkCg'
    'RUeXBlEgkKBUVSUk9SEAASDgoKTkVXX0hBTkRMRRABEhEKDUlTX0tFWV9IQU5ETEUQAhIGCgJJ'
    'RBADEhAKDENCT1JfUFVCX0tFWRAEEggKBFNJR04QBRIKCgZWRVJJRlkQBkIGCgRJbmZv');

@$core.Deprecated('Use secretResultDescriptor instead')
const SecretResult$json = {
  '1': 'SecretResult',
  '2': [
    {'1': 'ok', '3': 1, '4': 1, '5': 8, '10': 'ok'},
    {'1': 'result', '3': 2, '4': 1, '5': 9, '10': 'result'},
  ],
};

/// Descriptor for `SecretResult`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List secretResultDescriptor = $convert.base64Decode(
    'CgxTZWNyZXRSZXN1bHQSDgoCb2sYASABKAhSAm9rEhYKBnJlc3VsdBgCIAEoCVIGcmVzdWx0');

@$core.Deprecated('Use cmdDescriptor instead')
const Cmd$json = {
  '1': 'Cmd',
  '2': [
    {'1': 'type', '3': 1, '4': 1, '5': 14, '6': '.authn.v1.Cmd.Type', '10': 'type'},
    {'1': 'userName', '3': 2, '4': 1, '5': 9, '10': 'userName'},
    {'1': 'publicDIDSeed', '3': 3, '4': 1, '5': 9, '10': 'publicDIDSeed'},
    {'1': 'URL', '3': 4, '4': 1, '5': 9, '10': 'URL'},
    {'1': 'AAGUID', '3': 5, '4': 1, '5': 9, '10': 'AAGUID'},
    {'1': 'counter', '3': 7, '4': 1, '5': 4, '10': 'counter'},
    {'1': 'JWT', '3': 8, '4': 1, '5': 9, '10': 'JWT'},
    {'1': 'origin', '3': 9, '4': 1, '5': 9, '10': 'origin'},
  ],
  '4': [Cmd_Type$json],
};

@$core.Deprecated('Use cmdDescriptor instead')
const Cmd_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'LOGIN', '2': 0},
    {'1': 'REGISTER', '2': 1},
  ],
};

/// Descriptor for `Cmd`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cmdDescriptor = $convert.base64Decode(
    'CgNDbWQSJgoEdHlwZRgBIAEoDjISLmF1dGhuLnYxLkNtZC5UeXBlUgR0eXBlEhoKCHVzZXJOYW'
    '1lGAIgASgJUgh1c2VyTmFtZRIkCg1wdWJsaWNESURTZWVkGAMgASgJUg1wdWJsaWNESURTZWVk'
    'EhAKA1VSTBgEIAEoCVIDVVJMEhYKBkFBR1VJRBgFIAEoCVIGQUFHVUlEEhgKB2NvdW50ZXIYBy'
    'ABKARSB2NvdW50ZXISEAoDSldUGAggASgJUgNKV1QSFgoGb3JpZ2luGAkgASgJUgZvcmlnaW4i'
    'HwoEVHlwZRIJCgVMT0dJThAAEgwKCFJFR0lTVEVSEAE=');

@$core.Deprecated('Use cmdStatusDescriptor instead')
const CmdStatus$json = {
  '1': 'CmdStatus',
  '2': [
    {'1': 'cmdID', '3': 1, '4': 1, '5': 3, '10': 'cmdID'},
    {'1': 'type', '3': 2, '4': 1, '5': 14, '6': '.authn.v1.CmdStatus.Type', '10': 'type'},
    {'1': 'cmd_type', '3': 3, '4': 1, '5': 14, '6': '.authn.v1.Cmd.Type', '10': 'cmdType'},
    {'1': 'sec_type', '3': 4, '4': 1, '5': 14, '6': '.authn.v1.SecretMsg.Type', '10': 'secType'},
    {'1': 'enclave', '3': 5, '4': 1, '5': 11, '6': '.authn.v1.SecretMsg.EnclaveMsg', '9': 0, '10': 'enclave'},
    {'1': 'handle', '3': 6, '4': 1, '5': 11, '6': '.authn.v1.SecretMsg.HandleMsg', '9': 0, '10': 'handle'},
    {'1': 'ok', '3': 7, '4': 1, '5': 11, '6': '.authn.v1.CmdStatus.OKResult', '9': 0, '10': 'ok'},
    {'1': 'err', '3': 8, '4': 1, '5': 9, '9': 0, '10': 'err'},
  ],
  '3': [CmdStatus_OKResult$json],
  '4': [CmdStatus_Type$json],
  '8': [
    {'1': 'Info'},
  ],
};

@$core.Deprecated('Use cmdStatusDescriptor instead')
const CmdStatus_OKResult$json = {
  '1': 'OKResult',
  '2': [
    {'1': 'JWT', '3': 1, '4': 1, '5': 9, '10': 'JWT'},
  ],
};

@$core.Deprecated('Use cmdStatusDescriptor instead')
const CmdStatus_Type$json = {
  '1': 'Type',
  '2': [
    {'1': 'STATUS', '2': 0},
    {'1': 'READY_OK', '2': 1},
    {'1': 'READY_ERR', '2': 2},
  ],
};

/// Descriptor for `CmdStatus`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List cmdStatusDescriptor = $convert.base64Decode(
    'CglDbWRTdGF0dXMSFAoFY21kSUQYASABKANSBWNtZElEEiwKBHR5cGUYAiABKA4yGC5hdXRobi'
    '52MS5DbWRTdGF0dXMuVHlwZVIEdHlwZRItCghjbWRfdHlwZRgDIAEoDjISLmF1dGhuLnYxLkNt'
    'ZC5UeXBlUgdjbWRUeXBlEjMKCHNlY190eXBlGAQgASgOMhguYXV0aG4udjEuU2VjcmV0TXNnLl'
    'R5cGVSB3NlY1R5cGUSOgoHZW5jbGF2ZRgFIAEoCzIeLmF1dGhuLnYxLlNlY3JldE1zZy5FbmNs'
    'YXZlTXNnSABSB2VuY2xhdmUSNwoGaGFuZGxlGAYgASgLMh0uYXV0aG4udjEuU2VjcmV0TXNnLk'
    'hhbmRsZU1zZ0gAUgZoYW5kbGUSLgoCb2sYByABKAsyHC5hdXRobi52MS5DbWRTdGF0dXMuT0tS'
    'ZXN1bHRIAFICb2sSEgoDZXJyGAggASgJSABSA2VychocCghPS1Jlc3VsdBIQCgNKV1QYASABKA'
    'lSA0pXVCIvCgRUeXBlEgoKBlNUQVRVUxAAEgwKCFJFQURZX09LEAESDQoJUkVBRFlfRVJSEAJC'
    'BgoESW5mbw==');

