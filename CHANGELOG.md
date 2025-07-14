# Changelog

## 2.0.0

Due to too many breaking changes, i decided to raise the package version to `2.0.0`

### Changes

* Changed `invokeMacroList` function name to `invokeKeys`
* `invokeKeys` will now take a list of `KeyRecording` instead of a List of Maps, so `logicalKeyboardKeysToMacro` is no longer needed, and got removed.
* All Recorder functions are now inside of a own class `KeyboardRecorder` that is a part of the `KeyboardInvoker` class as recorder property.
* Updated the example to use the new functions and classes.

### Additions

* Added `KeyMap` enum to represent the key mapping, instead of using the flutter logical key ids. The `KeyMap` enum can return the `BaseKey` and the `KeyRecording` for each key inside the enum.

### Removed

* Removed `logicalKeyboardKeysToMacro` function.

## 1.0.0

* Initial release.
