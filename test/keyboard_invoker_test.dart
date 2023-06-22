import 'package:flutter_test/flutter_test.dart';
import 'package:keyboard_invoker/keyboard_invoker.dart';
import 'package:keyboard_invoker/keyboard_invoker_platform_interface.dart';
import 'package:keyboard_invoker/keyboard_invoker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockKeyboardInvokerPlatform
    with MockPlatformInterfaceMixin
    implements KeyboardInvokerPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future invokeKey(int keyCode) {
    // TODO: implement invokeKey
    throw UnimplementedError();
  }
}

void main() {
  final KeyboardInvokerPlatform initialPlatform =
      KeyboardInvokerPlatform.instance;

  test('$MethodChannelKeyboardInvoker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelKeyboardInvoker>());
  });

  test('getPlatformVersion', () async {
    KeyboardInvoker keyboardInvokerPlugin = KeyboardInvoker();
    MockKeyboardInvokerPlatform fakePlatform = MockKeyboardInvokerPlatform();
    KeyboardInvokerPlatform.instance = fakePlatform;

    expect(await keyboardInvokerPlugin.getPlatformVersion(), '42');
  });
}
