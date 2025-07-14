import 'package:flutter/services.dart';

import 'key_map.dart';
import '../base_key.dart';

extension BaseKeyMap on KeyMap {
  /// This function gets a base key from a given [logicalKeyId]
  /// Returns a [BaseKey] from a given [logicalKeyId]
  static BaseKey getBaseKeyfromlogicalKeyId(LogicalKeyboardKey logicalKeyId) {
    for (var keyMap in KeyMap.values) {
      if (keyMap.baseKey.logicalKeyId == logicalKeyId) {
        return keyMap.baseKey;
      }
    }
    return const BaseKey(null, "Unknown key", null, null, null);
  }

  // Getter for a BaseKey
  BaseKey get baseKey {
    switch (this) {
      case KeyMap.leftMouseButton:
        return const BaseKey(null, "Left mouse button", null, 0x01, null);
      case KeyMap.rightMouseButton:
        return const BaseKey(null, "Right mouse button", null, 0x02, null);
      case KeyMap.controlBreakProcessing:
        return const BaseKey(
            null, "Control-break processing", null, 0x03, null);
      case KeyMap.middleMouseButton:
        return const BaseKey(
            null, "Middle mouse button (three-button mouse)", null, 0x04, null);
      case KeyMap.x1MouseButton:
        return const BaseKey(null, "X1 mouse button", null, 0x05, null);
      case KeyMap.x2MouseButton:
        return const BaseKey(null, "X2 mouse button", null, 0x06, null);
      case KeyMap.backspace:
        return const BaseKey(LogicalKeyboardKey.backspace, "BACKSPACE key",
            "0xff08", 0x08, 0x33);
      case KeyMap.tab:
        return const BaseKey(
            LogicalKeyboardKey.tab, "TAB key", "0xff09", 0x09, 0x30);
      case KeyMap.clear:
        return const BaseKey(
            LogicalKeyboardKey.clear, "CLEAR key", "0xff0b", 0x0C, null);
      case KeyMap.enter:
        return const BaseKey(
            LogicalKeyboardKey.enter, "ENTER key", "0xff0d", 0x0D, 0x24);
      case KeyMap.shift:
        return const BaseKey(
            LogicalKeyboardKey.shift, "SHIFT key", "0xffe1", 0x10, 0x38);
      case KeyMap.control:
        return const BaseKey(
            LogicalKeyboardKey.control, "CTRL key", "0xffe3", 0x11, 0x3B);
      case KeyMap.alt:
        return const BaseKey(
            LogicalKeyboardKey.alt, "ALT key", "0xffe9", 0x12, 0x3A);
      case KeyMap.pause:
        return const BaseKey(
            LogicalKeyboardKey.pause, "PAUSE key", "0xff13", 0x13, 0x71);
      case KeyMap.capsLock:
        return const BaseKey(
            LogicalKeyboardKey.capsLock, "CAPS LOCK key", "0xffe5", 0x14, 0x39);
      case KeyMap.imeHangulMode:
        return const BaseKey(null, "IME Hangul mode", null, 0x15, null);
      case KeyMap.imeOn:
        return const BaseKey(null, "IME On", null, 0x16, null);
      case KeyMap.imeJunjaMode:
        return const BaseKey(null, "IME Junja mode", null, 0x17, null);
      case KeyMap.imeFinalMode:
        return const BaseKey(null, "IME final mode", null, 0x18, null);
      case KeyMap.imeHanjaMode:
        return const BaseKey(null, "IME Hanja mode", null, 0x19, null);
      case KeyMap.imeKanjiMode:
        return const BaseKey(null, "IME Kanji mode", null, 0x19, null);
      case KeyMap.imeOff:
        return const BaseKey(null, "IME Off", null, 0x1A, null);
      case KeyMap.escape:
        return const BaseKey(
            LogicalKeyboardKey.escape, "ESC key", "0xff1b", 0x1B, 0x35);
      case KeyMap.imeConvert:
        return const BaseKey(null, "IME convert", null, 0x1C, null);
      case KeyMap.imeNonConvert:
        return const BaseKey(null, "IME nonconvert", null, 0x1D, null);
      case KeyMap.imeAccept:
        return const BaseKey(null, "IME accept", null, 0x1E, null);
      case KeyMap.imeModeChangeRequest:
        return const BaseKey(null, "IME mode change request", null, 0x1F, null);
      case KeyMap.space:
        return const BaseKey(
            LogicalKeyboardKey.space, "SPACEBAR", "0x0020", 0x20, 0x31);
      case KeyMap.pageUp:
        return const BaseKey(
            LogicalKeyboardKey.pageUp, "PAGE UP key", "0xff55", 0x21, 0x74);
      case KeyMap.pageDown:
        return const BaseKey(
            LogicalKeyboardKey.pageDown, "PAGE DOWN key", "0xff56", 0x22, 0x79);
      case KeyMap.end:
        return const BaseKey(
            LogicalKeyboardKey.end, "END key", "0xff57", 0x23, 0x77);
      case KeyMap.home:
        return const BaseKey(
            LogicalKeyboardKey.home, "HOME key", "0xff50", 0x24, 0x73);
      case KeyMap.arrowLeft:
        return const BaseKey(LogicalKeyboardKey.arrowLeft, "LEFT ARROW key",
            "0xff51", 0x25, 0x7B);
      case KeyMap.arrowUp:
        return const BaseKey(
            LogicalKeyboardKey.arrowUp, "UP ARROW key", "0xff52", 0x26, 0x7E);
      case KeyMap.arrowRight:
        return const BaseKey(LogicalKeyboardKey.arrowRight, "RIGHT ARROW key",
            "0xff53", 0x27, 0x7C);
      case KeyMap.arrowDown:
        return const BaseKey(LogicalKeyboardKey.arrowDown, "DOWN ARROW key",
            "0xff54", 0x28, 0x7D);
      case KeyMap.select:
        return const BaseKey(
            LogicalKeyboardKey.select, "SELECT key", "0xff60", 0x29, null);
      case KeyMap.print:
        return const BaseKey(
            LogicalKeyboardKey.printScreen, "PRINT key", "0xff61", 0x2A, null);
      case KeyMap.execute:
        return const BaseKey(
            LogicalKeyboardKey.execute, "EXECUTE key", "0xff62", 0x2B, null);
      case KeyMap.printScreen:
        return const BaseKey(LogicalKeyboardKey.printScreen, "PRINT SCREEN key",
            "0xfd1d", 0x2C, null);
      case KeyMap.insert:
        return const BaseKey(
            LogicalKeyboardKey.insert, "INS key", "0xff63", 0x2D, 0x72);
      case KeyMap.delete:
        return const BaseKey(
            LogicalKeyboardKey.delete, "DEL key", "0xffff", 0x2E, 0x75);
      case KeyMap.help:
        return const BaseKey(
            LogicalKeyboardKey.help, "HELP key", "0xff6a", 0x2F, 0x72);
      case KeyMap.digit0:
        return const BaseKey(
            LogicalKeyboardKey.digit0, "0 key", "0x0030", 0x30, 0x1D);
      case KeyMap.digit1:
        return const BaseKey(
            LogicalKeyboardKey.digit1, "1 key", "0x0031", 0x31, 0x12);
      case KeyMap.digit2:
        return const BaseKey(
            LogicalKeyboardKey.digit2, "2 key", "0x0032", 0x32, 0x13);
      case KeyMap.digit3:
        return const BaseKey(
            LogicalKeyboardKey.digit3, "3 key", "0x0033", 0x33, 0x14);
      case KeyMap.digit4:
        return const BaseKey(
            LogicalKeyboardKey.digit4, "4 key", "0x0034", 0x34, 0x15);
      case KeyMap.digit5:
        return const BaseKey(
            LogicalKeyboardKey.digit5, "5 key", "0x0035", 0x35, 0x17);
      case KeyMap.digit6:
        return const BaseKey(
            LogicalKeyboardKey.digit6, "6 key", "0x0036", 0x36, 0x16);
      case KeyMap.digit7:
        return const BaseKey(
            LogicalKeyboardKey.digit7, "7 key", "0x0037", 0x37, 0x1A);
      case KeyMap.digit8:
        return const BaseKey(
            LogicalKeyboardKey.digit8, "8 key", "0x0038", 0x38, 0x1C);
      case KeyMap.digit9:
        return const BaseKey(
            LogicalKeyboardKey.digit9, "9 key", "0x0039", 0x39, 0x19);
      case KeyMap.keyA:
        return const BaseKey(
            LogicalKeyboardKey.keyA, "A key", "0x0061", 0x41, 0x00);
      case KeyMap.keyB:
        return const BaseKey(
            LogicalKeyboardKey.keyB, "B key", "0x0062", 0x42, 0x0B);
      case KeyMap.keyC:
        return const BaseKey(
            LogicalKeyboardKey.keyC, "C key", "0x0063", 0x43, 0x08);
      case KeyMap.keyD:
        return const BaseKey(
            LogicalKeyboardKey.keyD, "D key", "0x0064", 0x44, 0x02);
      case KeyMap.keyE:
        return const BaseKey(
            LogicalKeyboardKey.keyE, "E key", "0x0065", 0x45, 0x0E);
      case KeyMap.keyF:
        return const BaseKey(
            LogicalKeyboardKey.keyF, "F key", "0x0066", 0x46, 0x03);
      case KeyMap.keyG:
        return const BaseKey(
            LogicalKeyboardKey.keyG, "G key", "0x0067", 0x47, 0x05);
      case KeyMap.keyH:
        return const BaseKey(
            LogicalKeyboardKey.keyH, "H key", "0x0068", 0x48, 0x04);
      case KeyMap.keyI:
        return const BaseKey(
            LogicalKeyboardKey.keyI, "I key", "0x0069", 0x49, 0x22);
      case KeyMap.keyJ:
        return const BaseKey(
            LogicalKeyboardKey.keyJ, "J key", "0x006a", 0x4A, 0x26);
      case KeyMap.keyK:
        return const BaseKey(
            LogicalKeyboardKey.keyK, "K key", "0x006b", 0x4B, 0x28);
      case KeyMap.keyL:
        return const BaseKey(
            LogicalKeyboardKey.keyL, "L key", "0x006c", 0x4C, 0x25);
      case KeyMap.keyM:
        return const BaseKey(
            LogicalKeyboardKey.keyM, "M key", "0x006d", 0x4D, 0x2E);
      case KeyMap.keyN:
        return const BaseKey(
            LogicalKeyboardKey.keyN, "N key", "0x006e", 0x4E, 0x2D);
      case KeyMap.keyO:
        return const BaseKey(
            LogicalKeyboardKey.keyO, "O key", "0x006f", 0x4F, 0x1F);
      case KeyMap.keyP:
        return const BaseKey(
            LogicalKeyboardKey.keyP, "P key", "0x0070", 0x50, 0x23);
      case KeyMap.keyQ:
        return const BaseKey(
            LogicalKeyboardKey.keyQ, "Q key", "0x0071", 0x51, 0x0C);
      case KeyMap.keyR:
        return const BaseKey(
            LogicalKeyboardKey.keyR, "R key", "0x0072", 0x52, 0x0F);
      case KeyMap.keyS:
        return const BaseKey(
            LogicalKeyboardKey.keyS, "S key", "0x0073", 0x53, 0x01);
      case KeyMap.keyT:
        return const BaseKey(
            LogicalKeyboardKey.keyT, "T key", "0x0074", 0x54, 0x11);
      case KeyMap.keyU:
        return const BaseKey(
            LogicalKeyboardKey.keyU, "U key", "0x0075", 0x55, 0x20);
      case KeyMap.keyV:
        return const BaseKey(
            LogicalKeyboardKey.keyV, "V key", "0x0076", 0x56, 0x09);
      case KeyMap.keyW:
        return const BaseKey(
            LogicalKeyboardKey.keyW, "W key", "0x0077", 0x57, 0x0D);
      case KeyMap.keyX:
        return const BaseKey(
            LogicalKeyboardKey.keyX, "X key", "0x0078", 0x58, 0x07);
      case KeyMap.keyY:
        return const BaseKey(
            LogicalKeyboardKey.keyY, "Y key", "0x0079", 0x59, 0x10);
      case KeyMap.keyZ:
        return const BaseKey(
            LogicalKeyboardKey.keyZ, "Z key", "0x007a", 0x5A, 0x06);
      case KeyMap.metaLeft:
        return const BaseKey(LogicalKeyboardKey.metaLeft,
            "Left Windows key (Natural keyboard)", "0xffe7", 0x5B, 0x37);
      case KeyMap.metaRight:
        return const BaseKey(LogicalKeyboardKey.metaRight,
            "Right Windows key (Natural keyboard)", "0xffe8", 0x5C, 0x36);
      case KeyMap.contextMenu:
        return const BaseKey(LogicalKeyboardKey.contextMenu,
            "Applications key (Natural keyboard)", "0xff67", 0x5D, 0x3D);
      case KeyMap.sleep:
        return const BaseKey(
            LogicalKeyboardKey.sleep, "Computer Sleep key", null, 0x5F, 0x3F);
      case KeyMap.numpad0:
        return const BaseKey(LogicalKeyboardKey.numpad0, "Numeric keypad 0 key",
            "0xffb0", 0x60, 0x52);
      case KeyMap.numpad1:
        return const BaseKey(LogicalKeyboardKey.numpad1, "Numeric keypad 1 key",
            "0xffb1", 0x61, 0x53);
      case KeyMap.numpad2:
        return const BaseKey(LogicalKeyboardKey.numpad2, "Numeric keypad 2 key",
            "0xffb2", 0x62, 0x54);
      case KeyMap.numpad3:
        return const BaseKey(LogicalKeyboardKey.numpad3, "Numeric keypad 3 key",
            "0xffb3", 0x63, 0x55);
      case KeyMap.numpad4:
        return const BaseKey(LogicalKeyboardKey.numpad4, "Numeric keypad 4 key",
            "0xffb4", 0x64, 0x56);
      case KeyMap.numpad5:
        return const BaseKey(LogicalKeyboardKey.numpad5, "Numeric keypad 5 key",
            "0xffb5", 0x65, 0x57);
      case KeyMap.numpad6:
        return const BaseKey(LogicalKeyboardKey.numpad6, "Numeric keypad 6 key",
            "0xffb6", 0x66, 0x58);
      case KeyMap.numpad7:
        return const BaseKey(LogicalKeyboardKey.numpad7, "Numeric keypad 7 key",
            "0xffb7", 0x67, 0x59);
      case KeyMap.numpad8:
        return const BaseKey(LogicalKeyboardKey.numpad8, "Numeric keypad 8 key",
            "0xffb8", 0x68, 0x5B);
      case KeyMap.numpad9:
        return const BaseKey(LogicalKeyboardKey.numpad9, "Numeric keypad 9 key",
            "0xffb9", 0x69, 0x5C);
      case KeyMap.numpadMultiply:
        return const BaseKey(LogicalKeyboardKey.numpadMultiply, "Multiply key",
            "0xffaa", 0x6A, 0x43);
      case KeyMap.numpadAdd:
        return const BaseKey(
            LogicalKeyboardKey.numpadAdd, "Add key", "0xffab", 0x6B, 0x45);
      case KeyMap.numpadComma:
        return const BaseKey(LogicalKeyboardKey.numpadComma, "Separator key",
            "0xffac", 0x6C, 0x4C);
      case KeyMap.numpadSubtract:
        return const BaseKey(LogicalKeyboardKey.numpadSubtract, "Subtract key",
            "0xffad", 0x6D, 0x4E);
      case KeyMap.numpadDecimal:
        return const BaseKey(LogicalKeyboardKey.numpadDecimal, "Decimal key",
            "0xffae", 0x6E, 0x41);
      case KeyMap.numpadDivide:
        return const BaseKey(LogicalKeyboardKey.numpadDivide, "Divide key",
            "0xffaf", 0x6F, 0x4B);
      case KeyMap.f1:
        return const BaseKey(
            LogicalKeyboardKey.f1, "F1 key", "0xffbe", 0x70, 0x7A);
      case KeyMap.f2:
        return const BaseKey(
            LogicalKeyboardKey.f2, "F2 key", "0xffbf", 0x71, 0x78);
      case KeyMap.f3:
        return const BaseKey(
            LogicalKeyboardKey.f3, "F3 key", "0xffc0", 0x72, 0x63);
      case KeyMap.f4:
        return const BaseKey(
            LogicalKeyboardKey.f4, "F4 key", "0xffc1", 0x73, 0x76);
      case KeyMap.f5:
        return const BaseKey(
            LogicalKeyboardKey.f5, "F5 key", "0xffc2", 0x74, 0x60);
      case KeyMap.f6:
        return const BaseKey(
            LogicalKeyboardKey.f6, "F6 key", "0xffc3", 0x75, 0x61);
      case KeyMap.f7:
        return const BaseKey(
            LogicalKeyboardKey.f7, "F7 key", "0xffc4", 0x76, 0x62);
      case KeyMap.f8:
        return const BaseKey(
            LogicalKeyboardKey.f8, "F8 key", "0xffc5", 0x77, 0x64);
      case KeyMap.f9:
        return const BaseKey(
            LogicalKeyboardKey.f9, "F9 key", "0xffc6", 0x78, 0x65);
      case KeyMap.f10:
        return const BaseKey(
            LogicalKeyboardKey.f10, "F10 key", "0xffc7", 0x79, 0x6D);
      case KeyMap.f11:
        return const BaseKey(
            LogicalKeyboardKey.f11, "F11 key", "0xffc8", 0x7A, 0x67);
      case KeyMap.f12:
        return const BaseKey(
            LogicalKeyboardKey.f12, "F12 key", "0xffc9", 0x7B, 0x6F);
      case KeyMap.f13:
        return const BaseKey(
            LogicalKeyboardKey.f13, "F13 key", "0xffca", 0x7C, 0x69);
      case KeyMap.f14:
        return const BaseKey(
            LogicalKeyboardKey.f14, "F14 key", "0xffcb", 0x7D, 0x6B);
      case KeyMap.f15:
        return const BaseKey(
            LogicalKeyboardKey.f15, "F15 key", "0xffcc", 0x7E, 0x71);
      case KeyMap.f16:
        return const BaseKey(
            LogicalKeyboardKey.f16, "F16 key", "0xffcd", 0x7F, 0x6A);
      case KeyMap.f17:
        return const BaseKey(
            LogicalKeyboardKey.f17, "F17 key", "0xffce", 0x80, 0x40);
      case KeyMap.f18:
        return const BaseKey(
            LogicalKeyboardKey.f18, "F18 key", "0xffcf", 0x81, 0x4F);
      case KeyMap.f19:
        return const BaseKey(
            LogicalKeyboardKey.f19, "F19 key", "0xffd0", 0x82, 0x50);
      case KeyMap.f20:
        return const BaseKey(
            LogicalKeyboardKey.f20, "F20 key", "0xffd1", 0x83, 0x5A);
      case KeyMap.f21:
        return const BaseKey(
            LogicalKeyboardKey.f21, "F21 key", "0xffd2", 0x84, null);
      case KeyMap.f22:
        return const BaseKey(
            LogicalKeyboardKey.f22, "F22 key", "0xffd3", 0x85, null);
      case KeyMap.f23:
        return const BaseKey(
            LogicalKeyboardKey.f23, "F23 key", "0xffd4", 0x86, null);
      case KeyMap.f24:
        return const BaseKey(
            LogicalKeyboardKey.f24, "F24 key", "0xffd5", 0x87, null);
      case KeyMap.numLock:
        return const BaseKey(
            LogicalKeyboardKey.numLock, "NUM LOCK key", "0xff7f", 0x90, null);
      case KeyMap.scrollLock:
        return const BaseKey(LogicalKeyboardKey.scrollLock, "SCROLL LOCK key",
            "0xff14", 0x91, null);
      case KeyMap.shiftLeft:
        return const BaseKey(LogicalKeyboardKey.shiftLeft, "Left SHIFT key",
            "0xffe1", 0xA0, 0x38);
      case KeyMap.shiftRight:
        return const BaseKey(LogicalKeyboardKey.shiftRight, "Right SHIFT key",
            "0xffe2", 0xA1, 0x3C);
      case KeyMap.controlLeft:
        return const BaseKey(LogicalKeyboardKey.controlLeft, "Left CONTROL key",
            "0xffe3", 0xA2, 0x3B);
      case KeyMap.controlRight:
        return const BaseKey(LogicalKeyboardKey.controlRight,
            "Right CONTROL key", "0xffe4", 0xA3, 0x3E);
      case KeyMap.altLeft:
        return const BaseKey(
            LogicalKeyboardKey.altLeft, "Left MENU key", "0xffe9", 0xA4, 0x3A);
      case KeyMap.altRight:
        return const BaseKey(LogicalKeyboardKey.altRight, "Right MENU key",
            "0xffea", 0xA5, 0x3D);
      case KeyMap.browserBack:
        return const BaseKey(LogicalKeyboardKey.browserBack, "Browser Back key",
            null, 0xA6, null);
      case KeyMap.browserForward:
        return const BaseKey(LogicalKeyboardKey.browserForward,
            "Browser Forward key", null, 0xA7, null);
      case KeyMap.browserRefresh:
        return const BaseKey(LogicalKeyboardKey.browserRefresh,
            "Browser Refresh key", null, 0xA8, null);
      case KeyMap.browserStop:
        return const BaseKey(LogicalKeyboardKey.browserStop, "Browser Stop key",
            null, 0xA9, null);
      case KeyMap.browserSearch:
        return const BaseKey(LogicalKeyboardKey.browserSearch,
            "Browser Search key", null, 0xAA, null);
      case KeyMap.browserFavorites:
        return const BaseKey(LogicalKeyboardKey.browserFavorites,
            "Browser Favorites key", null, 0xAB, null);
      case KeyMap.browserHome:
        return const BaseKey(LogicalKeyboardKey.browserHome,
            "Browser Start and Home key", null, 0xAC, null);
      case KeyMap.audioVolumeMute:
        return const BaseKey(LogicalKeyboardKey.audioVolumeMute,
            "Volume Mute key", "XF86AudioMute", 0xAD, 0x4A);
      case KeyMap.audioVolumeDown:
        return const BaseKey(LogicalKeyboardKey.audioVolumeDown,
            "Volume Down key", "XF86AudioLowerVolume", 0xAE, 0x49);
      case KeyMap.audioVolumeUp:
        return const BaseKey(LogicalKeyboardKey.audioVolumeUp, "Volume Up key",
            "XF86AudioRaiseVolume", 0xAF, 0x48);
      case KeyMap.mediaTrackNext:
        return const BaseKey(LogicalKeyboardKey.mediaTrackNext,
            "Next Track key", "XF86AudioNext", 0xB0, null);
      case KeyMap.mediaTrackPrevious:
        return const BaseKey(LogicalKeyboardKey.mediaTrackPrevious,
            "Previous Track key", "XF86AudioPrev", 0xB1, null);
      case KeyMap.mediaStop:
        return const BaseKey(LogicalKeyboardKey.mediaStop, "Stop Media key",
            "XF86AudioStop", 0xB2, null);
      case KeyMap.mediaPlayPause:
        return const BaseKey(LogicalKeyboardKey.mediaPlayPause,
            "Play/Pause Media key", "XF86AudioPlay", 0xB3, null);
      case KeyMap.launchMail:
        return const BaseKey(
            LogicalKeyboardKey.launchMail, "Start Mail key", null, 0xB4, null);
      case KeyMap.selectMediaKey:
        return const BaseKey(null, "Select Media key", null, 0xB5, null);
      case KeyMap.launchApplication1:
        return const BaseKey(LogicalKeyboardKey.launchApplication1,
            "Start Application 1 key", null, 0xB6, null);
      case KeyMap.launchApplication2:
        return const BaseKey(LogicalKeyboardKey.launchApplication2,
            "Start Application 2 key", null, 0xB7, null);
      case KeyMap.semicolon:
        return const BaseKey(
            LogicalKeyboardKey.semicolon,
            "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ';:' key",
            "0x003b",
            0xBA,
            0x29);
      case KeyMap.equal:
        return const BaseKey(LogicalKeyboardKey.equal,
            "For any country/region, the '+' key", "0x003d", 0xBB, 0x18);
      case KeyMap.comma:
        return const BaseKey(LogicalKeyboardKey.comma,
            "For any country/region, the ',' key", "0x002c", 0xBC, 0x2B);
      case KeyMap.minus:
        return const BaseKey(LogicalKeyboardKey.minus,
            "For any country/region, the '-' key", "0x002d", 0xBD, 0x1B);
      case KeyMap.period:
        return const BaseKey(LogicalKeyboardKey.period,
            "For any country/region, the '.' key", "0x002e", 0xBE, 0x2F);
      case KeyMap.slash:
        return const BaseKey(
            LogicalKeyboardKey.slash,
            "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '/?' key",
            "0x002f",
            0xBF,
            0x2C);
      case KeyMap.backquote:
        return const BaseKey(
            LogicalKeyboardKey.backquote,
            "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '`~' key",
            "0x0060",
            0xC0,
            0x32);
      case KeyMap.bracketLeft:
        return const BaseKey(
            LogicalKeyboardKey.bracketLeft,
            "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '[{' key",
            "0x005b",
            0xDB,
            0x21);
      case KeyMap.backslash:
        return const BaseKey(
            LogicalKeyboardKey.backslash,
            "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '\\|' key",
            "0x005c",
            0xDC,
            0x2A);
      case KeyMap.bracketRight:
        return const BaseKey(
            LogicalKeyboardKey.bracketRight,
            "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ']}' key",
            "0x005d",
            0xDD,
            0x1E);
      case KeyMap.quote:
        return const BaseKey(
            LogicalKeyboardKey.quote,
            "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the 'single-quote/double-quote' key",
            "0x0060",
            0xDE,
            0x27);
      case KeyMap.vkOem8:
        return const BaseKey(
            null,
            "Used for miscellaneous characters; it can vary by keyboard.",
            null,
            0xDF,
            null);
      case KeyMap.imeProcessKey:
        return const BaseKey(null, "IME PROCESS key", null, 0xE5, null);
      case KeyMap.vkPacket:
        return const BaseKey(
            null,
            "Used to pass Unicode characters as if they were keystrokes. The VK_PACKET key is the low word of a 32-bit Virtual Key windowsValue used for non-keyboard input methods.",
            null,
            0xE7,
            null);
      case KeyMap.vkAttn:
        return const BaseKey(null, "Attn key", null, 0xF6, null);
      case KeyMap.vkCrSel:
        return const BaseKey(null, "CrSel key", null, 0xF7, null);
      case KeyMap.vkExSel:
        return const BaseKey(null, "ExSel key", null, 0xF8, null);
      case KeyMap.vkErEOF:
        return const BaseKey(null, "Erase EOF key", null, 0xF9, null);
      case KeyMap.vkPlay:
        return const BaseKey(null, "Play key", null, 0xFA, null);
      case KeyMap.vkZoom:
        return const BaseKey(null, "Zoom key", null, 0xFB, null);
      case KeyMap.vkNoName:
        return const BaseKey(null, "Reserved", null, 0xFC, null);
      case KeyMap.vkPA1:
        return const BaseKey(null, "PA1 key", null, 0xFD, null);
      case KeyMap.vkOemClear:
        return const BaseKey(null, "Clear key", null, 0xFE, null);
    }
  }
}
