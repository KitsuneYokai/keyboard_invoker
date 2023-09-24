import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'keyboard_invoker_platform_interface.dart';

enum KeyType { keyInvoke, keyDown, keyUp }

class KeyboardInvoker extends ChangeNotifier {
  // vars for the macro recording
  List<Map<String, dynamic>> _recordedKeys = [];
  bool _isRecording = false;

  // getters
  List<Map<String, dynamic>> get recordedKeys => _recordedKeys;
  bool get isRecording => _isRecording;

  // setter
  set recordedKeys(List<Map<String, dynamic>> recordedKeys) {
    _recordedKeys = recordedKeys;
    notifyListeners();
  }

  set isRecording(bool isRecording) {
    _isRecording = isRecording;
    notifyListeners();
  }

  // Platform Functions
  Future<String?> getPlatformVersion() {
    return KeyboardInvokerPlatform.instance.getPlatformVersion();
  }

  Future<bool> invokeKey(Map<String, dynamic> keyCode) async {
    return KeyboardInvokerPlatform.instance.invokeKey(keyCode);
  }

  Future<bool> invokeKeyList(List<Map<String, dynamic>> keyCodes) async {
    return KeyboardInvokerPlatform.instance.invokeKeyList(keyCodes);
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
        // record the keys on a key up event, so they are not held down
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
}
