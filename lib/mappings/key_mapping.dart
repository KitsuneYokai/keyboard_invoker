// File containing the key mapping List.

// Windows:
// https://docs.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
//
// MacOS:
// cat /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX13.3.sdk/System/Library/Frameworks/Carbon.framework/Versions/A/Frameworks/HIToolbox.framework/Versions/A/Headers/Events.h
//
// Linux:
// https://gitlab.com/cunidev/gestures/-/wikis/xdotool-list-of-key-codes/diff?version_id=ecac032a3c9a1b39c9bb3a5dabda66dc51c9edce

import 'package:flutter/services.dart';
import 'base_key.dart';
import 'key_recording.dart';

class KeyMappings {
  /// Get the list of key mappings.
  static List<BaseKey> get mappings => _mappings;
  static final List<BaseKey> _mappings = [
    BaseKey(null, "Left mouse button", null, 0x01, null),
    BaseKey(null, "Right mouse button", null, 0x02, null),
    BaseKey(null, "Control-break processing", null, 0x03, null),
    BaseKey(null, "Middle mouse button (three-button mouse)", null, 0x04, null),
    BaseKey(null, "X1 mouse button", null, 0x05, null),
    BaseKey(null, "X2 mouse button", null, 0x06, null),
    BaseKey(
        LogicalKeyboardKey.backspace, "BACKSPACE key", "0xff08", 0x08, 0x33),
    BaseKey(LogicalKeyboardKey.tab, "TAB key", "0xff09", 0x09, 0x30),
    BaseKey(LogicalKeyboardKey.clear, "CLEAR key", "0xff0b", 0x0C, null),
    BaseKey(LogicalKeyboardKey.enter, "ENTER key", "0xff0d", 0x0D, 0x24),
    BaseKey(LogicalKeyboardKey.shift, "SHIFT key", "0xffe1", 0x10, 0x38),
    BaseKey(LogicalKeyboardKey.control, "CTRL key", "0xffe3", 0x11, 0x3B),
    BaseKey(LogicalKeyboardKey.alt, "ALT key", "0xffe9", 0x12, 0x3A),
    BaseKey(LogicalKeyboardKey.pause, "PAUSE key", "0xff13", 0x13, 0x71),
    BaseKey(LogicalKeyboardKey.capsLock, "CAPS LOCK key", "0xffe5", 0x14, 0x39),
    BaseKey(null, "Input Method Editor (IME) Kana mode", null, 0x15, null),
    BaseKey(
        null,
        "IME Hanguel mode (maintained for compatibility; use VK_HANGUL)",
        null,
        0x15,
        null),
    BaseKey(null, "IME Hangul mode", null, 0x15, null),
    BaseKey(null, "IME On", null, 0x16, null),
    BaseKey(null, "IME Junja mode", null, 0x17, null),
    BaseKey(null, "IME final mode", null, 0x18, null),
    BaseKey(null, "IME Hanja mode", null, 0x19, null),
    BaseKey(null, "IME Kanji mode", null, 0x19, null),
    BaseKey(null, "IME Off", null, 0x1A, null),
    BaseKey(LogicalKeyboardKey.escape, "ESC key", "0xff1b", 0x1B, 0x35),
    BaseKey(null, "IME convert", null, 0x1C, null),
    BaseKey(null, "IME nonconvert", null, 0x1D, null),
    BaseKey(null, "IME accept", null, 0x1E, null),
    BaseKey(null, "IME mode change request", null, 0x1F, null),
    BaseKey(LogicalKeyboardKey.space, "SPACEBAR", "0x0020", 0x20, 0x31),
    BaseKey(LogicalKeyboardKey.pageUp, "PAGE UP key", "0xff55", 0x21, 0x74),
    BaseKey(LogicalKeyboardKey.pageDown, "PAGE DOWN key", "0xff56", 0x22, 0x79),
    BaseKey(LogicalKeyboardKey.end, "END key", "0xff57", 0x23, 0x77),
    BaseKey(LogicalKeyboardKey.home, "HOME key", "0xff50", 0x24, 0x73),
    BaseKey(
        LogicalKeyboardKey.arrowLeft, "LEFT ARROW key", "0xff51", 0x25, 0x7B),
    BaseKey(LogicalKeyboardKey.arrowUp, "UP ARROW key", "0xff52", 0x26, 0x7E),
    BaseKey(
        LogicalKeyboardKey.arrowRight, "RIGHT ARROW key", "0xff53", 0x27, 0x7C),
    BaseKey(
        LogicalKeyboardKey.arrowDown, "DOWN ARROW key", "0xff54", 0x28, 0x7D),
    BaseKey(LogicalKeyboardKey.select, "SELECT key", "0xff60", 0x29, null),
    BaseKey(LogicalKeyboardKey.printScreen, "PRINT key", "0xff61", 0x2A, null),
    BaseKey(LogicalKeyboardKey.execute, "EXECUTE key", "0xff62", 0x2B, null),
    BaseKey(LogicalKeyboardKey.printScreen, "PRINT SCREEN key", "0xfd1d", 0x2C,
        null),
    BaseKey(LogicalKeyboardKey.insert, "INS key", "0xff63", 0x2D, 0x72),
    BaseKey(LogicalKeyboardKey.delete, "DEL key", "0xffff", 0x2E, 0x75),
    BaseKey(LogicalKeyboardKey.help, "HELP key", "0xff6a", 0x2F, 0x72),
    BaseKey(LogicalKeyboardKey.digit0, "0 key", "0x0030", 0x30, 0x1D),
    BaseKey(LogicalKeyboardKey.digit1, "1 key", "0x0031", 0x31, 0x12),
    BaseKey(LogicalKeyboardKey.digit2, "2 key", "0x0032", 0x32, 0x13),
    BaseKey(LogicalKeyboardKey.digit3, "3 key", "0x0033", 0x33, 0x14),
    BaseKey(LogicalKeyboardKey.digit4, "4 key", "0x0034", 0x34, 0x15),
    BaseKey(LogicalKeyboardKey.digit5, "5 key", "0x0035", 0x35, 0x17),
    BaseKey(LogicalKeyboardKey.digit6, "6 key", "0x0036", 0x36, 0x16),
    BaseKey(LogicalKeyboardKey.digit7, "7 key", "0x0037", 0x37, 0x1A),
    BaseKey(LogicalKeyboardKey.digit8, "8 key", "0x0038", 0x38, 0x1C),
    BaseKey(LogicalKeyboardKey.digit9, "9 key", "0x0039", 0x39, 0x19),
    BaseKey(LogicalKeyboardKey.keyA, "A key", "0x0061", 0x41, 0x00),
    BaseKey(LogicalKeyboardKey.keyB, "B key", "0x0062", 0x42, 0x0B),
    BaseKey(LogicalKeyboardKey.keyC, "C key", "0x0063", 0x43, 0x08),
    BaseKey(LogicalKeyboardKey.keyD, "D key", "0x0064", 0x44, 0x02),
    BaseKey(LogicalKeyboardKey.keyE, "E key", "0x0065", 0x45, 0x0E),
    BaseKey(LogicalKeyboardKey.keyF, "F key", "0x0066", 0x46, 0x03),
    BaseKey(LogicalKeyboardKey.keyG, "G key", "0x0067", 0x47, 0x05),
    BaseKey(LogicalKeyboardKey.keyH, "H key", "0x0068", 0x48, 0x04),
    BaseKey(LogicalKeyboardKey.keyI, "I key", "0x0069", 0x49, 0x22),
    BaseKey(LogicalKeyboardKey.keyJ, "J key", "0x006a", 0x4A, 0x26),
    BaseKey(LogicalKeyboardKey.keyK, "K key", "0x006b", 0x4B, 0x28),
    BaseKey(LogicalKeyboardKey.keyL, "L key", "0x006c", 0x4C, 0x25),
    BaseKey(LogicalKeyboardKey.keyM, "M key", "0x006d", 0x4D, 0x2E),
    BaseKey(LogicalKeyboardKey.keyN, "N key", "0x006e", 0x4E, 0x2D),
    BaseKey(LogicalKeyboardKey.keyO, "O key", "0x006f", 0x4F, 0x1F),
    BaseKey(LogicalKeyboardKey.keyP, "P key", "0x0070", 0x50, 0x23),
    BaseKey(LogicalKeyboardKey.keyQ, "Q key", "0x0071", 0x51, 0x0C),
    BaseKey(LogicalKeyboardKey.keyR, "R key", "0x0072", 0x52, 0x0F),
    BaseKey(LogicalKeyboardKey.keyS, "S key", "0x0073", 0x53, 0x01),
    BaseKey(LogicalKeyboardKey.keyT, "T key", "0x0074", 0x54, 0x11),
    BaseKey(LogicalKeyboardKey.keyU, "U key", "0x0075", 0x55, 0x20),
    BaseKey(LogicalKeyboardKey.keyV, "V key", "0x0076", 0x56, 0x09),
    BaseKey(LogicalKeyboardKey.keyW, "W key", "0x0077", 0x57, 0x0D),
    BaseKey(LogicalKeyboardKey.keyX, "X key", "0x0078", 0x58, 0x07),
    BaseKey(LogicalKeyboardKey.keyY, "Y key", "0x0079", 0x59, 0x10),
    BaseKey(LogicalKeyboardKey.keyZ, "Z key", "0x007a", 0x5A, 0x06),
    BaseKey(LogicalKeyboardKey.metaLeft, "Left Windows key (Natural keyboard)",
        "0xffe7", 0x5B, 0x37),
    BaseKey(LogicalKeyboardKey.metaRight,
        "Right Windows key (Natural keyboard)", "0xffe8", 0x5C, 0x36),
    BaseKey(LogicalKeyboardKey.contextMenu,
        "Applications key (Natural keyboard)", "0xff67", 0x5D, 0x3D),
    BaseKey(LogicalKeyboardKey.sleep, "Computer Sleep key", null, 0x5F, 0x3F),
    BaseKey(LogicalKeyboardKey.numpad0, "Numeric keypad 0 key", "0xffb0", 0x60,
        0x52),
    BaseKey(LogicalKeyboardKey.numpad1, "Numeric keypad 1 key", "0xffb1", 0x61,
        0x53),
    BaseKey(LogicalKeyboardKey.numpad2, "Numeric keypad 2 key", "0xffb2", 0x62,
        0x54),
    BaseKey(LogicalKeyboardKey.numpad3, "Numeric keypad 3 key", "0xffb3", 0x63,
        0x55),
    BaseKey(LogicalKeyboardKey.numpad4, "Numeric keypad 4 key", "0xffb4", 0x64,
        0x56),
    BaseKey(LogicalKeyboardKey.numpad5, "Numeric keypad 5 key", "0xffb5", 0x65,
        0x57),
    BaseKey(LogicalKeyboardKey.numpad6, "Numeric keypad 6 key", "0xffb6", 0x66,
        0x58),
    BaseKey(LogicalKeyboardKey.numpad7, "Numeric keypad 7 key", "0xffb7", 0x67,
        0x59),
    BaseKey(LogicalKeyboardKey.numpad8, "Numeric keypad 8 key", "0xffb8", 0x68,
        0x5B),
    BaseKey(LogicalKeyboardKey.numpad9, "Numeric keypad 9 key", "0xffb9", 0x69,
        0x5C),
    BaseKey(LogicalKeyboardKey.numpadMultiply, "Multiply key", "0xffaa", 0x6A,
        0x43),
    BaseKey(LogicalKeyboardKey.numpadAdd, "Add key", "0xffab", 0x6B, 0x45),
    BaseKey(
        LogicalKeyboardKey.numpadComma, "Separator key", "0xffac", 0x6C, 0x4C),
    BaseKey(LogicalKeyboardKey.numpadSubtract, "Subtract key", "0xffad", 0x6D,
        0x4E),
    BaseKey(
        LogicalKeyboardKey.numpadDecimal, "Decimal key", "0xffae", 0x6E, 0x41),
    BaseKey(
        LogicalKeyboardKey.numpadDivide, "Divide key", "0xffaf", 0x6F, 0x4B),
    BaseKey(LogicalKeyboardKey.f1, "F1 key", "0xffbe", 0x70, 0x7A),
    BaseKey(LogicalKeyboardKey.f2, "F2 key", "0xffbf", 0x71, 0x78),
    BaseKey(LogicalKeyboardKey.f3, "F3 key", "0xffc0", 0x72, 0x63),
    BaseKey(LogicalKeyboardKey.f4, "F4 key", "0xffc1", 0x73, 0x76),
    BaseKey(LogicalKeyboardKey.f5, "F5 key", "0xffc2", 0x74, 0x60),
    BaseKey(LogicalKeyboardKey.f6, "F6 key", "0xffc3", 0x75, 0x61),
    BaseKey(LogicalKeyboardKey.f7, "F7 key", "0xffc4", 0x76, 0x62),
    BaseKey(LogicalKeyboardKey.f8, "F8 key", "0xffc5", 0x77, 0x64),
    BaseKey(LogicalKeyboardKey.f9, "F9 key", "0xffc6", 0x78, 0x65),
    BaseKey(LogicalKeyboardKey.f10, "F10 key", "0xffc7", 0x79, 0x6D),
    BaseKey(LogicalKeyboardKey.f11, "F11 key", "0xffc8", 0x7A, 0x67),
    BaseKey(LogicalKeyboardKey.f12, "F12 key", "0xffc9", 0x7B, 0x6F),
    BaseKey(LogicalKeyboardKey.f13, "F13 key", "0xffca", 0x7C, 0x69),
    BaseKey(LogicalKeyboardKey.f14, "F14 key", "0xffcb", 0x7D, 0x6B),
    BaseKey(LogicalKeyboardKey.f15, "F15 key", "0xffcc", 0x7E, 0x71),
    BaseKey(LogicalKeyboardKey.f16, "F16 key", "0xffcd", 0x7F, 0x6A),
    BaseKey(LogicalKeyboardKey.f17, "F17 key", "0xffce", 0x80, 0x40),
    BaseKey(LogicalKeyboardKey.f18, "F18 key", "0xffcf", 0x81, 0x4F),
    BaseKey(LogicalKeyboardKey.f19, "F19 key", "0xffd0", 0x82, 0x50),
    BaseKey(LogicalKeyboardKey.f20, "F20 key", "0xffd1", 0x83, 0x5A),
    BaseKey(LogicalKeyboardKey.f21, "F21 key", "0xffd2", 0x84, null),
    BaseKey(LogicalKeyboardKey.f22, "F22 key", "0xffd3", 0x85, null),
    BaseKey(LogicalKeyboardKey.f23, "F23 key", "0xffd4", 0x86, null),
    BaseKey(LogicalKeyboardKey.f24, "F24 key", "0xffd5", 0x87, null),
    BaseKey(LogicalKeyboardKey.numLock, "NUM LOCK key", "0xff7f", 0x90, null),
    BaseKey(
        LogicalKeyboardKey.scrollLock, "SCROLL LOCK key", "0xff14", 0x91, null),
    BaseKey(
        LogicalKeyboardKey.shiftLeft, "Left SHIFT key", "0xffe1", 0xA0, 0x38),
    BaseKey(
        LogicalKeyboardKey.shiftRight, "Right SHIFT key", "0xffe2", 0xA1, 0x3C),
    BaseKey(LogicalKeyboardKey.controlLeft, "Left CONTROL key", "0xffe3", 0xA2,
        0x3B),
    BaseKey(LogicalKeyboardKey.controlRight, "Right CONTROL key", "0xffe4",
        0xA3, 0x3E),
    BaseKey(LogicalKeyboardKey.altLeft, "Left MENU key", "0xffe9", 0xA4, 0x3A),
    BaseKey(
        LogicalKeyboardKey.altRight, "Right MENU key", "0xffea", 0xA5, 0x3D),
    BaseKey(
        LogicalKeyboardKey.browserBack, "Browser Back key", null, 0xA6, null),
    BaseKey(LogicalKeyboardKey.browserForward, "Browser Forward key", null,
        0xA7, null),
    BaseKey(LogicalKeyboardKey.browserRefresh, "Browser Refresh key", null,
        0xA8, null),
    BaseKey(
        LogicalKeyboardKey.browserStop, "Browser Stop key", null, 0xA9, null),
    BaseKey(LogicalKeyboardKey.browserSearch, "Browser Search key", null, 0xAA,
        null),
    BaseKey(LogicalKeyboardKey.browserFavorites, "Browser Favorites key", null,
        0xAB, null),
    BaseKey(LogicalKeyboardKey.browserHome, "Browser Start and Home key", null,
        0xAC, null),
    BaseKey(LogicalKeyboardKey.audioVolumeMute, "Volume Mute key",
        "XF86AudioMute", 0xAD, 0x4A),
    BaseKey(LogicalKeyboardKey.audioVolumeDown, "Volume Down key",
        "XF86AudioLowerVolume", 0xAE, 0x49),
    BaseKey(LogicalKeyboardKey.audioVolumeUp, "Volume Up key",
        "XF86AudioRaiseVolume", 0xAF, 0x48),
    BaseKey(LogicalKeyboardKey.mediaTrackNext, "Next Track key",
        "XF86AudioNext", 0xB0, null),
    BaseKey(LogicalKeyboardKey.mediaTrackPrevious, "Previous Track key",
        "XF86AudioPrev", 0xB1, null),
    BaseKey(LogicalKeyboardKey.mediaStop, "Stop Media key", "XF86AudioStop",
        0xB2, null),
    BaseKey(LogicalKeyboardKey.mediaPlayPause, "Play/Pause Media key",
        "XF86AudioPlay", 0xB3, null),
    BaseKey(LogicalKeyboardKey.launchMail, "Start Mail key", null, 0xB4, null),
    BaseKey(null, "Select Media key", null, 0xB5, null),
    BaseKey(LogicalKeyboardKey.launchApplication1, "Start Application 1 key",
        null, 0xB6, null),
    BaseKey(LogicalKeyboardKey.launchApplication2, "Start Application 2 key",
        null, 0xB7, null),
    BaseKey(
        LogicalKeyboardKey.semicolon,
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ';:' key",
        "0x003b",
        0xBA,
        0x29),
    BaseKey(LogicalKeyboardKey.equal, "For any country/region, the '+' key",
        "0x003d", 0xBB, 0x18),
    BaseKey(LogicalKeyboardKey.comma, "For any country/region, the ',' key",
        "0x002c", 0xBC, 0x2B),
    BaseKey(LogicalKeyboardKey.minus, "For any country/region, the '-' key",
        "0x002d", 0xBD, 0x1B),
    BaseKey(LogicalKeyboardKey.period, "For any country/region, the '.' key",
        "0x002e", 0xBE, 0x2F),
    BaseKey(
        LogicalKeyboardKey.slash,
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '/?' key",
        "0x002f",
        0xBF,
        0x2C),
    BaseKey(
        LogicalKeyboardKey.backquote,
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '`~' key",
        "0x0060",
        0xC0,
        0x32),
    BaseKey(
        LogicalKeyboardKey.bracketLeft,
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '[{' key",
        "0x005b",
        0xDB,
        0x21),
    BaseKey(
        LogicalKeyboardKey.backslash,
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '\\|' key",
        "0x005c",
        0xDC,
        0x2A),
    BaseKey(
        LogicalKeyboardKey.bracketRight,
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ']}' key",
        "0x005d",
        0xDD,
        0x1E),
    BaseKey(
        LogicalKeyboardKey.quote,
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the 'single-quote/double-quote' key",
        "0x0060",
        0xDE,
        0x27),
    BaseKey(null, "Used for miscellaneous characters; it can vary by keyboard.",
        null, 0xDF, null),
    BaseKey(
        LogicalKeyboardKey.backslash,
        "Either the angle bracket key or the backslash key on the RT 102-key keyboard",
        "0x005c",
        0xE2,
        0x2B),
    BaseKey(null, "IME PROCESS key", null, 0xE5, null),
    BaseKey(
        null,
        "Used to pass Unicode characters as if they were keystrokes. The VK_PACKET key is the low word of a 32-bit Virtual Key windowsValue used for non-keyboard input methods.",
        null,
        0xE7,
        null),
    BaseKey(null, "Attn key", null, 0xF6, null),
    BaseKey(null, "CrSel key", null, 0xF7, null),
    BaseKey(null, "ExSel key", null, 0xF8, null),
    BaseKey(null, "Erase EOF key", null, 0xF9, null),
    BaseKey(null, "Play key", null, 0xFA, null),
    BaseKey(null, "Zoom key", null, 0xFB, null),
    BaseKey(null, "Reserved", null, 0xFC, null),
    BaseKey(null, "PA1 key", null, 0xFD, null),
    BaseKey(null, "Clear key", null, 0xFE, null),
  ];

  /// Returns a [BaseKey] object that corresponds to the given Flutter [LogicalKeyboardKey].
  ///
  /// This function searches through an internal mapping list to find a matching [BaseKey]
  /// based on the provided logical keyboard key. If no match is found, returns a default
  /// "Unknown key" [BaseKey] object.
  ///
  /// Parameters:
  ///   * [key] - The Flutter LogicalKeyboardKey to find a matching BaseKey for
  ///
  /// Returns:
  ///   * A [BaseKey] object matching the input key, or a default "Unknown key" BaseKey
  ///     if no match is found
  ///
  /// Example:
  /// ```dart
  /// var key = KeyMappings.getBaseKey(LogicalKeyboardKey.keyA);
  /// print(key.description); // Output: "A key"
  /// ```
  static BaseKey getBaseKey(LogicalKeyboardKey key) {
    // lets iterate over the list _mappings, and get the key that matches the key passed
    for (BaseKey baseKey in _mappings) {
      if (baseKey.logicalKeyId == key) {
        return baseKey;
      }
    }
    return BaseKey(null, "Unknown key", null, 0x00, 0x00);
  }

  static List<KeyRecording> convertToKeyRecordingList(
      List<LogicalKeyboardKey> keys,
      {Duration? delay}) {
    List<KeyRecording> keyRecordings = [];

    // when no durration is given, we add a 100 ms delay
    delay ??= const Duration(milliseconds: 10);

    for (LogicalKeyboardKey key in keys) {
      BaseKey baseKey = getBaseKey(key);
      keyRecordings.add(
        KeyRecording(baseKey.logicalKeyId, baseKey.description, baseKey.linux,
            baseKey.windows, baseKey.mac, KeyEventType.keyInvoke, delay),
      );
    }
    return keyRecordings;
  }
}
