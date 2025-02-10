import 'package:flutter/services.dart';

/// This class represents a keyboard key with platform-specific identifiers.
///
/// This class stores various identifiers for a keyboard key across different platforms
/// (Linux, Windows, and MacOS) along with darts logical key identifier and description.
///
/// Properties:
/// * [logicalKeyId] - The logical key identifier from Darts's keyboard API
/// * [description] - A human-readable description of the key
/// * [linux] - The Linux-specific key identifier (can be null)
/// * [windows] - The Windows-specific key identifier (can be null)
/// * [mac] - The MacOS-specific key identifier (can be null)
///
/// Example:
/// ```dart
/// var spaceKey = BaseKey(
///   LogicalKeyboardKey.space, // The value of darts Key
///   "Space",                  // Defines the description for the key
///   "space",                  // The Linux value
///   32,                       // The Windows value
///   49                        // The MacOs Value
/// );
/// ```
class BaseKey {
  // var declaration
  LogicalKeyboardKey? _logicalKeyId;
  String? _description;
  String? _linux;
  int? _windows;
  int? _mac;

  // class constructor
  BaseKey(LogicalKeyboardKey? logicalKeyId, String? description, String? linux,
      int? windows, int? mac) {
    _logicalKeyId = logicalKeyId;
    _description = description;
    _linux = linux;
    _windows = windows;
    _mac = mac;
  }

  // getters
  LogicalKeyboardKey? get logicalKeyId => _logicalKeyId;
  String? get description => _description;
  String? get linux => _linux;
  int? get windows => _windows;
  int? get mac => _mac;
}
