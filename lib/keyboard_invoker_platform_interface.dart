import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'keyboard_invoker_method_channel.dart';

abstract class KeyboardInvokerPlatform extends PlatformInterface {
  /// Constructs a KeyboardInvokerPlatform.
  KeyboardInvokerPlatform() : super(token: _token);

  static final Object _token = Object();

  static KeyboardInvokerPlatform _instance = MethodChannelKeyboardInvoker();

  /// The default instance of [KeyboardInvokerPlatform] to use.
  ///
  /// Defaults to [MethodChannelKeyboardInvoker].
  static KeyboardInvokerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [KeyboardInvokerPlatform] when
  /// they register themselves.
  static set instance(KeyboardInvokerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<bool> invokeKey(int keyCode) {
    return Future.error(
        'invokeKey() has not been implemented on this platform yet.');
  }

  Future<bool> holdKey(int keyCode) {
    return Future.error(
        'holdKey() has not been implemented on this platform yet.');
  }

  Future<bool> releaseKey(int keyCode) {
    return Future.error(
        'releaseKey() has not been implemented on this platform yet.');
  }
}
