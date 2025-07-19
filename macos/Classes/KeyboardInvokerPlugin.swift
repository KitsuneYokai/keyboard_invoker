import Cocoa
import FlutterMacOS

import Foundation
import AppKit


/**
* This function checks if the application has accessibility permissions.
*/
func hasAccessibilityPermissions() -> Bool {
    let trustedCheckOptionPrompt: NSString = kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString
    let options: [NSString : Bool] = [trustedCheckOptionPrompt: true]
    return AXIsProcessTrustedWithOptions(options as CFDictionary)
}

/**
* This function requests accessibility permissions for the application.
*/
func requestAccessibilityPermissions() {
    let options: [NSString : Bool] = [kAXTrustedCheckOptionPrompt.takeUnretainedValue() as NSString: true]
    AXIsProcessTrustedWithOptions(options as CFDictionary)
}

/**
* This function shows a dialog to the user requesting accessibility permissions.
* It informs the user that they need to grant permissions for the application to function correctly.
* If the user agrees, it opens the System Preferences to the Accessibility section.
*/
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

/**
* This class implements the Flutter plugin for keyboard invoker functionality.
* It handles method calls from Flutter and performs the necessary actions such as invoking keys,
* holding keys, releasing keys, checking num lock state, and validating accessibility permissions.
*/
public class KeyboardInvokerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "keyboard_invoker", binaryMessenger: registrar.messenger)
    let instance: KeyboardInvokerPlugin = KeyboardInvokerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case "validatePermissions":
        if hasAccessibilityPermissions() {
          result(true)
        } else {
          showAccessibilityPermissionDialog()
          result(false)
        }
        return

      case "checkNumLockState":
        // get the current num lock state
        let modifierFlags = NSEvent.modifierFlags.rawValue
        let numLockState = (modifierFlags & NSEvent.ModifierFlags.numericPad.rawValue) != 0
        result(numLockState)
  
      case "invokeKey", "holdKey", "releaseKey":
        // Get the arguments from Flutter
        guard let args = call.arguments as? [String: Any],
              let keyCode = args["keyCode"] as? Int else {
          result(FlutterError(code: "INVALID_ARGUMENT",
                             message: "Expected keyCode",
                             details: nil))
          return
        }

        // Handle the different key events
        switch call.method {
          case "invokeKey":
            let keyDown = CGEvent(keyboardEventSource: nil, virtualKey: CGKeyCode(keyCode), keyDown: true)
            let keyUp = CGEvent(keyboardEventSource: nil, virtualKey: CGKeyCode(keyCode), keyDown: false)
            keyDown?.post(tap: .cghidEventTap)
            keyUp?.post(tap: .cghidEventTap)
            result(true)

          case "holdKey":
            let keyEvent = CGEvent(keyboardEventSource: nil, virtualKey: CGKeyCode(keyCode), keyDown: true)
            keyEvent?.post(tap: .cghidEventTap)
            result(true)

          case "releaseKey":
            let keyEvent = CGEvent(keyboardEventSource: nil, virtualKey: CGKeyCode(keyCode), keyDown: false)
            keyEvent?.post(tap: .cghidEventTap)
            result(true)

          default:
            result(FlutterMethodNotImplemented)
        }

      default:
        result(FlutterMethodNotImplemented)
    }
  }
}