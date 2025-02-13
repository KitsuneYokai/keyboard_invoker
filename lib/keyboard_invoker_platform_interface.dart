import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'keyboard_invoker_method_channel.dart';
import 'key_recording.dart';

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

  Future<void> validateMacOsPermissions() async {
    return Future.error(
        '_validateMacOsPermissions() dosnt need to be implemented for this platform');
  }

  Future<void> invokeKey(KeyRecording keyCode) async {
    return Future.error(
        'invokeKey() has not been implemented on this platform yet.');
  }

  Future<void> holdKey(KeyRecording keyCode) async {
    return Future.error(
        'holdKey() has not been implemented on this platform yet.');
  }

  Future<void> releaseKey(KeyRecording keyCode) async {
    return Future.error(
        'releaseKey() has not been implemented on this platform yet.');
  }
}
