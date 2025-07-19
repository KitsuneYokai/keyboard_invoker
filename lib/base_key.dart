import 'package:flutter/services.dart';

/// This class represents a keyboard key with platform-specific identifiers.
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
  final LogicalKeyboardKey? logicalKeyId;
  final String? description;
  final String? linux;
  final int? windows;
  final int? mac;

  // Constructor
  const BaseKey(
      this.logicalKeyId, this.description, this.linux, this.windows, this.mac);
}
