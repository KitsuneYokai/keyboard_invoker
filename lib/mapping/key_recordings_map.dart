import 'key_map.dart';
import 'base_key_map.dart';
import '../key_recording.dart';

extension KeyRecordingsMap on KeyMap {
  /// Returns a [KeyRecording] instance with the specified [KeyEventType] and [Duration]
  ///
  /// If [keyEventType] not provided, defaults to [KeyEventType.keyInvoke].
  /// If [delay] not provided,defaults to a duration of 0 seconds.
  KeyRecording keyRecording({KeyEventType? keyEventType, Duration? delay}) {
    late KeyRecording keyRecording;
    keyEventType ??= KeyEventType.keyInvoke;

    delay ??= const Duration(seconds: 0);

    keyRecording = KeyRecording(baseKey.logicalKeyId, baseKey.description,
        baseKey.linux, baseKey.windows, baseKey.mac, keyEventType, delay);
    return keyRecording;
  }
}
