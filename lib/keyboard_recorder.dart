import 'package:flutter/services.dart';

import 'base_key.dart';
import 'keyboard_invoker.dart';
import 'mapping/base_key_map.dart';

/// This class handles the recording of keyboard macros.
///
/// Its by glued by default to the keyboard Invoker class as recorder parameter.
///
/// Example usage:
/// ```dart
/// final keyboardInvoker = KeyboardInvoker();
/// keyboardInvoker.recorder.startRecording();
/// ... type something ...
/// keyboardInvoker.recorder.stopRecording();
///
/// keyboardInvoker.recorder.invokeRecording();
/// ```
class KeyboardRecorder {
  final KeyboardInvoker _keyboardInvoker;
  // vars for the macro recording
  List<KeyRecording> _recordedKeys = [];
  bool _isRecording = false;

  // recording delay vars
  DateTime? _lastKeyEventTime;
  bool _includeDelays = true;
  Duration _staticDelay = const Duration(milliseconds: 0);

  // KeyboardRecorder constructor
  KeyboardRecorder(this._keyboardInvoker);

  // macro recording getters
  List<KeyRecording> get recordedKeys => _recordedKeys;
  bool get isRecording => _isRecording;

  // getter for the recording delay config
  bool get includeDelays => _includeDelays;
  Duration get staticDelay => _staticDelay;

  // setter for the record delay functions
  set includeDelays(bool value) {
    _includeDelays = value;
    _keyboardInvoker.notifyListeners();
  }

  set staticDelay(Duration value) {
    _staticDelay = value;
    _keyboardInvoker.notifyListeners();
  }

  // setter for the recorded keys
  set recordedKeys(List<KeyRecording> recordedKeys) {
    _recordedKeys = recordedKeys;
    _keyboardInvoker.notifyListeners();
  }

  /// This function starts the macro recording, by adding the key listener to the hardware keyboard,
  /// and setting the state to recording.
  void startRecording() {
    // set the state to recording
    _isRecording = true;
    _lastKeyEventTime = DateTime.now(); // Initialize the time
    _keyboardInvoker.notifyListeners();

    // add the listener
    HardwareKeyboard.instance.addHandler(_recordKeys);
  }

  /// This is the internal function that records the keys, and adds them to the recorded keys list.
  /// It also calculates the delay between the keys if the includeDelays is enabled.
  bool _recordKeys(KeyEvent event) {
    BaseKey baseKey = BaseKeyMap.getBaseKeyfromlogicalKeyId(event.logicalKey);

    KeyEventType keyEventType = event is KeyDownEvent
        ? KeyEventType.keyDown
        : event is KeyUpEvent
            ? KeyEventType.keyUp
            : KeyEventType.keyInvoke;

    // Calculate delay if enabled
    Duration delay;
    if (_includeDelays && _lastKeyEventTime != null) {
      delay = DateTime.now().difference(_lastKeyEventTime!);
    } else {
      delay = _staticDelay;
    }

    _lastKeyEventTime = DateTime.now();
    KeyRecording keyRecording = KeyRecording(
        baseKey.logicalKeyId,
        baseKey.description,
        baseKey.linux,
        baseKey.windows,
        baseKey.mac,
        keyEventType,
        delay);

    _recordedKeys.add(keyRecording);
    _keyboardInvoker.notifyListeners();

    return true;
  }

  /// This function stops the macro recording, by removing the key listener from the hardware keyboard,
  /// and setts the state to not recording.
  void stopRecording() {
    // set the state
    _isRecording = false;
    _keyboardInvoker.notifyListeners();

    // remove the listener
    HardwareKeyboard.instance.removeHandler(_recordKeys);
  }

  /// Clears the recorded macro.
  void clearRecording() {
    // clear the recorded keys
    _recordedKeys = [];
    _lastKeyEventTime = null;
    _keyboardInvoker.notifyListeners();
  }

  /// This function invokes the recorded macro List on the host system.
  Future<void> invokeRecording({bool? forceNumState}) async {
    _keyboardInvoker.invokeKeys(_recordedKeys, forceNumState: forceNumState);
  }
}
