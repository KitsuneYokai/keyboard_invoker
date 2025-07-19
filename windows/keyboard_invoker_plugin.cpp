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

  /**
   * This function handles a key release operation.
   *
   * @param keyCode The virtual key code of the key to release.
   * @param isNumpadKey A boolean indicating if the key is a numpad key
   */
  void release_key(int32_t keyCode, bool isNumpadKey)
  {
    INPUT input = {};
    input.type = INPUT_KEYBOARD;
    input.ki.wVk = static_cast<WORD>(keyCode);
    input.ki.dwFlags = (isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0) | KEYEVENTF_KEYUP;

    SendInput(1, &input, sizeof(INPUT));
  }

  /**
   * This function handles a key hold operation.
   *
   * @param keyCode The virtual key code of the key to hold.
   * @param isNumpadKey A boolean indicating if the key is a numpad
   */
  void hold_key(int32_t keyCode, bool isNumpadKey)
  {
    // Only press key
    INPUT input = {};
    input.type = INPUT_KEYBOARD;
    input.ki.wVk = static_cast<WORD>(keyCode);
    input.ki.dwFlags = isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0;

    SendInput(1, &input, sizeof(INPUT));
  }

  /**
   * This function handles a key invocation operation.
   * It simulates a key press and release for the specified key code.
   *
   * @param keyCode The virtual key code of the key to invoke.
   * @param isNumpadKey A boolean indicating if the key is a numpad
   */
  void invoke_key(int32_t keyCode, bool isNumpadKey)
  {
    INPUT inputs[2] = {};

    inputs[0].type = INPUT_KEYBOARD;
    inputs[0].ki.wVk = static_cast<WORD>(keyCode);
    inputs[0].ki.dwFlags = isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0;

    inputs[1].type = INPUT_KEYBOARD;
    inputs[1].ki.wVk = static_cast<WORD>(keyCode);
    inputs[1].ki.dwFlags = (isNumpadKey ? KEYEVENTF_EXTENDEDKEY : 0) | KEYEVENTF_KEYUP;

    SendInput(2, inputs, sizeof(INPUT));
  }

  /**
   * This function checks the state of the Num Lock key.
   * It returns true if Num Lock is enabled, false otherwise.
   *
   * @return true if Num Lock is enabled, false otherwise.
   */
  bool check_num_lock_state()
  {
    return (GetKeyState(VK_NUMLOCK) & 0x0001) != 0;
  }

  /**
   * Handles method calls from the Flutter side.
   */
  void KeyboardInvokerPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {

    /// handle the `validatePermissions` method
    if (method_call.method_name().compare("validatePermissions") == 0)
    {
      // Windows doesn't require special permissions for keyboard simulation (yet) so we can just return true
      result->Success(flutter::EncodableValue(true));
      return;
    }

    /// handle the `checkNumLockState` method
    if (method_call.method_name().compare("checkNumLockState") == 0)
    {
      bool isNumLockEnabled = check_num_lock_state();
      result->Success(flutter::EncodableValue(isNumLockEnabled));
      return;
    }

    /// check if the method is one of the key operations
    if (method_call.arguments()->IsNull())
    {
      // if we don't have any arguments, its an invalid call
      result->Error("INVALID_ARGUMENT", "Arguments cannot be null");
      return;
    }

    /// get the arguments passed to the method call
    const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());
    if (!arguments)
    {
      result->Error("INVALID_ARGUMENT", "Expected map arguments");
      return;
    }

    // get the keycode and throw an error, if its not provided
    auto keyCodeIter = arguments->find(flutter::EncodableValue("keyCode"));
    if (keyCodeIter == arguments->end())
    {
      result->Error("INVALID_ARGUMENT", "Expected keyCode");
      return;
    }

    int32_t keyCode = std::get<int32_t>(keyCodeIter->second);
    bool isNumpadKey = (keyCode >= 0x60 && keyCode <= 0x69);

    // handle numpad keys
    if (isNumpadKey)
    {
      INPUT input = {};
      input.type = INPUT_KEYBOARD;
      input.ki.wVk = 0;

      // convert the wk value to the scan value and set the dwFlag
      switch (keyCode)
      {
      case 0x60:
        input.ki.wScan = 0x52;
        break; /// 0

      case 0x61:
        input.ki.wScan = 0x4F;
        break; /// 1

      case 0x62:
        input.ki.wScan = 0x50;
        break; /// 2

      case 0x63:
        input.ki.wScan = 0x51;
        break; /// 3

      case 0x64:
        input.ki.wScan = 0x4B;
        break; /// 4

      case 0x65:
        input.ki.wScan = 0x4C;
        break; /// 5

      case 0x66:
        input.ki.wScan = 0x4D;
        break; /// 6

      case 0x67:
        input.ki.wScan = 0x47;
        break; /// 7

      case 0x68:
        input.ki.wScan = 0x48;
        break; /// 8

      case 0x69:
        input.ki.wScan = 0x49;
        break; /// 9
      }
      input.ki.dwFlags = KEYEVENTF_SCANCODE;

      /// handle the method call fot he ` invokeKey`, `holdKey` and `releaseKey`,
      /// when the keyCode is a numpad key
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

    /// handle non numpad keys `invokeKey`, `holdKey` and `releaseKey`
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