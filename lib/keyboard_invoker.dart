import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'keyboard_invoker_platform_interface.dart';

enum KeyType { keyInvoke, keyDown, keyUp }

class X11NotActiveInstalled implements Exception {
  final String code;
  final String message;

  X11NotActiveInstalled({required this.code, required this.message});
}

class XdotoolNotInstalled implements Exception {
  final String code;
  final String message;

  XdotoolNotInstalled({required this.code, required this.message});
}

class KeyboardInvoker extends ChangeNotifier {
  // vars for the macro recording
  List<Map<String, dynamic>> _recordedKeys = [];
  bool _isRecording = false;

  // vars for linux support
  bool _isX11 = false;
  bool _isXdotoolInstalled = false;

  // macro recording getters
  List<Map<String, dynamic>> get recordedKeys => _recordedKeys;
  bool get isRecording => _isRecording;

  // linux support getters
  bool get isX11 => _isX11;
  bool get isXdotoolInstalled => _isXdotoolInstalled;

  // setter
  set recordedKeys(List<Map<String, dynamic>> recordedKeys) {
    _recordedKeys = recordedKeys;
    notifyListeners();
  }

  set isRecording(bool isRecording) {
    _isRecording = isRecording;
    notifyListeners();
  }

  // init class functions
  KeyboardInvoker() {
    _initLinux();
  }

  Future<void> _initLinux() async {
    if (Platform.isLinux && !_isX11 && !_isXdotoolInstalled) {
      _isX11 = await _isCommandInstalled('xset');
      _isXdotoolInstalled = await _isCommandInstalled('xdotool');
      notifyListeners();
    }
  }

  Future<bool> _isCommandInstalled(String command) async {
    final result = await Process.run('which', [command]);
    return result.exitCode == 0;
  }

  // Platform Functions
  Future<bool> invokeKey(Map<String, dynamic> keyCode) async {
    return KeyboardInvokerPlatform.instance.invokeKey(keyCode);
  }

  // Macro Recording Functions
  Future<void> startRecording() async {
    // set the state to recording
    _isRecording = true;
    notifyListeners();
    // add the listener
    RawKeyboard.instance.addListener(recordKeys);
  }

  // simple macro recording
  Future<void> recordKeys(RawKeyEvent event) async {
    String keyLabel = event.logicalKey.keyLabel;
    int keyCode = event.logicalKey.keyId;
    bool isRepeat = event.repeat;

    bool isLeftShiftPressed = event.isKeyPressed(LogicalKeyboardKey.shiftLeft);
    bool isRightShiftPressed =
        event.isKeyPressed(LogicalKeyboardKey.shiftRight);

    bool isLeftAltPressed = event.isKeyPressed(LogicalKeyboardKey.altLeft);
    bool isRightAltPressed = event.isKeyPressed(LogicalKeyboardKey.altRight);

    bool isLeftControlPressed =
        event.isKeyPressed(LogicalKeyboardKey.controlLeft);
    bool isRightControlPressed =
        event.isKeyPressed(LogicalKeyboardKey.controlRight);

    bool isLeftMetaPressed = event.isKeyPressed(LogicalKeyboardKey.metaLeft);
    bool isRightMetaPressed = event.isKeyPressed(LogicalKeyboardKey.metaRight);

    // create the macro map
    Map<String, dynamic> macroMap = {
      "keyLabel": keyLabel,
      "keyCode": keyCode,
      "modifiers": {
        "shiftLeft": isLeftShiftPressed,
        "shiftRight": isRightShiftPressed,
        "altLeft": isLeftAltPressed,
        "altRight": isRightAltPressed,
        "controlLeft": isLeftControlPressed,
        "controlRight": isRightControlPressed,
        "metaLeft": isLeftMetaPressed,
        "metaRight": isRightMetaPressed,
      },
      "event": null,
    };

    // don't record the key if it's a repeated event
    if (!isRepeat) {
      // only record the modifier keys on a key down event to display them as held down
      if (event is RawKeyDownEvent) {
        if (keyLabel.toLowerCase().contains("shift") ||
            keyLabel.toLowerCase().contains("control") ||
            keyLabel.toLowerCase().contains("alt") ||
            keyLabel.toLowerCase().contains("meta")) {
          macroMap["event"] = KeyType.keyDown;
          macroMap["keyLabel"] = "$keyLabel ⬇️";

          _recordedKeys = [..._recordedKeys, macroMap];
          notifyListeners();
        }
        // record the keys on a key up event
      } else if (event is RawKeyUpEvent) {
        macroMap["event"] = KeyType.keyInvoke;

        // if the key is a modifier, set the event to key up
        if (keyLabel.toLowerCase().contains("shift") ||
            keyLabel.toLowerCase().contains("control") ||
            keyLabel.toLowerCase().contains("alt") ||
            keyLabel.toLowerCase().contains("meta")) {
          macroMap["event"] = KeyType.keyUp;
          macroMap["keyLabel"] = "$keyLabel ⬆️";
        }
        // set the state
        _recordedKeys = [..._recordedKeys, macroMap];
        notifyListeners();
      }
    }
  }

  Future<void> stopRecording() async {
    // set the state
    _isRecording = false;
    notifyListeners();
    // remove the listener
    RawKeyboard.instance.removeListener(recordKeys);
  }

  Future<void> invokeMacroList(List<Map<String, dynamic>> macroList) async {
    if (Platform.isLinux) {
      // check if x11 is installed
      if (!_isX11) {
        throw X11NotActiveInstalled(
          code: 'X11_NOT_INSTALLED',
          message:
              'X11 is not installed or not active. Please install and activate X11 to use this plugin on Linux. If you think this is a bug, please open an issue on GitHub.',
        );
      }

      // check if xdotool is installed
      if (!_isXdotoolInstalled) {
        throw XdotoolNotInstalled(
          code: 'XDOTOOL_NOT_INSTALLED',
          message:
              'xdotool is not installed. Please install xdotool to use this plugin on Linux. If you think this is a bug, please open an issue on GitHub.',
        );
      }
    }

    // loop through the key list
    for (var key in macroList) {
      if (key["event"] == KeyType.keyInvoke) {
        final result = await invokeKey(key);

        if (!result) {
          // Raise an error.
          throw PlatformException(
            code: 'Unknown Error',
            message:
                'There was an unknown error while invoking the key. Maybe the key is not supported on this platform? If you think this is a bug, please open an issue on GitHub.',
          );
        }
      }
    }
  }

  Future<List<Map<String, dynamic>>> logicalKeyboardKeysToMacro(
      List<LogicalKeyboardKey> keys) async {
    List<Map<String, dynamic>> macroList = [];
    // loop through the key list
    bool isLeftShiftPressed = false;
    bool isLeftAltPressed = false;
    bool isLeftControlPressed = false;
    bool isLeftMetaPressed = false;
    bool isRightShiftPressed = false;
    bool isRightAltPressed = false;
    bool isRightControlPressed = false;
    bool isRightMetaPressed = false;

    for (var key in keys) {
      // if the key is a modifier set the bool to true
      if (key == LogicalKeyboardKey.shiftLeft ||
          key == LogicalKeyboardKey.shift) {
        isLeftShiftPressed = true;
      } else if (key == LogicalKeyboardKey.shiftRight) {
        isRightShiftPressed = true;
      } else if (key == LogicalKeyboardKey.altLeft ||
          key == LogicalKeyboardKey.alt) {
        isLeftAltPressed = true;
      } else if (key == LogicalKeyboardKey.altRight) {
        isRightAltPressed = true;
      } else if (key == LogicalKeyboardKey.controlLeft ||
          key == LogicalKeyboardKey.control) {
        isLeftControlPressed = true;
      } else if (key == LogicalKeyboardKey.controlRight) {
        isRightControlPressed = true;
      } else if (key == LogicalKeyboardKey.metaLeft ||
          key == LogicalKeyboardKey.meta) {
        isLeftMetaPressed = true;
      } else if (key == LogicalKeyboardKey.metaRight) {
        isRightMetaPressed = true;
      } else {
        // create a map for the key
        Map<String, dynamic> macroMap = {
          "keyLabel": key.keyLabel,
          "keyCode": key.keyId,
          "modifiers": {
            "shiftLeft": isLeftShiftPressed,
            "shiftRight": isRightShiftPressed,
            "altLeft": isLeftAltPressed,
            "altRight": isRightAltPressed,
            "controlLeft": isLeftControlPressed,
            "controlRight": isRightControlPressed,
            "metaLeft": isLeftMetaPressed,
            "metaRight": isRightMetaPressed,
          },
          "event": KeyType.keyInvoke,
        };
        // set the modifier back to false
        isLeftShiftPressed = false;
        isLeftAltPressed = false;
        isLeftControlPressed = false;
        isLeftMetaPressed = false;
        isRightShiftPressed = false;
        isRightAltPressed = false;
        isRightControlPressed = false;
        isRightMetaPressed = false;

        // add the key to the macro list
        macroList = [...macroList, macroMap];
      }
    }
    // return the macro list
    return macroList;
  }
}
