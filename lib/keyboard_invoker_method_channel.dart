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

  // invoke a single key from the keyCode Map
  @override
  Future<bool> invokeKey(Map<String, dynamic> keyCode) async {
    final List<Map<String, dynamic>> platformKeyMappings =
        key_mappings.keyMapping;

    dynamic platformKeyCode;

    bool leftShiftPressed = false;
    bool rightShiftPressed = false;
    bool leftAltPressed = false;
    bool rightAltPressed = false;
    bool leftControlPressed = false;
    bool rightControlPressed = false;
    bool leftMetaPressed = false;
    bool rightMetaPressed = false;

    // iterate through the list of key mappings and replace the keyCode with the actual key value for the specific platform
    if (Platform.isWindows) {
      for (var platformKey in platformKeyMappings) {
        if (keyCode['keyCode'] == platformKey['logicalKeyId']) {
          platformKeyCode = platformKey['windowsValue'];
        }
      }
    } else if (Platform.isMacOS) {
      for (var platformKey in platformKeyMappings) {
        if (keyCode['keyCode'] == platformKey['logicalKeyId']) {
          platformKeyCode = platformKey['macOSValue'];
        }
      }
    } else if (Platform.isLinux) {
      for (var platformKey in platformKeyMappings) {
        if (keyCode['keyCode'] == platformKey['logicalKeyId']) {
          platformKeyCode = platformKey['linuxValue'];
        }
      }
    }
    // iterate through the list of modifiers and set the modifier variables to true if the modifier is pressed
    if (keyCode["modifiers"]["shiftLeft"] == true) {
      leftShiftPressed = true;
    }
    if (keyCode["modifiers"]["shiftRight"] == true) {
      rightShiftPressed = true;
    }
    if (keyCode["modifiers"]["altLeft"] == true) {
      leftAltPressed = true;
    }
    if (keyCode["modifiers"]["altRight"] == true) {
      rightAltPressed = true;
    }
    if (keyCode["modifiers"]["controlLeft"] == true) {
      leftControlPressed = true;
    }
    if (keyCode["modifiers"]["controlRight"] == true) {
      rightControlPressed = true;
    }
    if (keyCode["modifiers"]["metaLeft"] == true) {
      leftMetaPressed = true;
    }
    if (keyCode["modifiers"]["metaRight"] == true) {
      rightMetaPressed = true;
    }

    final response = await methodChannel.invokeMethod<bool>(
      'invokeKey',
      {
        "platformKeyCode": platformKeyCode,
        "leftShiftPressed": leftShiftPressed,
        "rightShiftPressed": rightShiftPressed,
        "leftAltPressed": leftAltPressed,
        "rightAltPressed": rightAltPressed,
        "leftControlPressed": leftControlPressed,
        "rightControlPressed": rightControlPressed,
        "leftMetaPressed": leftMetaPressed,
        "rightMetaPressed": rightMetaPressed
      },
    );
    if (response != null && response == true) {
      return true;
    } else {
      return false;
    }
  }
}
