import 'package:flutter/services.dart';

import 'base_key.dart';
import 'key_recording.dart';
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

  /// Starts recording the macro.
  void startRecording() {
    // set the state to recording
    _isRecording = true;
    _lastKeyEventTime = DateTime.now(); // Initialize the time
    _keyboardInvoker.notifyListeners();

    // add the listener
    HardwareKeyboard.instance.addHandler(recordKeys);
  }

  /// Records the keys during the macro recording.
  bool recordKeys(KeyEvent event) {
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

  /// Stops the macro recording.
  void stopRecording() {
    // set the state
    _isRecording = false;
    _keyboardInvoker.notifyListeners();

    // remove the listener
    HardwareKeyboard.instance.removeHandler(recordKeys);
  }

  /// Clears the recorded macro.
  void clearRecording() {
    // clear the recorded keys
    _recordedKeys = [];
    _lastKeyEventTime = null; // Reset the timer
    _keyboardInvoker.notifyListeners();
  }

  /// Executes the recorded macro.
  Future<void> invokeRecording() async {
    _keyboardInvoker.invokeKeys(_recordedKeys);
  }
}
