import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'keyboard_invoker_platform_interface.dart';
import 'mappings/base_key.dart';
import 'mappings/key_recording.dart';

import 'mappings/key_mapping.dart';

class LinuxError implements Exception {
  final String code;
  final String message;

  LinuxError({required this.code, required this.message});
}

class KeyboardInvoker extends ChangeNotifier {
  // vars for the macro recording
  List<KeyRecording> _recordedKeys = [];
  bool _isRecording = false;

  // vars for linux support
  bool _isX11 = false;
  bool _isXdotoolInstalled = false;

  // recording delay vars
  DateTime? _lastKeyEventTime;
  bool _includeDelays = true;
  Duration _staticDelay = const Duration(milliseconds: 10);

  // macro recording getters
  List<KeyRecording> get recordedKeys => _recordedKeys;
  bool get isRecording => _isRecording;

  // linux support getters
  bool get isX11 => _isX11;
  bool get isXdotoolInstalled => _isXdotoolInstalled;

  // getter and setter for the recording delay
  bool get includeDelays => _includeDelays;
  Duration get staticDelay => _staticDelay;

  set includeDelays(bool value) {
    _includeDelays = value;
    notifyListeners();
  }

  set staticDelay(Duration value) {
    _staticDelay = value;
    notifyListeners();
  }

  // setter for the recorded keys
  set recordedKeys(List<KeyRecording> recordedKeys) {
    _recordedKeys = recordedKeys;
    notifyListeners();
  }

  // class constructor
  KeyboardInvoker() {
    _initLinux();
    _initMacOs();
  }

  Future<void> _initLinux() async {
    if (Platform.isLinux && !_isX11 && !_isXdotoolInstalled) {
      _isX11 = await _isLinuxCommandInstalled('xset');
      _isXdotoolInstalled = await _isLinuxCommandInstalled('xdotool');

      _validateLinuxDependencies();
      notifyListeners();
    }
  }

  void _validateLinuxDependencies() {
    // check if x11 is installed
    if (!_isX11) {
      throw LinuxError(
        code: 'X11_NOT_INSTALLED',
        message:
            'X11 is not installed or not active. Please install and activate X11 to use this plugin on Linux. If you think this is a bug, please open an issue on GitHub.',
      );
    }

    // check if xdotool is installed
    if (!_isXdotoolInstalled) {
      throw LinuxError(
        code: 'XDOTOOL_NOT_INSTALLED',
        message:
            'xdotool is not installed. Please install xdotool to use this plugin on Linux. If you think this is a bug, please open an issue on GitHub.',
      );
    }
  }

  Future<bool> _isLinuxCommandInstalled(String command) async {
    final result = await Process.run('which', [command]);
    return result.exitCode == 0;
  }

  Future<void> _initMacOs() async {
    if (Platform.isMacOS) {
      await KeyboardInvokerPlatform.instance.validateMacOsPermissions();
    }
  }

  // Macro Recording Functions
  void startRecording() {
    // set the state to recording
    _isRecording = true;
    _lastKeyEventTime = DateTime.now(); // Initialize the time
    notifyListeners();
    // add the listener
    HardwareKeyboard.instance.addHandler(recordKeys);
  }

  // simple macro recording
  bool recordKeys(KeyEvent event) {
    BaseKey baseKey = KeyMappings.getBaseKey(event.logicalKey);

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
    notifyListeners();

    return true;
  }

  void stopRecording() {
    // set the state
    _isRecording = false;
    notifyListeners();
    // remove the listener
    HardwareKeyboard.instance.removeHandler(recordKeys);
  }

  void clearRecording() {
    // clear the recorded keys
    _recordedKeys = [];
    _lastKeyEventTime = null; // Reset the timer
    notifyListeners();
  }

  // Macro Execution Functions
  Future<void> executeRecording() async {
    for (KeyRecording keyRecording in _recordedKeys) {
      // Wait for the recorded delay before executing the key
      await Future.delayed(keyRecording.delay);

      switch (keyRecording.keyEventType) {
        case KeyEventType.keyDown:
          await holdKey(keyRecording);
          break;

        case KeyEventType.keyUp:
          await releaseKey(keyRecording);
          break;

        case KeyEventType.keyInvoke:
          await invokeKey(keyRecording);
          break;
      }
    }
  }

  Future<void> invokeKeyRecordingList(List<KeyRecording> recordings) async {
    for (KeyRecording keyRecording in recordings) {
      // Wait for the recorded delay before executing the key
      await Future.delayed(keyRecording.delay);

      switch (keyRecording.keyEventType) {
        case KeyEventType.keyDown:
          await holdKey(keyRecording);
          break;

        case KeyEventType.keyUp:
          await releaseKey(keyRecording);
          break;

        case KeyEventType.keyInvoke:
          await invokeKey(keyRecording);
          break;
      }
    }
  }

  // Platform Functions
  Future<void> invokeKey(KeyRecording keyCode) async {
    return KeyboardInvokerPlatform.instance.invokeKey(keyCode);
  }

  Future<void> holdKey(KeyRecording keyCode) async {
    return KeyboardInvokerPlatform.instance.holdKey(keyCode);
  }

  Future<void> releaseKey(KeyRecording keyCode) async {
    return KeyboardInvokerPlatform.instance.releaseKey(keyCode);
  }
}
