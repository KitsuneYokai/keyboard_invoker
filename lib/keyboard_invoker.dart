import 'keyboard_invoker_platform_interface.dart';

class KeyboardInvoker {
  Future<String?> getPlatformVersion() {
    return KeyboardInvokerPlatform.instance.getPlatformVersion();
  }

  Future<String?> invokeKey(int keyCode) async {
    return KeyboardInvokerPlatform.instance.invokeKey(keyCode);
  }

  Future holdKey(int keyCode) async {
    return KeyboardInvokerPlatform.instance.holdKey(keyCode);
  }

  Future releaseKey(int keyCode) async {
    return KeyboardInvokerPlatform.instance.releaseKey(keyCode);
  }
}
