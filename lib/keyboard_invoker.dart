import 'dart:io';

import 'package:flutter/foundation.dart';

import 'keyboard_invoker_platform_interface.dart';
import 'key_recording.dart';
import 'keyboard_recorder.dart';
import 'mapping/key_map.dart';
import 'mapping/key_recordings_map.dart';

// Export the key recordings map
export 'key_recording.dart';
export 'mapping/key_map.dart';
export 'mapping/key_recordings_map.dart';

/// This class defines a Exception, that can be thrown, its specific to linux
class LinuxError implements Exception {
  final String code;
  final String message;

  LinuxError({required this.code, required this.message});
}

/// This class represents the main class of the keyboard invoker.
class KeyboardInvoker extends ChangeNotifier {
  late final KeyboardRecorder recorder;
  // vars for linux support
  bool _isX11 = false;
  bool _isXdotoolInstalled = false;

  // var to keep track if a makro is currently being invoked
  bool _isMacroBeingInvoked = false;

  // linux support getters
  bool get isX11 => _isX11;
  bool get isXdotoolInstalled => _isXdotoolInstalled;

  // getter for the isMacroBeingInvoked, this will be set to true, if a macro is
  // currently playing
  bool get isMacroBeingInvoked => _isMacroBeingInvoked;

  // class constructor
  KeyboardInvoker() {
    recorder = KeyboardRecorder(this);
    _initLinux();
    _initMacOs();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  /// Internal function to check if the desktop env on linux is set to x11 and
  /// to check if xdotool is installed.
  Future<void> _initLinux() async {
    if (Platform.isLinux && !_isX11 && !_isXdotoolInstalled) {
      _isX11 = await _isLinuxCommandInstalled('xset');
      _isXdotoolInstalled = await _isLinuxCommandInstalled('xdotool');

      _validateLinuxDependencies();
      notifyListeners();
    }
  }

  /// Internal function that Throws a Linux Exception, if x11 isn't set as desktop
  /// env or xdotool isn't installed
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

  /// yet another internal helper function to check if a specific linux command is installed
  Future<bool> _isLinuxCommandInstalled(String command) async {
    final result = await Process.run('which', [command]);
    return result.exitCode == 0;
  }

  /// Internal helper function to initialize Mac os, its used to validate the os
  /// permission
  Future<void> _initMacOs() async {
    if (Platform.isMacOS) {
      await KeyboardInvokerPlatform.instance.validateMacOsPermissions();
    }
  }

  /// This function invokes keyboard keys on the host system.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// KeyboardInvoker invoker = KeyboardInvoker();
  /// invoker.invokeKeys([
  ///       KeyMap.keyH.keyRecording(),
  ///       KeyMap.keyI.keyRecording(),
  /// ]);
  /// ```
  /// TODO: check if a macro is bein invoked, and then eather:
  ///   - dont invoke the macro at all
  ///   - wait for the macro to finish and then invoke the new macro
  Future<void> invokeKeys(List<KeyRecording> recordings,
      {bool? forceNumState}) async {
    late bool? previousNumState;
    late bool? changedNumState;

    if (forceNumState != null) {
      // Get the previous state of the NumLock
      previousNumState = await checkNumLockState();
    }

    // Set the _isMacroBeingInvoked to true and notify
    _isMacroBeingInvoked = true;
    notifyListeners();

    // If the forceNumState differs from the previousNumState, we invoke the num lock
    if (previousNumState != null && forceNumState != previousNumState) {
      await KeyboardInvokerPlatform.instance
          .invokeKey(KeyMap.numLock.keyRecording());
      changedNumState = true;
    }

    // Invoke the Keys Inside the List
    for (KeyRecording keyRecording in recordings) {
      // Wait for the recorded delay before executing the key
      await Future.delayed(keyRecording.delay);

      switch (keyRecording.keyEventType) {
        case KeyEventType.keyDown:
          await KeyboardInvokerPlatform.instance.holdKey(keyRecording);
          break;

        case KeyEventType.keyUp:
          await KeyboardInvokerPlatform.instance.releaseKey(keyRecording);
          break;

        case KeyEventType.keyInvoke:
          await KeyboardInvokerPlatform.instance.invokeKey(keyRecording);
          break;
      }
    }

    // If we changed the changedNumState var, we gonna revert it to its previous state
    if (changedNumState != null && changedNumState) {
      await KeyboardInvokerPlatform.instance
          .invokeKey(KeyMap.numLock.keyRecording());
    }

    // Set the _isMacroBeingInvoked to false and notify
    _isMacroBeingInvoked = false;
    notifyListeners();
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

  /// This Function checks NumLock state of the host os, and returns the result as
  /// a bool.
  Future<bool> checkNumLockState() async {
    return KeyboardInvokerPlatform.instance.checkNumLockState();
  }
}
