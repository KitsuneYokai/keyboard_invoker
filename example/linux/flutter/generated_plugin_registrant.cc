//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <keyboard_invoker/keyboard_invoker_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) keyboard_invoker_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "KeyboardInvokerPlugin");
  keyboard_invoker_plugin_register_with_registrar(keyboard_invoker_registrar);
}
