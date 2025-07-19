import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:keyboard_invoker/keyboard_invoker_platform_interface.dart';
import 'package:keyboard_invoker/keyboard_invoker_method_channel.dart';
import 'package:keyboard_invoker/key_recording.dart';

/// TODO: Im not sure, how i could write platform tests for the keyboard invoker.
/// If someone comes up with an idea, please open an issue on the github repo.
/// I would be very happy to implement it.
class MockKeyboardInvokerPlatform
    with MockPlatformInterfaceMixin
    implements KeyboardInvokerPlatform {
  @override
  Future<bool> invokeKey(KeyRecording keyCode) {
    throw UnimplementedError();
  }

  @override
  Future<bool> holdKey(KeyRecording keyCode) {
    throw UnimplementedError();
  }

  @override
  Future<bool> releaseKey(KeyRecording keyCode) {
    throw UnimplementedError();
  }

  @override
  Future<bool> validateMacOsPermissions() {
    throw UnimplementedError();
  }

  @override
  Future<bool> checkNumLockState() {
    throw UnimplementedError();
  }

  @override
  Future<bool> installXdoTool() {
    throw UnimplementedError();
  }
}

void main() {
  final KeyboardInvokerPlatform initialPlatform =
      KeyboardInvokerPlatform.instance;

  test('$MethodChannelKeyboardInvoker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKeyboardInvoker>());
  });
}
