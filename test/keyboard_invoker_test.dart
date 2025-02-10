import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'package:keyboard_invoker/keyboard_invoker_platform_interface.dart';
import 'package:keyboard_invoker/keyboard_invoker_method_channel.dart';
import 'package:keyboard_invoker/mappings/key_recording.dart';

class MockKeyboardInvokerPlatform
    with MockPlatformInterfaceMixin
    implements KeyboardInvokerPlatform {
  @override
  Future<bool> invokeKey(KeyRecording keyCode) {
    // TODO: implement invokeKey
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

  Future<bool> validateMacOsPermissions() {
    throw UnimplementedError();
  }
}

void main() {
  final KeyboardInvokerPlatform initialPlatform =
      KeyboardInvokerPlatform.instance;

  test('$MethodChannelKeyboardInvoker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKeyboardInvoker>());
  });

  // TODO: Write Tests
  // test('getPlatformVersion', () async {
  //   KeyboardInvoker keyboardInvokerPlugin = KeyboardInvoker();
  //   MockKeyboardInvokerPlatform fakePlatform = MockKeyboardInvokerPlatform();
  //   KeyboardInvokerPlatform.instance = fakePlatform;
  //
  //   expect(await keyboardInvokerPlugin.getPlatformVersion(), '42');
  // });
}
