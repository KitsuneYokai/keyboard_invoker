import Cocoa
import FlutterMacOS

import Foundation
import AppKit


// A function to check if the app has accessibility permissions
func hasAccessibilityPermissions() -> Bool {
    let trustedCheckOptionPrompt: NSString = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString
    let options: [NSString : Bool] = [trustedCheckOptionPrompt: true]
    return AXIsProcessTrustedWithOptions(options as CFDictionary)
}

// A function to request accessibility permissions
func requestAccessibilityPermissions() {
    let options: [NSString : Bool] = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString: true]
    AXIsProcessTrustedWithOptions(options as CFDictionary)
}

// A function to show the accessibility permissions dialog
func showAccessibilityPermissionDialog() {
    let alert: NSAlert = NSAlert()
    alert.messageText = "Accessibility Permissions Required"
    alert.informativeText = "Please grant accessibility permissions to enable the desired functionality. Go to System Preferences > Security & Privacy > Privacy > Accessibility and enable your app."
    alert.addButton(withTitle: "Open System Preferences")
    alert.addButton(withTitle: "Cancel")
    let response: NSApplication.ModalResponse = alert.runModal()

    if response == .alertFirstButtonReturn {
        if let url: URL = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
            NSWorkspace.shared.open(url)
        }
    }
}

public class KeyboardInvokerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "keyboard_invoker", binaryMessenger: registrar.messenger)
    let instance: KeyboardInvokerPlugin = KeyboardInvokerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {

  switch call.method {
    // default case to get the platform version, will be deleted later
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)

    // case to invoke a key press 
    case "invokeKey":
      // Check accessibility permissions
      guard hasAccessibilityPermissions() else {
        // show the accessibility permissions dialog
        showAccessibilityPermissionDialog()
        // return false to indicate that the key was not pressed
        result(false)
        return
      }
      // get the arguments
      guard let args = call.arguments as? [String: Any] else {
        result(false)
        return
      }
      // get the key code
      guard let keyCode = args["platformKeyCode"] as? Int else {
        result(false)
        return
      }

      let key: CGKeyCode = CGKeyCode(UInt32(keyCode))
      var modifierFlags: CGEventFlags = CGEventFlags()

      // get the modifier keys
      let leftShiftPressed = args["leftShiftPressed"] as? Bool
      let rightShiftPressed = args["rightShiftPressed"] as? Bool
      
      let leftAltPressed = args["leftAltPressed"] as? Bool
      let rightAltPressed = args["rightAltPressed"] as? Bool

      let leftControlPressed = args["leftControlPressed"] as? Bool
      let rightControlPressed = args["rightControlPressed"] as? Bool

      let leftMetaPressed = args["leftMetaPressed"] as? Bool
      let rightMetaPressed = args["rightMetaPressed"] as? Bool

      // set the modifier flags
      if (leftShiftPressed ?? false || rightShiftPressed ?? false) {
        modifierFlags.insert(CGEventFlags.maskShift)
      }
      if (leftAltPressed ?? false || rightAltPressed ?? false) {
        modifierFlags.insert(CGEventFlags.maskAlternate)
      }
      if (leftControlPressed ?? false || rightControlPressed ?? false) {
        modifierFlags.insert(CGEventFlags.maskControl)
      }
      if (leftMetaPressed ?? false || rightMetaPressed ?? false) {
        modifierFlags.insert(CGEventFlags.maskCommand)
      }

      // key press event
      let eventKeyPress: CGEvent? = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true);
      eventKeyPress!.flags = modifierFlags
      eventKeyPress!.post(tap: CGEventTapLocation.cghidEventTap)

      // key release event
      let eventKeyRelease: CGEvent? = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: false);
      eventKeyRelease!.flags = modifierFlags
      eventKeyRelease!.post(tap: CGEventTapLocation.cghidEventTap)

      result(true)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}