import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'keyboard_invoker_platform_interface.dart';

// import the mappings for the key codes
import 'mappings/windows_key_maping.dart' as windows_mapping;

/// An implementation of [KeyboardInvokerPlatform] that uses method channels.
class MethodChannelKeyboardInvoker extends KeyboardInvokerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('keyboard_invoker');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  // invokeKey is responsible for invoking the key (press and release),
  // if you want to invoke a modifier key, you need to call the holdKey method
  @override
  Future<String?> invokeKey(int keyCode) async {
    if (Platform.isWindows) {
      List windowsKeyCodes = windows_mapping.windowsKeyMapping;
      for (var key in windowsKeyCodes) {
        if (key["LogicalKeyId"] == keyCode) {
          keyCode = key["value"];
          break;
        }
      }
      // https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    }
    if (Platform.isMacOS) {
      // https://developer.apple.com/documentation/appkit/nsevent/1534514-keycodes
    }
    if (Platform.isLinux) {
      // https://manpages.ubuntu.com/manpages/impish/man7/virkeycode-linux.7.html
    }
    final response = await methodChannel.invokeMethod<String>(
        'invokeKey', <String, dynamic>{"keyCode": keyCode});
    return response;
  }

  // holdKey is responsible for holding the key (press and hold),
  // it is useful for modifier keys(shift, ctrl, alt, etc) and for keys that
  // need to be held for a long time
  @override
  Future<String?> holdKey(int keyCode) async {
    if (Platform.isWindows) {
      List windowsKeyCodes = windows_mapping.windowsKeyMapping;

      for (var key in windowsKeyCodes) {
        if (key["LogicalKeyId"] == keyCode) {
          keyCode = key["value"];
          break;
        }
      }
      // https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    }
    if (Platform.isMacOS) {
      // https://developer.apple.com/documentation/appkit/nsevent/1534514-keycodes
    }
    if (Platform.isLinux) {
      // https://manpages.ubuntu.com/manpages/impish/man7/virkeycode-linux.7.html
    }
    final response = await methodChannel
        .invokeMethod<String>('holdKey', <String, dynamic>{"keyCode": keyCode});
    return response;
  }

  // releaseKey is responsible for releasing the key (release),
  // it is useful for modifier keys(shift, ctrl, alt, etc) and for keys that
  // need to be held for a long time
  @override
  Future<String?> releaseKey(int keyCode) async {
    if (Platform.isWindows) {
      List windowsKeyCodes = windows_mapping.windowsKeyMapping;
      for (var key in windowsKeyCodes) {
        if (key["LogicalKeyId"] == keyCode) {
          keyCode = key["value"];
          break;
        }
      }
      // https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
    }
    if (Platform.isMacOS) {
      // https://developer.apple.com/documentation/appkit/nsevent/1534514-keycodes
    }
    if (Platform.isLinux) {
      // https://manpages.ubuntu.com/manpages/impish/man7/virkeycode-linux.7.html
    }
    final response = await methodChannel.invokeMethod<String>(
        'releaseKey', <String, dynamic>{"keyCode": keyCode});
    return response;
  }
}
