import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import 'keyboard_invoker_platform_interface.dart';

// import the mappings for the key codes
import 'mappings/key_mapping.dart' as key_mappings;

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
  Future<bool> invokeKey(int keyCode) async {
    List keys = key_mappings.keyMapping;

    if (Platform.isWindows) {
      for (var key in keys) {
        if (key["logicalKeyId"] == keyCode) {
          keyCode = key["windowsValue"];
          break;
        }
      }
    }
    if (Platform.isMacOS) {
      for (var key in keys) {
        if (key["logicalKeyId"] == keyCode) {
          keyCode = key["macOSValue"];
          break;
        }
      }
    }
    if (Platform.isLinux) {
      // https://manpages.ubuntu.com/manpages/impish/man7/virkeycode-linux.7.html
    }
    final response = await methodChannel
        .invokeMethod<bool>('invokeKey', <String, dynamic>{"keyCode": keyCode});

    if (response != null && response == true) {
      return true;
    } else {
      return false;
    }
  }

  // holdKey is responsible for holding the key (press and hold),
  // it is useful for modifier keys(shift, ctrl, alt, etc) and for keys that
  // need to be held for a long time
  @override
  Future<bool> holdKey(int keyCode) async {
    List keys = key_mappings.keyMapping;

    if (Platform.isWindows) {
      for (var key in keys) {
        if (key["logicalKeyId"] == keyCode) {
          keyCode = key["windowsValue"];
          break;
        }
      }
    }
    if (Platform.isMacOS) {
      for (var key in keys) {
        if (key["logicalKeyId"] == keyCode) {
          keyCode = key["macOSValue"];
          break;
        }
      }
    }
    if (Platform.isLinux) {
      // https://manpages.ubuntu.com/manpages/impish/man7/virkeycode-linux.7.html
    }
    final response = await methodChannel
        .invokeMethod<bool>('holdKey', <String, dynamic>{"keyCode": keyCode});
    if (response != null && response == true) {
      return true;
    } else {
      return false;
    }
  }

  // releaseKey is responsible for releasing the key (release),
  // it is useful for modifier keys(shift, ctrl, alt, etc) and for keys that
  // need to be held for a long time
  @override
  Future<bool> releaseKey(int keyCode) async {
    List keys = key_mappings.keyMapping;

    if (Platform.isWindows) {
      for (var key in keys) {
        if (key["logicalKeyId"] == keyCode) {
          keyCode = key["windowsValue"];
          break;
        }
      }
    }
    if (Platform.isMacOS) {
      for (var key in keys) {
        if (key["logicalKeyId"] == keyCode) {
          keyCode = key["macOSValue"];
          break;
        }
      }
    }
    if (Platform.isLinux) {
      // https://manpages.ubuntu.com/manpages/impish/man7/virkeycode-linux.7.html
    }
    final response = await methodChannel.invokeMethod<bool>(
        'releaseKey', <String, dynamic>{"keyCode": keyCode});
    if (response != null && response == true) {
      return true;
    } else {
      return false;
    }
  }
}
