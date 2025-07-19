import 'package:flutter/services.dart';

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

  /// Returns a [KeyRecording] instance for the current LogicalKeyId
  static List<KeyRecording> fromLogicalKeyList(
    List<LogicalKeyboardKey> logicalKeys,
  ) {
    List<KeyRecording> keyRecordings = [];
    for (var logicalKey in logicalKeys) {
      final baseKey = BaseKeyMap.getBaseKeyFromLogicalKeyId(logicalKey);
      keyRecordings.add(
        KeyRecording(
          baseKey.logicalKeyId,
          baseKey.description,
          baseKey.linux,
          baseKey.windows,
          baseKey.mac,
          KeyEventType.keyInvoke,
          const Duration(seconds: 0),
        ),
      );
    }

    return keyRecordings;
  }
}
