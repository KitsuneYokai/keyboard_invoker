import 'base_key.dart';
import 'mapping/key_map.dart';
import 'mapping/key_recordings_map.dart';

enum KeyEventType { keyDown, keyUp, keyInvoke }

/// This class represents a [KeyRecording], you can think of it as a
///
/// Properties:
/// * [logicalKeyId] - The logical key identifier from Darts's keyboard API
/// * [description] - A human-readable description of the key
/// * [linux] - The Linux-specific key identifier (can be null)
/// * [windows] - The Windows-specific key identifier (can be null)
/// * [mac] - The MacOS-specific key identifier (can be null)
/// * [keyEventType] - The type of event to be performed on the key
/// * [delay] - The delay to wait before performing the event
///
/// You can get a [KeyRecording] from the [KeyMap] like this
///
/// Example:
/// ```dart
/// KeyRecording key_b = KeyMap.keyB.keyRecording(),
/// ```
/// you can also alter the KeyEventType and the Duration, check [KeyRecordingsMap]
/// for more information
class KeyRecording extends BaseKey {
  final KeyEventType keyEventType;
  final Duration delay;

  const KeyRecording(
    super.logicalKeyId,
    super.description,
    super.linux,
    super.windows,
    super.mac,
    this.keyEventType,
    this.delay,
  );
}
