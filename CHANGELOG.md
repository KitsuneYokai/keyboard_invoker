# Changelog

## 2.0.0

Due to too many breaking changes, i decided to raise the package version to `2.0.0`

### Changes

* Changed `invokeMacroList` function name to `invokeKeys`
* `invokeKeys` will now take a list of `KeyRecording` instead of a List of logicalKeyboardKeys, so `logicalKeyboardKeysToMacro` is no longer needed, and got removed.
* All recorder-related functions have been moved into a dedicated `KeyboardRecorder` class, which is now accessible as the `recorder` property of the `KeyboardInvoker` class.
* Added `KeyMap` enum to represent the key mapping, instead of using the flutter logical key ids. The `KeyMap` enum can return the `BaseKey` and the `KeyRecording` for each key inside the enum.
* Added `BaseKeyMap` class to map the logical keys to the `BaseKey` classes.
* Added `KeyRecordingsMap` class to convert a list of `LogicalKeyboardKey` to a list of `KeyRecording`.
* Added `KeyRecording` class to represent a key recording, which includes the logical key id, description, and delay.
* Added `KeyEventType` enum to represent the type of key event (keyDown, keyUp, keyInvoke).
* Updated the example app.

## 1.0.0

* Initial release.
