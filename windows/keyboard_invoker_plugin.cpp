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
        const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());

        flutter::EncodableValue keyCodeValue = (arguments->find(flutter::EncodableValue("keyCode")))->second;
        if (std::holds_alternative<int32_t>(keyCodeValue))
        {
          int32_t keyCode = std::get<int32_t>(keyCodeValue);

          INPUT ip{};
          ip.type = INPUT_KEYBOARD;
          ip.ki.wScan = 0;
          ip.ki.time = 0;
          ip.ki.dwExtraInfo = 0;

          ip.ki.wVk = static_cast<WORD>(keyCode);
          ip.ki.dwFlags = 0;
          SendInput(1, &ip, sizeof(INPUT));

          ip.ki.dwFlags = KEYEVENTF_KEYUP;
          SendInput(1, &ip, sizeof(INPUT));

          result->Success(flutter::EncodableValue(true));
        }
        else
        {
          result->Error("Invalid keyCode type");
          return;
        }
      }
    }
    else if (method_call.method_name().compare("holdKey") == 0)
    {
      if (method_call.arguments()->IsNull())
      {
        result->Error("Missing arguments");
        return;
      }
      else
      {
        const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());

        flutter::EncodableValue keyCodeValue = (arguments->find(flutter::EncodableValue("keyCode")))->second;
        if (std::holds_alternative<int32_t>(keyCodeValue))
        {
          int32_t keyCode = std::get<int32_t>(keyCodeValue);

          INPUT ip{};
          ip.type = INPUT_KEYBOARD;
          ip.ki.wScan = 0;
          ip.ki.time = 0;
          ip.ki.dwExtraInfo = 0;

          ip.ki.wVk = static_cast<WORD>(keyCode);
          ip.ki.dwFlags = 0;
          SendInput(1, &ip, sizeof(INPUT));

          result->Success(flutter::EncodableValue(true));
        }
        else
        {
          result->Error("Invalid keyCode type");
          return;
        }
      }
    }
    else if (method_call.method_name().compare("releaseKey") == 0)
    {
      if (method_call.arguments()->IsNull())
      {
        result->Error("Missing arguments");
        return;
      }
      else
      {
        const auto *arguments = std::get_if<flutter::EncodableMap>(method_call.arguments());

        flutter::EncodableValue keyCodeValue = (arguments->find(flutter::EncodableValue("keyCode")))->second;
        if (std::holds_alternative<int32_t>(keyCodeValue))
        {
          int32_t keyCode = std::get<int32_t>(keyCodeValue);

          INPUT ip{};
          ip.type = INPUT_KEYBOARD;
          ip.ki.wScan = 0;
          ip.ki.time = 0;
          ip.ki.dwExtraInfo = 0;
          ip.ki.wVk = static_cast<WORD>(keyCode);

          ip.ki.dwFlags = KEYEVENTF_KEYUP;
          SendInput(1, &ip, sizeof(INPUT));

          result->Success(flutter::EncodableValue(true));
        }
        else
        {
          result->Error("Invalid keyCode type");
          return;
        }
      }
    }
    else
    {
      result->NotImplemented();
    }
  }
} // namespace keyboard_invoker