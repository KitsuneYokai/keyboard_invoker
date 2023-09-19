import 'keyboard_invoker_platform_interface.dart';

class KeyboardInvoker {
  Future<String?> getPlatformVersion() {
    return KeyboardInvokerPlatform.instance.getPlatformVersion();
  }

  Future<bool> invokeKey(var keyCode) async {
    return KeyboardInvokerPlatform.instance.invokeKey(keyCode);
  }

  Future<bool> holdKey(var keyCode) async {
    return KeyboardInvokerPlatform.instance.holdKey(keyCode);
  }

  Future<bool> releaseKey(var keyCode) async {
    return KeyboardInvokerPlatform.instance.releaseKey(keyCode);
  }
}
