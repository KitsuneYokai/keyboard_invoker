import 'base_key.dart';

enum KeyEventType { keyDown, keyUp, keyInvoke }

class KeyRecording extends BaseKey {
  KeyEventType keyEventType;
  Duration delay;

  KeyRecording(
    super.logicalKeyId,
    super.description,
    super.linux,
    super.windows,
    super.mac,
    this.keyEventType,
    this.delay,
  );
}
