#include "keyboard_invoker_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>

namespace keyboard_invoker
{

  // static
  void KeyboardInvokerPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "keyboard_invoker",
            &flutter::StandardMethodCodec::GetInstance());

    auto plugin = std::make_unique<KeyboardInvokerPlugin>();

    channel->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  KeyboardInvokerPlugin::KeyboardInvokerPlugin() {}

  KeyboardInvokerPlugin::~KeyboardInvokerPlugin() {}

  // default getPlatformVersion method
  void KeyboardInvokerPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("getPlatformVersion") == 0)
    {
      std::ostringstream version_stream;
      version_stream << "Windows ";
      if (IsWindows10OrGreater())
      {
        version_stream << "10+";
      }
      else if (IsWindows8OrGreater())
      {
        version_stream << "8";
      }
      else if (IsWindows7OrGreater())
      {
        version_stream << "7";
      }
      result->Success(flutter::EncodableValue(version_stream.str()));
    }
    // handle the invokeKey method
    else if (method_call.method_name().compare("invokeKey") == 0)
    {
      if (method_call.arguments()->IsNull())
      {
        result->Error("Missing arguments");
        return;
      }
      else
      {
      // this is messy, but it works for now
      const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
      // Check if the arguments are valid
      flutter::EncodableValue keyCodeValue = arguments->find(flutter::EncodableValue("platformKeyCode"))->second;
      int32_t keyCode = std::get<int32_t>(keyCodeValue);

      flutter::EncodableValue leftShift = arguments->find(flutter::EncodableValue("leftShiftPressed"))->second;
      bool shiftLeftPressed = std::get<bool>(leftShift);

      flutter::EncodableValue rightShift = arguments->find(flutter::EncodableValue("rightShiftPressed"))->second;
      bool shiftRightPressed = std::get<bool>(rightShift);

      flutter::EncodableValue leftAlt = arguments->find(flutter::EncodableValue("leftAltPressed"))->second;
      bool altLeftPressed = std::get<bool>(leftAlt);

      flutter::EncodableValue rightAlt = arguments->find(flutter::EncodableValue("rightAltPressed"))->second;
      bool altRightPressed = std::get<bool>(rightAlt);

      flutter::EncodableValue leftCtrl = arguments->find(flutter::EncodableValue("leftControlPressed"))->second;
      bool controlLeftPressed = std::get<bool>(leftCtrl);

      flutter::EncodableValue rightCtrl = arguments->find(flutter::EncodableValue("rightControlPressed"))->second;
      bool controlRightPressed = std::get<bool>(rightCtrl);

      flutter::EncodableValue leftMeta = arguments->find(flutter::EncodableValue("leftMetaPressed"))->second;
      bool metaLeftPressed = std::get<bool>(leftMeta);

      flutter::EncodableValue rightMeta = arguments->find(flutter::EncodableValue("rightMetaPressed"))->second;
      bool metaRightPressed = std::get<bool>(rightMeta);

      // Simulate holding down the modifier keys
      if (shiftLeftPressed || shiftRightPressed) {
          INPUT shiftInput;
          shiftInput.type = INPUT_KEYBOARD;
          shiftInput.ki.wVk = VK_SHIFT;
          shiftInput.ki.dwFlags = 0;
          SendInput(1, &shiftInput, sizeof(INPUT));
      }

      if (altLeftPressed || altRightPressed) {
          INPUT altInput;
          altInput.type = INPUT_KEYBOARD;
          altInput.ki.wVk = VK_MENU;
          altInput.ki.dwFlags = 0;
          SendInput(1, &altInput, sizeof(INPUT));
      }

      if (controlLeftPressed || controlRightPressed) {
          INPUT ctrlInput;
          ctrlInput.type = INPUT_KEYBOARD;
          ctrlInput.ki.wVk = VK_CONTROL;
          ctrlInput.ki.dwFlags = 0;
          SendInput(1, &ctrlInput, sizeof(INPUT));
      }

      if (metaLeftPressed || metaRightPressed) {
          INPUT metaInput;
          metaInput.type = INPUT_KEYBOARD;
          metaInput.ki.wVk = VK_LWIN; // Left Windows key
          metaInput.ki.dwFlags = 0;
          SendInput(1, &metaInput, sizeof(INPUT));
      }
        // Simulate key press with modifiers
      INPUT keyInput;
      keyInput.type = INPUT_KEYBOARD;
      keyInput.ki.wVk = static_cast<WORD>(keyCode);
      keyInput.ki.dwFlags = 0;
      SendInput(1, &keyInput, sizeof(INPUT));

      // Release the modifier keys
      if (shiftLeftPressed || shiftRightPressed) {
          INPUT shiftInput;
          shiftInput.type = INPUT_KEYBOARD;
          shiftInput.ki.wVk = VK_SHIFT;
          shiftInput.ki.dwFlags = KEYEVENTF_KEYUP;
          SendInput(1, &shiftInput, sizeof(INPUT));
      }

      if (altLeftPressed || altRightPressed) {
          INPUT altInput;
          altInput.type = INPUT_KEYBOARD;
          altInput.ki.wVk = VK_MENU;
          altInput.ki.dwFlags = KEYEVENTF_KEYUP;
          SendInput(1, &altInput, sizeof(INPUT));
      }

      if (controlLeftPressed || controlRightPressed) {
          INPUT ctrlInput;
          ctrlInput.type = INPUT_KEYBOARD;
          ctrlInput.ki.wVk = VK_CONTROL;
          ctrlInput.ki.dwFlags = KEYEVENTF_KEYUP;
          SendInput(1, &ctrlInput, sizeof(INPUT));
      }

      if (metaLeftPressed || metaRightPressed) {
          INPUT metaInput;
          metaInput.type = INPUT_KEYBOARD;
          metaInput.ki.wVk = VK_LWIN; // Left Windows key
          metaInput.ki.dwFlags = KEYEVENTF_KEYUP;
          SendInput(1, &metaInput, sizeof(INPUT));
      }
        // return success
        result->Success(flutter::EncodableValue(true));
      }

    }
    else
    {
      result->NotImplemented();
    }
  }
} // namespace keyboard_invoker