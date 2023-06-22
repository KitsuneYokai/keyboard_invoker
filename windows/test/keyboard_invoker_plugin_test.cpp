#include <flutter/method_call.h>
#include <flutter/method_result_functions.h>
#include <flutter/standard_method_codec.h>
#include <gtest/gtest.h>
#include <windows.h>

#include <memory>
#include <string>
#include <variant>

#include "keyboard_invoker_plugin.h"

namespace keyboard_invoker
{
  namespace test
  {

    namespace
    {

      using flutter::EncodableMap;
      using flutter::EncodableValue;
      using flutter::MethodCall;
      using flutter::MethodResultFunctions;

    } // namespace

    TEST(KeyboardInvokerPlugin, GetPlatformVersion)
    {
      KeyboardInvokerPlugin plugin;
      // Save the reply value from the success callback.
      std::string result_string;
      plugin.HandleMethodCall(
          MethodCall("getPlatformVersion", std::make_unique<EncodableValue>()),
          std::make_unique<MethodResultFunctions<>>(
              [&result_string](const EncodableValue *result)
              {
                result_string = std::get<std::string>(*result);
              },
              nullptr, nullptr));

      // Since the exact string varies by host, just ensure that it's a string
      // with the expected format.
      EXPECT_TRUE(result_string.rfind("Windows ", 0) == 0);
    }
    TEST(KeyboardInvokerPlugin, InvokeKey)
    {
      KeyboardInvokerPlugin plugin;
      // Save the reply value from the success callback.
      std::string result_string;
      plugin.HandleMethodCall(
          MethodCall("invokeKey", std::make_unique<EncodableValue>()),
          std::make_unique<MethodResultFunctions<>>(
              [&result_string](const EncodableValue *result)
              {
                result_string = std::get<std::string>(*result);
              },
              nullptr, nullptr));

      // Since the exact string varies by host, just ensure that it's a string
      // with the expected format.
      EXPECT_TRUE(result_string.rfind("Windows ", 0) == 0);
    }
  } // namespace test
} // namespace keyboard_invoker
