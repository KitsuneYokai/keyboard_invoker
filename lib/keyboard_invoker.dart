import 'keyboard_invoker_platform_interface.dart';

class KeyboardInvoker {
  Future<String?> getPlatformVersion() {
    return KeyboardInvokerPlatform.instance.getPlatformVersion();
  }

  Future<bool> invokeKey(int keyCode) async {
    return KeyboardInvokerPlatform.instance.invokeKey(keyCode);
  }

  Future<bool> holdKey(int keyCode) async {
    return KeyboardInvokerPlatform.instance.holdKey(keyCode);
  }

  Future<bool> releaseKey(int keyCode) async {
    return KeyboardInvokerPlatform.instance.releaseKey(keyCode);
  }
}
