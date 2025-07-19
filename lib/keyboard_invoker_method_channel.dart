import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'keyboard_invoker_platform_interface.dart';
import 'key_recording.dart';

/// An implementation of [KeyboardInvokerPlatform] that uses method channels.
class MethodChannelKeyboardInvoker extends KeyboardInvokerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('keyboard_invoker');

  Future<void> _performKeyAction(String action, KeyRecording keyCode) async {
    final os = Platform.operatingSystem;
    Map<String, dynamic> arguments = {};

    switch (os) {
      case 'linux':
        arguments['keyCode'] = keyCode.linux.toString();
        break;
      case 'windows':
        arguments['keyCode'] = keyCode.windows;
        break;
      case 'macos':
        arguments['keyCode'] = keyCode.mac;
        break;

      default:
        throw UnsupportedError('Unsupported platform: $os');
    }

    await methodChannel.invokeMethod(action, arguments);
  }

  @override
  Future<void> validateMacOsPermissions() async {
    await methodChannel.invokeMethod("validatePermissions");
  }

  @override
  Future<void> invokeKey(KeyRecording keyCode) async {
    await _performKeyAction('invokeKey', keyCode);
  }

  @override
  Future<void> holdKey(KeyRecording keyCode) async {
    await _performKeyAction('holdKey', keyCode);
  }

  @override
  Future<void> releaseKey(KeyRecording keyCode) async {
    await _performKeyAction('releaseKey', keyCode);
  }

  @override
  Future<bool> checkNumLockState() async {
    return await methodChannel.invokeMethod("checkNumLockState");
  }

  @override
  Future<bool> installXdoTool() async {
    if (Platform.isLinux) {
      return await methodChannel.invokeMethod("installXdoTool");
    }
    return false;
  }
}
