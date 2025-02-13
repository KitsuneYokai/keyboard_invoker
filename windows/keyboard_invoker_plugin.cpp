#include "keyboard_invoker_plugin.h"

// This must be included before many other Windows headers, 
// otherwise the execution of the fuinction fails
#include <windows.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <memory>
#include <sstream>
#include <iostream>

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

  // This function handles a key release
  void release_key(int32_t keyCode, bool isNumpadKey) {
    INPUT input = {};
    input.type = INPUT_KEYBOARD;
    input.ki.wVk = static_cast<WORD>(keyCode);
    input.ki.dwFlags = (isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0) | KEYEVENTF_KEYUP;
    
    SendInput(1, &input, sizeof(INPUT));
  }

  // This function handles a key hold operation, on non num keys
  void hold_key(int32_t keyCode, bool isNumpadKey) {
    // Only press key
    INPUT input = {};
    input.type = INPUT_KEYBOARD;
    input.ki.wVk = static_cast<WORD>(keyCode);
    input.ki.dwFlags = isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0;
    
    SendInput(1, &input, sizeof(INPUT));
  }

  // This function handles a key invokion (keypress) opperation, on non num keys
  void invoke_key(int32_t keyCode, bool isNumpadKey) {
    INPUT inputs[2] = {};

    inputs[0].type = INPUT_KEYBOARD;
    inputs[0].ki.wVk = static_cast<WORD>(keyCode);
    inputs[0].ki.dwFlags = isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0;

    inputs[1].type = INPUT_KEYBOARD;
    inputs[1].ki.wVk = static_cast<WORD>(keyCode);
    inputs[1].ki.dwFlags = (isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0) | KEYEVENTF_KEYUP;

    SendInput(2, inputs, sizeof(INPUT));
  }

  void KeyboardInvokerPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    if (method_call.method_name().compare("validatePermissions") == 0)
    {
      // Windows doesn't require special permissions for keyboard simulation so we can just return true
      result->Success(flutter::EncodableValue(true));
      return;
    }

    // check if the arguments are present
    if (method_call.arguments()->IsNull())
    {
      // If we got no arguments, we gonna throw an error
      result->Error("INVALID_ARGUMENT", "Arguments cannot be null");
      return;
    }

    // get the arguments, and type check them
    const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    if (!arguments)
    {
      result->Error("INVALID_ARGUMENT", "Expected map arguments");
      return;
    }
    // get the keycore and throw an error, if its not provided
    auto keyCodeIter = arguments->find(flutter::EncodableValue("keyCode"));
    if (keyCodeIter == arguments->end())
    {
      result->Error("INVALID_ARGUMENT", "Expected keyCode");
      return;
    }

    // typecast the keycode
    int32_t keyCode = std::get<int32_t>(keyCodeIter->second);

    // bool check to identify, if the user is invoking a numpad key
    bool isNumpadKey = (keyCode >= 0x60 && keyCode <= 0x69);

    // handle numpad keys
    if (isNumpadKey)
    {
        INPUT input = {};
        input.type = INPUT_KEYBOARD;
        input.ki.wVk = 0;
        
        // convert the wk value to the scan value and set the dwFlag
        switch (keyCode) {
            case 0x60: input.ki.wScan = 0x52; break; // 0
            case 0x61: input.ki.wScan = 0x4F; break; // 1
            case 0x62: input.ki.wScan = 0x50; break; // 2
            case 0x63: input.ki.wScan = 0x51; break; // 3
            case 0x64: input.ki.wScan = 0x4B; break; // 4
            case 0x65: input.ki.wScan = 0x4C; break; // 5
            case 0x66: input.ki.wScan = 0x4D; break; // 6
            case 0x67: input.ki.wScan = 0x47; break; // 7
            case 0x68: input.ki.wScan = 0x48; break; // 8
            case 0x69: input.ki.wScan = 0x49; break; // 9
        }
        input.ki.dwFlags = KEYEVENTF_SCANCODE;

        if (method_call.method_name().compare("invokeKey") == 0)
        {
            SendInput(1, &input, sizeof(INPUT));
            input.ki.dwFlags |= KEYEVENTF_KEYUP;

        }
        else if (method_call.method_name().compare("releaseKey") == 0)
        {
          input.ki.dwFlags |= KEYEVENTF_KEYUP;
          SendInput(1, &input, sizeof(INPUT));
        }

        SendInput(1, &input, sizeof(INPUT));
        result->Success(flutter::EncodableValue(true));
        return;
    }

    // Handle non-numpad keys
    if (method_call.method_name().compare("invokeKey") == 0)
    {
      invoke_key(keyCode, isNumpadKey);
    }
    else if (method_call.method_name().compare("holdKey") == 0)
    {
      hold_key(keyCode, isNumpadKey);
    }
    else if (method_call.method_name().compare("releaseKey") == 0)
    {
      release_key(keyCode, isNumpadKey);
    }
    else
    {
      result->NotImplemented();
    }
    result->Success(flutter::EncodableValue(true));
  }
} // namespace keyboard_invoker