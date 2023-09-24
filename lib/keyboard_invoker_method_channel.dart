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

  // invoke a single key from the keyCode Map
  @override
  Future<bool> invokeKey(Map<String, dynamic> keyCode) async {
    final List<Map<String, dynamic>> platformKeyMappings =
        key_mappings.keyMapping;

    var platformKeyCode;

    bool leftShiftPressed = false;
    bool rightShiftPressed = false;
    bool leftAltPressed = false;
    bool rightAltPressed = false;
    bool leftControlPressed = false;
    bool rightControlPressed = false;
    bool leftMetaPressed = false;
    bool rightMetaPressed = false;

    if (Platform.isWindows) {
      // iterate through the list of key mappings and replace the keyCode with the actual key value for the specific platform
      for (var platformKey in platformKeyMappings) {
        if (keyCode['keyCode'] == platformKey['logicalKeyId']) {
          platformKeyCode = platformKey['windowsValue'];
        }
      }
      // iterate through the list of modifiers and set the modifier variables to true if the modifier is pressed
    }

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

    print(leftMetaPressed);
    print(rightMetaPressed);
    print(leftControlPressed);
    print(rightControlPressed);
    print(leftAltPressed);
    print(rightAltPressed);
    print(leftShiftPressed);
    print(rightShiftPressed);
    print(platformKeyCode);

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

  // invoke the keys from the keyCodes List
  @override
  Future<bool> invokeKeyList(List<Map<String, dynamic>> keyCodes) async {
    // final List<Map<String, dynamic>> platformKeyMappings = key_mappings.keyMapping;

    if (Platform.isWindows) {
      // invoke the keys from the keyCodes List
    }

    final response =
        await methodChannel.invokeMethod<bool>('invokeKeyList', keyCodes);
    if (response != null && response == true) {
      return true;
    } else {
      return false;
    }
  }
}
