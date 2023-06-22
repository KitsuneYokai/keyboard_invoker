#include "include/keyboard_invoker/keyboard_invoker_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "keyboard_invoker_plugin.h"

void KeyboardInvokerPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar)
{
    keyboard_invoker::KeyboardInvokerPlugin::RegisterWithRegistrar(
        flutter::PluginRegistrarManager::GetInstance()
            ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
