#ifndef FLUTTER_PLUGIN_KEYBOARD_INVOKER_PLUGIN_H_
#define FLUTTER_PLUGIN_KEYBOARD_INVOKER_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace keyboard_invoker
{

    class KeyboardInvokerPlugin : public flutter::Plugin
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        KeyboardInvokerPlugin();

        virtual ~KeyboardInvokerPlugin();

        // Disallow copy and assign.
        KeyboardInvokerPlugin(const KeyboardInvokerPlugin &) = delete;
        KeyboardInvokerPlugin &operator=(const KeyboardInvokerPlugin &) = delete;

        // Called when a method is called on this plugin's channel from Dart.
        void HandleMethodCall(
            const flutter::MethodCall<flutter::EncodableValue> &method_call,
            std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
    };

} // namespace keyboard_invoker

#endif // FLUTTER_PLUGIN_KEYBOARD_INVOKER_PLUGIN_H_