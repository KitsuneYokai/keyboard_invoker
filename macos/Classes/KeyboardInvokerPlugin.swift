import Cocoa
import FlutterMacOS

import Foundation
import AppKit

// variables to store the key codes for the modifier keys
let kVK_Shift: Int = 8589935090
let kVK_Control: Int = 8589935088
let kVK_Option: Int = 8589935092
let kVK_Command: Int = 8589935094

let kVK_LeftShift: Int = 8589934850
let kVK_LeftControl: Int = 8589934848
let kVK_LeftOption: Int =  8589934852
let kVK_LeftCommand: Int = 8589934854

let kVK_RightShift: Int = 8589934851
let kVK_RightControl: Int = 8589934849
let kVK_RightOption: Int = 8589934853
let kVK_RightCommand: Int = 8589934855

var heldKeys: [Int] = []


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
        if let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility") {
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

    // default case to get the platform version
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)

    // case to invoke a key press 
    case "invokeKey":
      print("heldKey: \(heldKeys)") // Print the value of heldKey

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
      guard let keyCode = args["keyCode"] as? Int else {
        result(false)
        return
      }

        let key: CGKeyCode = CGKeyCode(UInt32(keyCode))
        var modifierFlags: CGEventFlags = CGEventFlags()

        for heldKey: Int in heldKeys {
          if (heldKey == kVK_LeftShift || heldKey == kVK_RightShift || heldKey == kVK_Shift) {
            modifierFlags.insert(CGEventFlags.maskShift)
          } else if (heldKey == kVK_LeftControl || heldKey == kVK_RightControl || heldKey == kVK_Control) {
            modifierFlags.insert(CGEventFlags.maskControl)
          } else if (heldKey == kVK_LeftOption || heldKey == kVK_RightOption || heldKey == kVK_Option) {
            modifierFlags.insert(CGEventFlags.maskAlternate)
          } else if (heldKey == kVK_LeftCommand || heldKey == kVK_RightCommand || heldKey == kVK_Command) {
            modifierFlags.insert(CGEventFlags.maskCommand)
          }
        }
        let eventKeyPress: CGEvent? = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true);
        eventKeyPress!.flags = modifierFlags
        eventKeyPress!.post(tap: CGEventTapLocation.cghidEventTap)
        result(true)

    // case to hold a key(shift, ctrl, alt, etc.)
    case "holdKey":
      // get the arguments
      guard let args = call.arguments as? [String: Any] else {
        result(false)
        return
      }
      // get the key code
      guard let keyCode = args["keyCode"] as? Int else {
        result(false)
        return
      }
      // append the key code to the list of held keys
      heldKeys.append(keyCode)
      result(true)

    // case to release a key(shift, ctrl, alt, etc.)
    case "releaseKey":
      // get the arguments
      guard let args = call.arguments as? [String: Any] else {
        result(false)
        return
      }

      // get the key code
      guard let keyCode = args["keyCode"] as? Int else {
        result(false)
        return
      }

      // remove the key code from the list of held keys
      for key: Int in heldKeys {
        if (key == keyCode) {
          heldKeys.remove(at: heldKeys.firstIndex(of: key)!)
        }
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
