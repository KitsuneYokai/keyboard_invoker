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

final List keyMapping = [
  {
    "key": "VK_LBUTTON",
    "windowsValue": 0x01,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Left mouse button",
    "logicalKeyId": null,
  },
  {
    "key": "VK_RBUTTON",
    "windowsValue": 0x02,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Right mouse button",
    "logicalKeyId": null,
  },
  {
    "key": "VK_CANCEL",
    "windowsValue": 0x03,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Control-break processing",
    "logicalKeyId": null,
  },
  {
    "key": "VK_MBUTTON",
    "windowsValue": 0x04,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Middle mouse button (three-button mouse)",
    "logicalKeyId": null,
  },
  {
    "key": "VK_XBUTTON1",
    "windowsValue": 0x05,
    "macOSValue": null,
    "linuxValue": null,
    "description": "X1 mouse button",
    "logicalKeyId": null,
  },
  {
    "key": "VK_XBUTTON2",
    "windowsValue": 0x06,
    "macOSValue": null,
    "linuxValue": null,
    "description": "X2 mouse button",
    "logicalKeyId": null,
  },
  {
    "key": "VK_BACK",
    "windowsValue": 0x08,
    "macOSValue": 0x33,
    "linuxValue": "0xff08",
    "description": "BACKSPACE key",
    "logicalKeyId": LogicalKeyboardKey.backspace.keyId,
  },
  {
    "key": "VK_TAB",
    "windowsValue": 0x09,
    "macOSValue": 0x30,
    "linuxValue": "0xff09",
    "description": "TAB key",
    "logicalKeyId": LogicalKeyboardKey.tab.keyId,
  },
  {
    "key": "VK_CLEAR",
    "windowsValue": 0x0C,
    "macOSValue": null,
    "linuxValue": "0xff0b",
    "description": "CLEAR key",
    "logicalKeyId": LogicalKeyboardKey.clear.keyId,
  },
  {
    "key": "VK_RETURN",
    "windowsValue": 0x0D,
    "macOSValue": 0x24,
    "linuxValue": "0xff0d",
    "description": "ENTER key",
    "logicalKeyId": LogicalKeyboardKey.enter.keyId,
  },
  {
    "key": "VK_SHIFT",
    "windowsValue": 0x10,
    "macOSValue": 0x38,
    "linuxValue": "0xffe1",
    "description": "SHIFT key",
    "logicalKeyId": LogicalKeyboardKey.shift.keyId,
  },
  {
    "key": "VK_CONTROL",
    "windowsValue": 0x11,
    "macOSValue": 0x3B,
    "linuxValue": "0xffe3",
    "description": "CTRL key",
    "logicalKeyId": LogicalKeyboardKey.control.keyId,
  },
  {
    "key": "VK_MENU",
    "windowsValue": 0x12,
    "macOSValue": 0x3A,
    "linuxValue": "0xffe9",
    "description": "ALT key",
    "logicalKeyId": LogicalKeyboardKey.alt.keyId,
  },
  {
    "key": "VK_PAUSE",
    "windowsValue": 0x13,
    "macOSValue": 0x71,
    "linuxValue": "0xff13",
    "description": "PAUSE key",
    "logicalKeyId": LogicalKeyboardKey.pause.keyId,
  },
  {
    "key": "VK_CAPITAL",
    "windowsValue": 0x14,
    "macOSValue": 0x39,
    "linuxValue": "0xffe5",
    "description": "CAPS LOCK key",
    "logicalKeyId": LogicalKeyboardKey.capsLock.keyId,
  },
  {
    "key": "VK_KANA",
    "windowsValue": 0x15,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Input Method Editor (IME) Kana mode",
    "logicalKeyId": null,
  },
  {
    "key": "VK_HANGUEL",
    "windowsValue": 0x15,
    "macOSValue": null,
    "linuxValue": null,
    "description":
        "IME Hanguel mode (maintained for compatibility; use VK_HANGUL)",
    "logicalKeyId": null,
  },
  {
    "key": "VK_HANGUL",
    "windowsValue": 0x15,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME Hangul mode",
    "logicalKeyId": null,
  },
  {
    "key": "VK_IME_ON",
    "windowsValue": 0x16,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME On",
    "logicalKeyId": null,
  },
  {
    "key": "VK_JUNJA",
    "windowsValue": 0x17,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME Junja mode",
    "logicalKeyId": null,
  },
  {
    "key": "VK_FINAL",
    "windowsValue": 0x18,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME final mode",
    "logicalKeyId": null,
  },
  {
    "key": "VK_HANJA",
    "windowsValue": 0x19,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME Hanja mode",
    "logicalKeyId": null,
  },
  {
    "key": "VK_KANJI",
    "windowsValue": 0x19,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME Kanji mode",
    "logicalKeyId": null,
  },
  {
    "key": "VK_IME_OFF",
    "windowsValue": 0x1A,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME Off",
    "logicalKeyId": null,
  },
  {
    "key": "VK_ESCAPE",
    "windowsValue": 0x1B,
    "macOSValue": 0x35,
    "linuxValue": "0xff1b",
    "description": "ESC key",
    "logicalKeyId": LogicalKeyboardKey.escape.keyId,
  },
  {
    "key": "VK_CONVERT",
    "windowsValue": 0x1C,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME convert",
    "logicalKeyId": null,
  },
  {
    "key": "VK_NONCONVERT",
    "windowsValue": 0x1D,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME nonconvert",
    "logicalKeyId": null,
  },
  {
    "key": "VK_ACCEPT",
    "windowsValue": 0x1E,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME accept",
    "logicalKeyId": null,
  },
  {
    "key": "VK_MODECHANGE",
    "windowsValue": 0x1F,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME mode change request",
    "logicalKeyId": null,
  },
  {
    "key": "VK_SPACE",
    "windowsValue": 0x20,
    "macOSValue": 0x31,
    "linuxValue": "0x0020",
    "description": "SPACEBAR",
    "logicalKeyId": LogicalKeyboardKey.space.keyId,
  },
  {
    "key": "VK_PRIOR",
    "windowsValue": 0x21,
    "macOSValue": 0x74,
    "linuxValue": "0xff55",
    "description": "PAGE UP key",
    "logicalKeyId": LogicalKeyboardKey.pageUp.keyId,
  },
  {
    "key": "VK_NEXT",
    "windowsValue": 0x22,
    "macOSValue": 0x79,
    "linuxValue": "0xff56",
    "description": "PAGE DOWN key",
    "logicalKeyId": LogicalKeyboardKey.pageDown.keyId,
  },
  {
    "key": "VK_END",
    "windowsValue": 0x23,
    "macOSValue": 0x77,
    "linuxValue": "0xff57",
    "description": "END key",
    "logicalKeyId": LogicalKeyboardKey.end.keyId,
  },
  {
    "key": "VK_HOME",
    "windowsValue": 0x24,
    "macOSValue": 0x73,
    "linuxValue": "0xff50",
    "description": "HOME key",
    "logicalKeyId": LogicalKeyboardKey.home.keyId,
  },
  {
    "key": "VK_LEFT",
    "windowsValue": 0x25,
    "macOSValue": 0x7B,
    "linuxValue": "0xff51",
    "description": "LEFT ARROW key",
    "logicalKeyId": LogicalKeyboardKey.arrowLeft.keyId,
  },
  {
    "key": "VK_UP",
    "windowsValue": 0x26,
    "macOSValue": 0x7E,
    "linuxValue": "0xff52",
    "description": "UP ARROW key",
    "logicalKeyId": LogicalKeyboardKey.arrowUp.keyId,
  },
  {
    "key": "VK_RIGHT",
    "windowsValue": 0x27,
    "macOSValue": 0x7C,
    "linuxValue": "0xff53",
    "description": "RIGHT ARROW key",
    "logicalKeyId": LogicalKeyboardKey.arrowRight.keyId,
  },
  {
    "key": "VK_DOWN",
    "windowsValue": 0x28,
    "macOSValue": 0x7D,
    "linuxValue": "0xff54",
    "description": "DOWN ARROW key",
    "logicalKeyId": LogicalKeyboardKey.arrowDown.keyId,
  },
  {
    "key": "VK_SELECT",
    "windowsValue": 0x29,
    "macOSValue": null,
    "linuxValue": "0xff60",
    "description": "SELECT key",
    "logicalKeyId": LogicalKeyboardKey.select.keyId,
  },
  {
    "key": "VK_PRINT",
    "windowsValue": 0x2A,
    "macOSValue": null,
    "linuxValue": "0xff61",
    "description": "PRINT key",
    "logicalKeyId": LogicalKeyboardKey.printScreen.keyId,
  },
  {
    "key": "VK_EXECUTE",
    "windowsValue": 0x2B,
    "macOSValue": null,
    "linuxValue": "0xff62",
    "description": "EXECUTE key",
    "logicalKeyId": LogicalKeyboardKey.execute.keyId,
  },
  {
    "key": "VK_SNAPSHOT",
    "windowsValue": 0x2C,
    "macOSValue": null,
    "linuxValue": "0xfd1d",
    "description": "PRINT SCREEN key",
    "logicalKeyId": LogicalKeyboardKey.printScreen.keyId,
  },
  {
    "key": "VK_INSERT",
    "windowsValue": 0x2D,
    "macOSValue": 0x72,
    "linuxValue": "0xff63",
    "description": "INS key",
    "logicalKeyId": LogicalKeyboardKey.insert.keyId,
  },
  {
    "key": "VK_DELETE",
    "windowsValue": 0x2E,
    "macOSValue": 0x75,
    "linuxValue": "0xffff",
    "description": "DEL key",
    "logicalKeyId": LogicalKeyboardKey.delete.keyId,
  },
  {
    "key": "VK_HELP",
    "windowsValue": 0x2F,
    "macOSValue": 0x72,
    "linuxValue": "0xff6a",
    "description": "HELP key",
    "logicalKeyId": LogicalKeyboardKey.help.keyId,
  },
  {
    "key": "VK_0",
    "windowsValue": 0x30,
    "macOSValue": 0x1D,
    "linuxValue": "0x0030",
    "description": "0 key",
    "logicalKeyId": LogicalKeyboardKey.digit0.keyId,
  },
  {
    "key": "VK_1",
    "windowsValue": 0x31,
    "macOSValue": 0x12,
    "linuxValue": "0x0031",
    "description": "1 key",
    "logicalKeyId": LogicalKeyboardKey.digit1.keyId,
  },
  {
    "key": "VK_2",
    "windowsValue": 0x32,
    "macOSValue": 0x13,
    "linuxValue": "0x0032",
    "description": "2 key",
    "logicalKeyId": LogicalKeyboardKey.digit2.keyId,
  },
  {
    "key": "VK_3",
    "windowsValue": 0x33,
    "macOSValue": 0x14,
    "linuxValue": "0x0033",
    "description": "3 key",
    "logicalKeyId": LogicalKeyboardKey.digit3.keyId,
  },
  {
    "key": "VK_4",
    "windowsValue": 0x34,
    "macOSValue": 0x15,
    "linuxValue": "0x0034",
    "description": "4 key",
    "logicalKeyId": LogicalKeyboardKey.digit4.keyId,
  },
  {
    "key": "VK_5",
    "windowsValue": 0x35,
    "macOSValue": 0x17,
    "linuxValue": "0x0035",
    "description": "5 key",
    "logicalKeyId": LogicalKeyboardKey.digit5.keyId,
  },
  {
    "key": "VK_6",
    "windowsValue": 0x36,
    "macOSValue": 0x16,
    "linuxValue": "0x0036",
    "description": "6 key",
    "logicalKeyId": LogicalKeyboardKey.digit6.keyId,
  },
  {
    "key": "VK_7",
    "windowsValue": 0x37,
    "macOSValue": 0x1A,
    "linuxValue": "0x0037",
    "description": "7 key",
    "logicalKeyId": LogicalKeyboardKey.digit7.keyId,
  },
  {
    "key": "VK_8",
    "windowsValue": 0x38,
    "macOSValue": 0x1C,
    "linuxValue": "0x0038",
    "description": "8 key",
    "logicalKeyId": LogicalKeyboardKey.digit8.keyId,
  },
  {
    "key": "VK_9",
    "windowsValue": 0x39,
    "macOSValue": 0x19,
    "linuxValue": "0x0039",
    "description": "9 key",
    "logicalKeyId": LogicalKeyboardKey.digit9.keyId,
  },
  {
    "key": "VK_A",
    "windowsValue": 0x41,
    "macOSValue": 0x00,
    "linuxValue": "0x0061",
    "description": "A key",
    "logicalKeyId": LogicalKeyboardKey.keyA.keyId,
  },
  {
    "key": "VK_B",
    "windowsValue": 0x42,
    "macOSValue": 0x0B,
    "linuxValue": "0x0062",
    "description": "B key",
    "logicalKeyId": LogicalKeyboardKey.keyB.keyId,
  },
  {
    "key": "VK_C",
    "windowsValue": 0x43,
    "macOSValue": 0x08,
    "linuxValue": "0x0063",
    "description": "C key",
    "logicalKeyId": LogicalKeyboardKey.keyC.keyId,
  },
  {
    "key": "VK_D",
    "windowsValue": 0x44,
    "macOSValue": 0x02,
    "linuxValue": "0x0064",
    "description": "D key",
    "logicalKeyId": LogicalKeyboardKey.keyD.keyId,
  },
  {
    "key": "VK_E",
    "windowsValue": 0x45,
    "macOSValue": 0x0E,
    "linuxValue": "0x0065",
    "description": "E key",
    "logicalKeyId": LogicalKeyboardKey.keyE.keyId,
  },
  {
    "key": "VK_F",
    "windowsValue": 0x46,
    "macOSValue": 0x03,
    "linuxValue": "0x0066",
    "description": "F key",
    "logicalKeyId": LogicalKeyboardKey.keyF.keyId,
  },
  {
    "key": "VK_G",
    "windowsValue": 0x47,
    "macOSValue": 0x05,
    "linuxValue": "0x0067",
    "description": "G key",
    "logicalKeyId": LogicalKeyboardKey.keyG.keyId,
  },
  {
    "key": "VK_H",
    "windowsValue": 0x48,
    "macOSValue": 0x04,
    "linuxValue": "0x0068",
    "description": "H key",
    "logicalKeyId": LogicalKeyboardKey.keyH.keyId,
  },
  {
    "key": "VK_I",
    "windowsValue": 0x49,
    "macOSValue": 0x22,
    "linuxValue": "0x0069",
    "description": "I key",
    "logicalKeyId": LogicalKeyboardKey.keyI.keyId,
  },
  {
    "key": "VK_J",
    "windowsValue": 0x4A,
    "macOSValue": 0x26,
    "linuxValue": "0x006a",
    "description": "J key",
    "logicalKeyId": LogicalKeyboardKey.keyJ.keyId,
  },
  {
    "key": "VK_K",
    "windowsValue": 0x4B,
    "macOSValue": 0x28,
    "linuxValue": "0x006b",
    "description": "K key",
    "logicalKeyId": LogicalKeyboardKey.keyK.keyId,
  },
  {
    "key": "VK_L",
    "windowsValue": 0x4C,
    "macOSValue": 0x25,
    "linuxValue": "0x006c",
    "description": "L key",
    "logicalKeyId": LogicalKeyboardKey.keyL.keyId,
  },
  {
    "key": "VK_M",
    "windowsValue": 0x4D,
    "macOSValue": 0x2E,
    "linuxValue": "0x006d",
    "description": "M key",
    "logicalKeyId": LogicalKeyboardKey.keyM.keyId,
  },
  {
    "key": "VK_N",
    "windowsValue": 0x4E,
    "macOSValue": 0x2D,
    "linuxValue": "0x006e",
    "description": "N key",
    "logicalKeyId": LogicalKeyboardKey.keyN.keyId,
  },
  {
    "key": "VK_O",
    "windowsValue": 0x4F,
    "macOSValue": 0x1F,
    "linuxValue": "0x006f",
    "description": "O key",
    "logicalKeyId": LogicalKeyboardKey.keyO.keyId,
  },
  {
    "key": "VK_P",
    "windowsValue": 0x50,
    "macOSValue": 0x23,
    "linuxValue": "0x0070",
    "description": "P key",
    "logicalKeyId": LogicalKeyboardKey.keyP.keyId,
  },
  {
    "key": "VK_Q",
    "windowsValue": 0x51,
    "macOSValue": 0x0C,
    "linuxValue": "0x0071",
    "description": "Q key",
    "logicalKeyId": LogicalKeyboardKey.keyQ.keyId,
  },
  {
    "key": "VK_R",
    "windowsValue": 0x52,
    "macOSValue": 0x0F,
    "linuxValue": "0x0072",
    "description": "R key",
    "logicalKeyId": LogicalKeyboardKey.keyR.keyId,
  },
  {
    "key": "VK_S",
    "windowsValue": 0x53,
    "macOSValue": 0x01,
    "linuxValue": "0x0073",
    "description": "S key",
    "logicalKeyId": LogicalKeyboardKey.keyS.keyId,
  },
  {
    "key": "VK_T",
    "windowsValue": 0x54,
    "macOSValue": 0x11,
    "linuxValue": "0x0074",
    "description": "T key",
    "logicalKeyId": LogicalKeyboardKey.keyT.keyId,
  },
  {
    "key": "VK_U",
    "windowsValue": 0x55,
    "macOSValue": 0x20,
    "linuxValue": "0x0075",
    "description": "U key",
    "logicalKeyId": LogicalKeyboardKey.keyU.keyId,
  },
  {
    "key": "VK_V",
    "windowsValue": 0x56,
    "macOSValue": 0x09,
    "linuxValue": "0x0076",
    "description": "V key",
    "logicalKeyId": LogicalKeyboardKey.keyV.keyId,
  },
  {
    "key": "VK_W",
    "windowsValue": 0x57,
    "macOSValue": 0x0D,
    "linuxValue": "0x0077",
    "description": "W key",
    "logicalKeyId": LogicalKeyboardKey.keyW.keyId,
  },
  {
    "key": "VK_X",
    "windowsValue": 0x58,
    "macOSValue": 0x07,
    "linuxValue": "0x0078",
    "description": "X key",
    "logicalKeyId": LogicalKeyboardKey.keyX.keyId,
  },
  {
    "key": "VK_Y",
    "windowsValue": 0x59,
    "macOSValue": 0x10,
    "linuxValue": "0x0079",
    "description": "Y key",
    "logicalKeyId": LogicalKeyboardKey.keyY.keyId,
  },
  {
    "key": "VK_Z",
    "windowsValue": 0x5A,
    "macOSValue": 0x06,
    "linuxValue": "0x007a",
    "description": "Z key",
    "logicalKeyId": LogicalKeyboardKey.keyZ.keyId,
  },
  {
    "key": "VK_LWIN",
    "windowsValue": 0x5B,
    "macOSValue": 0x37,
    "linuxValue": "0xffe7",
    "description": "Left Windows key (Natural keyboard)",
    "logicalKeyId": LogicalKeyboardKey.metaLeft.keyId,
  },
  {
    "key": "VK_RWIN",
    "windowsValue": 0x5C,
    "macOSValue": 0x36,
    "linuxValue": "0xffe8",
    "description": "Right Windows key (Natural keyboard)",
    "logicalKeyId": LogicalKeyboardKey.metaRight.keyId,
  },
  {
    "key": "VK_APPS",
    "windowsValue": 0x5D,
    "macOSValue": 0x3D,
    "linuxValue": "0xff67",
    "description": "Applications key (Natural keyboard)",
    "logicalKeyId": LogicalKeyboardKey.contextMenu.keyId,
  },
  {
    "key": "VK_SLEEP",
    "windowsValue": 0x5F,
    "macOSValue": 0x3F,
    "linuxValue": null, //TODO: Find linux value
    "description": "Computer Sleep key",
    "logicalKeyId": LogicalKeyboardKey.sleep.keyId,
  },
  {
    "key": "VK_NUMPAD0",
    "windowsValue": 0x60,
    "macOSValue": 0x52,
    "linuxValue": "0xffb0",
    "description": "Numeric keypad 0 key",
    "logicalKeyId": LogicalKeyboardKey.numpad0.keyId,
  },
  {
    "key": "VK_NUMPAD1",
    "windowsValue": 0x61,
    "macOSValue": 0x53,
    "linuxValue": "0xffb1",
    "description": "Numeric keypad 1 key",
    "logicalKeyId": LogicalKeyboardKey.numpad1.keyId,
  },
  {
    "key": "VK_NUMPAD2",
    "windowsValue": 0x62,
    "macOSValue": 0x54,
    "linuxValue": "0xffb2",
    "description": "Numeric keypad 2 key",
    "logicalKeyId": LogicalKeyboardKey.numpad2.keyId,
  },
  {
    "key": "VK_NUMPAD3",
    "windowsValue": 0x63,
    "macOSValue": 0x55,
    "linuxValue": "0xffb3",
    "description": "Numeric keypad 3 key",
    "logicalKeyId": LogicalKeyboardKey.numpad3.keyId,
  },
  {
    "key": "VK_NUMPAD4",
    "windowsValue": 0x64,
    "macOSValue": 0x56,
    "linuxValue": "0xffb4",
    "description": "Numeric keypad 4 key",
    "logicalKeyId": LogicalKeyboardKey.numpad4.keyId,
  },
  {
    "key": "VK_NUMPAD5",
    "windowsValue": 0x65,
    "macOSValue": 0x57,
    "linuxValue": "0xffb5",
    "description": "Numeric keypad 5 key",
    "logicalKeyId": LogicalKeyboardKey.numpad5.keyId,
  },
  {
    "key": "VK_NUMPAD6",
    "windowsValue": 0x66,
    "macOSValue": 0x58,
    "linuxValue": "0xffb6",
    "description": "Numeric keypad 6 key",
    "logicalKeyId": LogicalKeyboardKey.numpad6.keyId,
  },
  {
    "key": "VK_NUMPAD7",
    "windowsValue": 0x67,
    "macOSValue": 0x59,
    "linuxValue": "0xffb7",
    "description": "Numeric keypad 7 key",
    "logicalKeyId": LogicalKeyboardKey.numpad7.keyId,
  },
  {
    "key": "VK_NUMPAD8",
    "windowsValue": 0x68,
    "macOSValue": 0x5B,
    "linuxValue": "0xffb8",
    "description": "Numeric keypad 8 key",
    "logicalKeyId": LogicalKeyboardKey.numpad8.keyId,
  },
  {
    "key": "VK_NUMPAD9",
    "windowsValue": 0x69,
    "macOSValue": 0x5C,
    "linuxValue": "0xffb9",
    "description": "Numeric keypad 9 key",
    "logicalKeyId": LogicalKeyboardKey.numpad9.keyId,
  },
  {
    "key": "VK_MULTIPLY",
    "windowsValue": 0x6A,
    "macOSValue": 0x43,
    "linuxValue": "0xffaa",
    "description": "Multiply key",
    "logicalKeyId": LogicalKeyboardKey.numpadMultiply.keyId,
  },
  {
    "key": "VK_ADD",
    "windowsValue": 0x6B,
    "macOSValue": 0x45,
    "linuxValue": "0xffab",
    "description": "Add key",
    "logicalKeyId": LogicalKeyboardKey.numpadAdd.keyId,
  },
  {
    "key": "VK_SEPARATOR",
    "windowsValue": 0x6C,
    "macOSValue": 0x4C,
    "linuxValue": "0xffac",
    "description": "Separator key",
    "logicalKeyId": LogicalKeyboardKey.numpadComma.keyId,
  },
  {
    "key": "VK_SUBTRACT",
    "windowsValue": 0x6D,
    "macOSValue": 0x4E,
    "linuxValue": "0xffad",
    "description": "Subtract key",
    "logicalKeyId": LogicalKeyboardKey.numpadSubtract.keyId,
  },
  {
    "key": "VK_DECIMAL",
    "windowsValue": 0x6E,
    "macOSValue": 0x41,
    "linuxValue": "0xffae",
    "description": "Decimal key",
    "logicalKeyId": LogicalKeyboardKey.numpadDecimal.keyId,
  },
  {
    "key": "VK_DIVIDE",
    "windowsValue": 0x6F,
    "macOSValue": 0x4B,
    "linuxValue": "0xffaf",
    "description": "Divide key",
    "logicalKeyId": LogicalKeyboardKey.numpadDivide.keyId,
  },
  {
    "key": "VK_F1",
    "windowsValue": 0x70,
    "macOSValue": 0x7A,
    "linuxValue": "0xffbe",
    "description": "F1 key",
    "logicalKeyId": LogicalKeyboardKey.f1.keyId,
  },
  {
    "key": "VK_F2",
    "windowsValue": 0x71,
    "macOSValue": 0x78,
    "linuxValue": "0xffbf",
    "description": "F2 key",
    "logicalKeyId": LogicalKeyboardKey.f2.keyId,
  },
  {
    "key": "VK_F3",
    "windowsValue": 0x72,
    "macOSValue": 0x63,
    "linuxValue": "0xffc0",
    "description": "F3 key",
    "logicalKeyId": LogicalKeyboardKey.f3.keyId,
  },
  {
    "key": "VK_F4",
    "windowsValue": 0x73,
    "macOSValue": 0x76,
    "linuxValue": "0xffc1",
    "description": "F4 key",
    "logicalKeyId": LogicalKeyboardKey.f4.keyId,
  },
  {
    "key": "VK_F5",
    "windowsValue": 0x74,
    "macOSValue": 0x60,
    "linuxValue": "0xffc2",
    "description": "F5 key",
    "logicalKeyId": LogicalKeyboardKey.f5.keyId,
  },
  {
    "key": "VK_F6",
    "windowsValue": 0x75,
    "macOSValue": 0x61,
    "linuxValue": "0xffc3",
    "description": "F6 key",
    "logicalKeyId": LogicalKeyboardKey.f6.keyId,
  },
  {
    "key": "VK_F7",
    "windowsValue": 0x76,
    "macOSValue": 0x62,
    "linuxValue": "0xffc4",
    "description": "F7 key",
    "logicalKeyId": LogicalKeyboardKey.f7.keyId,
  },
  {
    "key": "VK_F8",
    "windowsValue": 0x77,
    "macOSValue": 0x64,
    "linuxValue": "0xffc5",
    "description": "F8 key",
    "logicalKeyId": LogicalKeyboardKey.f8.keyId,
  },
  {
    "key": "VK_F9",
    "windowsValue": 0x78,
    "macOSValue": 0x65,
    "linuxValue": "0xffc6",
    "description": "F9 key",
    "logicalKeyId": LogicalKeyboardKey.f9.keyId,
  },
  {
    "key": "VK_F10",
    "windowsValue": 0x79,
    "macOSValue": 0x6D,
    "linuxValue": "0xffc7",
    "description": "F10 key",
    "logicalKeyId": LogicalKeyboardKey.f10.keyId,
  },
  {
    "key": "VK_F11",
    "windowsValue": 0x7A,
    "macOSValue": 0x67,
    "linuxValue": "0xffc8",
    "description": "F11 key",
    "logicalKeyId": LogicalKeyboardKey.f11.keyId,
  },
  {
    "key": "VK_F12",
    "windowsValue": 0x7B,
    "macOSValue": 0x6F,
    "linuxValue": "0xffc9",
    "description": "F12 key",
    "logicalKeyId": LogicalKeyboardKey.f12.keyId,
  },
  {
    "key": "VK_F13",
    "windowsValue": 0x7C,
    "macOSValue": 0x69,
    "linuxValue": "0xffca",
    "description": "F13 key",
    "logicalKeyId": LogicalKeyboardKey.f13.keyId,
  },
  {
    "key": "VK_F14",
    "windowsValue": 0x7D,
    "macOSValue": 0x6B,
    "linuxValue": "0xffcb",
    "description": "F14 key",
    "logicalKeyId": LogicalKeyboardKey.f14.keyId,
  },
  {
    "key": "VK_F15",
    "windowsValue": 0x7E,
    "macOSValue": 0x71,
    "linuxValue": "0xffcc",
    "description": "F15 key",
    "logicalKeyId": LogicalKeyboardKey.f15.keyId,
  },
  {
    "key": "VK_F16",
    "windowsValue": 0x7F,
    "macOSValue": 0x6A,
    "linuxValue": "0xffcd",
    "description": "F16 key",
    "logicalKeyId": LogicalKeyboardKey.f16.keyId,
  },
  {
    "key": "VK_F17",
    "windowsValue": 0x80,
    "macOSValue": 0x40,
    "linuxValue": "0xffce",
    "description": "F17 key",
    "logicalKeyId": LogicalKeyboardKey.f17.keyId,
  },
  {
    "key": "VK_F18",
    "windowsValue": 0x81,
    "macOSValue": 0x4F,
    "linuxValue": "0xffcf",
    "description": "F18 key",
    "logicalKeyId": LogicalKeyboardKey.f18.keyId,
  },
  {
    "key": "VK_F19",
    "windowsValue": 0x82,
    "macOSValue": 0x50,
    "linuxValue": "0xffd0",
    "description": "F19 key",
    "logicalKeyId": LogicalKeyboardKey.f19.keyId,
  },
  {
    "key": "VK_F20",
    "windowsValue": 0x83,
    "macOSValue": 0x5A,
    "linuxValue": "0xffd1",
    "description": "F20 key",
    "logicalKeyId": LogicalKeyboardKey.f20.keyId,
  },
  {
    "key": "VK_F21",
    "windowsValue": 0x84,
    "macOSValue": null,
    "linuxValue": "0xffd2",
    "description": "F21 key",
    "logicalKeyId": LogicalKeyboardKey.f21.keyId,
  },
  {
    "key": "VK_F22",
    "windowsValue": 0x85,
    "macOSValue": null,
    "linuxValue": "0xffd3",
    "description": "F22 key",
    "logicalKeyId": LogicalKeyboardKey.f22.keyId,
  },
  {
    "key": "VK_F23",
    "windowsValue": 0x86,
    "macOSValue": null,
    "linuxValue": "0xffd4",
    "description": "F23 key",
    "logicalKeyId": LogicalKeyboardKey.f23.keyId,
  },
  {
    "key": "VK_F24",
    "windowsValue": 0x87,
    "macOSValue": null,
    "linuxValue": "0xffd5",
    "description": "F24 key",
    "logicalKeyId": LogicalKeyboardKey.f24.keyId,
  },
  {
    "key": "VK_NUMLOCK",
    "windowsValue": 0x90,
    "macOSValue": null,
    "linuxValue": "0xff7f",
    "description": "NUM LOCK key",
    "logicalKeyId": LogicalKeyboardKey.numLock.keyId,
  },
  {
    "key": "VK_SCROLL",
    "windowsValue": 0x91,
    "macOSValue": null,
    "linuxValue": "0xff14",
    "description": "SCROLL LOCK key",
    "logicalKeyId": LogicalKeyboardKey.scrollLock.keyId,
  },
  {
    "key": "VK_LSHIFT",
    "windowsValue": 0xA0,
    "macOSValue": 0x38,
    "linuxValue": "0xffe1",
    "description": "Left SHIFT key",
    "logicalKeyId": LogicalKeyboardKey.shiftLeft.keyId,
  },
  {
    "key": "VK_RSHIFT",
    "windowsValue": 0xA1,
    "macOSValue": 0x3C,
    "linuxValue": "0xffe2",
    "description": "Right SHIFT key",
    "logicalKeyId": LogicalKeyboardKey.shiftRight.keyId,
  },
  {
    "key": "VK_LCONTROL",
    "windowsValue": 0xA2,
    "macOSValue": 0x3B,
    "linuxValue": "0xffe3",
    "description": "Left CONTROL key",
    "logicalKeyId": LogicalKeyboardKey.controlLeft.keyId,
  },
  {
    "key": "VK_RCONTROL",
    "windowsValue": 0xA3,
    "macOSValue": 0x3E,
    "linuxValue": "0xffe4",
    "description": "Right CONTROL key",
    "logicalKeyId": LogicalKeyboardKey.controlRight.keyId,
  },
  {
    "key": "VK_LMENU",
    "windowsValue": 0xA4,
    "macOSValue": 0x3A,
    "linuxValue": "0xffe9",
    "description": "Left MENU key",
    "logicalKeyId": LogicalKeyboardKey.altLeft.keyId,
  },
  {
    "key": "VK_RMENU",
    "windowsValue": 0xA5,
    "macOSValue": 0x3D,
    "linuxValue": "0xffea",
    "description": "Right MENU key",
    "logicalKeyId": LogicalKeyboardKey.altRight.keyId,
  },
  {
    "key": "VK_BROWSER_BACK",
    "windowsValue": 0xA6,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Browser Back key",
    "logicalKeyId": LogicalKeyboardKey.browserBack.keyId,
  },
  {
    "key": "VK_BROWSER_FORWARD",
    "windowsValue": 0xA7,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Browser Forward key",
    "logicalKeyId": LogicalKeyboardKey.browserForward.keyId,
  },
  {
    "key": "VK_BROWSER_REFRESH",
    "windowsValue": 0xA8,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Browser Refresh key",
    "logicalKeyId": LogicalKeyboardKey.browserRefresh.keyId,
  },
  {
    "key": "VK_BROWSER_STOP",
    "windowsValue": 0xA9,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Browser Stop key",
    "logicalKeyId": LogicalKeyboardKey.browserStop.keyId,
  },
  {
    "key": "VK_BROWSER_SEARCH",
    "windowsValue": 0xAA,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Browser Search key",
    "logicalKeyId": LogicalKeyboardKey.browserSearch.keyId,
  },
  {
    "key": "VK_BROWSER_FAVORITES",
    "windowsValue": 0xAB,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Browser Favorites key",
    "logicalKeyId": LogicalKeyboardKey.browserFavorites.keyId,
  },
  {
    "key": "VK_BROWSER_HOME",
    "windowsValue": 0xAC,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Browser Start and Home key",
    "logicalKeyId": LogicalKeyboardKey.browserHome.keyId,
  },
  {
    "key": "VK_VOLUME_MUTE",
    "windowsValue": 0xAD,
    "macOSValue": 0x4A,
    "linuxValue": "XF86AudioMute",
    "description": "Volume Mute key",
    "logicalKeyId": LogicalKeyboardKey.audioVolumeMute.keyId,
  },
  {
    "key": "VK_VOLUME_DOWN",
    "windowsValue": 0xAE,
    "macOSValue": 0x49,
    "linuxValue": "XF86AudioLowerVolume",
    "description": "Volume Down key",
    "logicalKeyId": LogicalKeyboardKey.audioVolumeDown.keyId,
  },
  {
    "key": "VK_VOLUME_UP",
    "windowsValue": 0xAF,
    "macOSValue": 0x48,
    "linuxValue": "XF86AudioRaiseVolume",
    "description": "Volume Up key",
    "logicalKeyId": LogicalKeyboardKey.audioVolumeUp.keyId,
  },
  {
    "key": "VK_MEDIA_NEXT_TRACK",
    "windowsValue": 0xB0,
    "macOSValue": null,
    "linuxValue": "XF86AudioNext",
    "description": "Next Track key",
    "logicalKeyId": LogicalKeyboardKey.mediaTrackNext.keyId,
  },
  {
    "key": "VK_MEDIA_PREV_TRACK",
    "windowsValue": 0xB1,
    "macOSValue": null,
    "linuxValue": "XF86AudioPrev",
    "description": "Previous Track key",
    "logicalKeyId": LogicalKeyboardKey.mediaTrackPrevious.keyId,
  },
  {
    "key": "VK_MEDIA_STOP",
    "windowsValue": 0xB2,
    "macOSValue": null,
    "linuxValue": "XF86AudioStop",
    "description": "Stop Media key",
    "logicalKeyId": LogicalKeyboardKey.mediaStop.keyId,
  },
  {
    "key": "VK_MEDIA_PLAY_PAUSE",
    "windowsValue": 0xB3,
    "macOSValue": null,
    "linuxValue": "XF86AudioPlay",
    "description": "Play/Pause Media key",
    "logicalKeyId": LogicalKeyboardKey.mediaPlayPause.keyId,
  },
  {
    "key": "VK_LAUNCH_MAIL",
    "windowsValue": 0xB4,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Start Mail key",
    "logicalKeyId": LogicalKeyboardKey.launchMail.keyId,
  },
  {
    "key": "VK_LAUNCH_MEDIA_SELECT",
    "windowsValue": 0xB5,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Select Media key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_LAUNCH_APP1",
    "windowsValue": 0xB6,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Start Application 1 key",
    "logicalKeyId": LogicalKeyboardKey.launchApplication1.keyId,
  },
  {
    "key": "VK_LAUNCH_APP2",
    "windowsValue": 0xB7,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Start Application 2 key",
    "logicalKeyId": LogicalKeyboardKey.launchApplication2.keyId,
  },
  {
    "key": "VK_OEM_1",
    "windowsValue": 0xBA,
    "macOSValue": 0x29,
    "linuxValue": "0x003b",
    "description":
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ';:' key",
    "logicalKeyId": LogicalKeyboardKey.semicolon.keyId,
  },
  {
    "key": "VK_OEM_PLUS",
    "windowsValue": 0xBB,
    "macOSValue": 0x18,
    "linuxValue": "0x003d",
    "description": "For any country/region, the '+' key",
    "logicalKeyId": LogicalKeyboardKey.equal.keyId,
  },
  {
    "key": "VK_OEM_COMMA",
    "windowsValue": 0xBC,
    "macOSValue": 0x2B,
    "linuxValue": "0x002c",
    "description": "For any country/region, the ',' key",
    "logicalKeyId": LogicalKeyboardKey.comma.keyId,
  },
  {
    "key": "VK_OEM_MINUS",
    "windowsValue": 0xBD,
    "macOSValue": 0x1B,
    "linuxValue": "0x002d",
    "description": "For any country/region, the '-' key",
    "logicalKeyId": LogicalKeyboardKey.minus.keyId,
  },
  {
    "key": "VK_OEM_PERIOD",
    "windowsValue": 0xBE,
    "macOSValue": 0x2F,
    "linuxValue": "0x002e",
    "description": "For any country/region, the '.' key",
    "logicalKeyId": LogicalKeyboardKey.period.keyId,
  },
  {
    "key": "VK_OEM_2",
    "windowsValue": 0xBF,
    "macOSValue": 0x2C,
    "linuxValue": "0x002f",
    "description":
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '/?' key",
    "logicalKeyId": LogicalKeyboardKey.slash.keyId,
  },
  {
    "key": "VK_OEM_3",
    "windowsValue": 0xC0,
    "macOSValue": 0x32,
    "linuxValue": "0x0060",
    "description":
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '`~' key",
    "logicalKeyId": LogicalKeyboardKey.backquote.keyId,
  },
  {
    "key": "VK_OEM_4",
    "windowsValue": 0xDB,
    "macOSValue": 0x21,
    "linuxValue": "0x005b",
    "description":
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '[{' key",
    "logicalKeyId": LogicalKeyboardKey.bracketLeft.keyId,
  },
  {
    "key": "VK_OEM_5",
    "windowsValue": 0xDC,
    "macOSValue": 0x2A,
    "linuxValue": "0x005c",
    "description":
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '\\|' key",
    "logicalKeyId": LogicalKeyboardKey.backslash.keyId,
  },
  {
    "key": "VK_OEM_6",
    "windowsValue": 0xDD,
    "macOSValue": 0x1E,
    "linuxValue": "0x005d",
    "description":
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ']}' key",
    "logicalKeyId": LogicalKeyboardKey.bracketRight.keyId,
  },
  {
    "key": "VK_OEM_7",
    "windowsValue": 0xDE,
    "macOSValue": 0x27,
    "linuxValue": "0x0060",
    "description":
        "Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the 'single-quote/double-quote' key",
    "logicalKeyId": LogicalKeyboardKey.quote.keyId,
  },
  {
    "key": "VK_OEM_8",
    "windowsValue": 0xDF,
    "macOSValue": null,
    "linuxValue": null,
    "description":
        "Used for miscellaneous characters; it can vary by keyboard.",
    "logicalKeyId": null,
  },
  {
    "key": "VK_OEM_102",
    "windowsValue": 0xE2,
    "macOSValue": 0x2B,
    "linuxValue": "0x005c",
    "description":
        "Either the angle bracket key or the backslash key on the RT 102-key keyboard",
    "logicalKeyId": LogicalKeyboardKey.backslash.keyId,
  },
  {
    "key": "VK_PROCESSKEY",
    "windowsValue": 0xE5,
    "macOSValue": null,
    "linuxValue": null,
    "description": "IME PROCESS key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_PACKET",
    "windowsValue": 0xE7,
    "macOSValue": null,
    "linuxValue": null,
    "description":
        "Used to pass Unicode characters as if they were keystrokes. The VK_PACKET key is the low word of a 32-bit Virtual Key windowsValue used for non-keyboard input methods.",
    "logicalKeyId": null,
  },
  {
    "key": "VK_ATTN",
    "windowsValue": 0xF6,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Attn key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_CRSEL",
    "windowsValue": 0xF7,
    "macOSValue": null,
    "linuxValue": null,
    "description": "CrSel key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_EXSEL",
    "windowsValue": 0xF8,
    "macOSValue": null,
    "linuxValue": null,
    "description": "ExSel key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_EREOF",
    "windowsValue": 0xF9,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Erase EOF key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_PLAY",
    "windowsValue": 0xFA,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Play key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_ZOOM",
    "windowsValue": 0xFB,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Zoom key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_NONAME",
    "windowsValue": 0xFC,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Reserved",
    "logicalKeyId": null,
  },
  {
    "key": "VK_PA1",
    "windowsValue": 0xFD,
    "macOSValue": null,
    "linuxValue": null,
    "description": "PA1 key",
    "logicalKeyId": null,
  },
  {
    "key": "VK_OEM_CLEAR",
    "windowsValue": 0xFE,
    "macOSValue": null,
    "linuxValue": null,
    "description": "Clear key",
    "logicalKeyId": null,
  }
];
