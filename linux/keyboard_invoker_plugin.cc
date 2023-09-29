#include "include/keyboard_invoker/keyboard_invoker_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <string>

#include "keyboard_invoker_plugin_private.h"

#define KEYBOARD_INVOKER_PLUGIN(obj)                                     \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), keyboard_invoker_plugin_get_type(), \
                              KeyboardInvokerPlugin))

static void hold_keys(const char *modifiers) {
    std::string command = "xdotool keydown " + std::string(modifiers);
    system(command.c_str());
}

static void release_modifiers()
{
    std::string command = "xdotool keyup Shift_L Shift_R Alt_L Alt_R Control_L Control_R Meta_L Meta_R";
    system(command.c_str());
}

struct _KeyboardInvokerPlugin
{
  GObject parent_instance;
};

G_DEFINE_TYPE(KeyboardInvokerPlugin, keyboard_invoker_plugin, g_object_get_type())

static void keyboard_invoker_plugin_handle_method_call(
    KeyboardInvokerPlugin *self,
    FlMethodCall *method_call)
{
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar *method = fl_method_call_get_name(method_call);

  if (strcmp(method, "invokeKey") == 0)
  {
    // TODO: check if the active display server is X11 or wayland + check if xdotool is installed
    // get the arguments
    FlValue *args = fl_method_call_get_args(method_call);
    
    FlValue *leftShiftPressed = fl_value_lookup_string(args, "leftShiftPressed");
    FlValue *rightShiftPressed = fl_value_lookup_string(args, "rightShiftPressed");
    
    FlValue *leftAltPressed = fl_value_lookup_string(args, "leftAltPressed");
    FlValue *rightAltPressed = fl_value_lookup_string(args, "rightAltPressed");
    
    FlValue *leftControlPressed = fl_value_lookup_string(args, "leftControlPressed");
    FlValue *rightControlPressed = fl_value_lookup_string(args, "rightControlPressed");

    FlValue *leftMetaPressed = fl_value_lookup_string(args, "leftMetaPressed");
    FlValue *rightMetaPressed = fl_value_lookup_string(args, "rightMetaPressed");
    
    // get the keyCode as string 
    FlValue *keyCodeValue = fl_value_lookup_string(args, "platformKeyCode");

    // convert the modifiers to bool 
    const bool leftShift = fl_value_get_bool(leftShiftPressed);
    const bool rightShift = fl_value_get_bool(rightShiftPressed);

    const bool leftAlt = fl_value_get_bool(leftAltPressed);
    const bool rightAlt = fl_value_get_bool(rightAltPressed);

    const bool leftControl = fl_value_get_bool(leftControlPressed);
    const bool rightControl = fl_value_get_bool(rightControlPressed);

    const bool leftMeta = fl_value_get_bool(leftMetaPressed);
    const bool rightMeta = fl_value_get_bool(rightMetaPressed);

    // create a string with the modifiers
    std::string modifiers = "";
    if (leftShift) modifiers += "Shift_L ";
    if (rightShift) modifiers += "Shift_R ";
    if (leftAlt) modifiers += "Alt_L ";
    if (rightAlt) modifiers += "Alt_R ";
    if (leftControl) modifiers += "Control_L ";
    if (rightControl) modifiers += "Control_R ";
    if (leftMeta) modifiers += "Meta_L ";
    if (rightMeta) modifiers += "Meta_R ";
    // when a modifier is pressed, hold it down until the key is pressed
    if (modifiers != "") hold_keys(modifiers.c_str());

    // invoke the key
    response = invoke_key(fl_value_get_string(keyCodeValue));
    
    // release the modifiers
    if (modifiers!= "") release_modifiers();
  }
  else
  {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }
  fl_method_call_respond(method_call, response, nullptr);
}

FlMethodResponse *invoke_key(const char* keyCode)
{
    // Execute the key event
    std::string command = "xdotool key ";
    command += keyCode;
    int result = system(command.c_str());

    if (result == 0)
    {
        // return true if the command was executed successfully
        g_autoptr(FlValue) result = fl_value_new_bool(true);
        FlMethodResponse *response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
        return response;
    }
    else
    {
        g_autoptr(FlValue) result = fl_value_new_bool(false);
        FlMethodResponse *response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
        return response;
    }
}

static void keyboard_invoker_plugin_dispose(GObject *object)
{
  G_OBJECT_CLASS(keyboard_invoker_plugin_parent_class)->dispose(object);
}

static void keyboard_invoker_plugin_class_init(KeyboardInvokerPluginClass *klass)
{
  G_OBJECT_CLASS(klass)->dispose = keyboard_invoker_plugin_dispose;
}

static void keyboard_invoker_plugin_init(KeyboardInvokerPlugin *self) {}

static void method_call_cb(FlMethodChannel *channel, FlMethodCall *method_call,
                           gpointer user_data)
{
  KeyboardInvokerPlugin *plugin = KEYBOARD_INVOKER_PLUGIN(user_data);
  keyboard_invoker_plugin_handle_method_call(plugin, method_call);
}

void keyboard_invoker_plugin_register_with_registrar(FlPluginRegistrar *registrar)
{
  KeyboardInvokerPlugin *plugin = KEYBOARD_INVOKER_PLUGIN(
      g_object_new(keyboard_invoker_plugin_get_type(), nullptr));

  g_autoptr(FlStandardMethodCodec) codec = fl_standard_method_codec_new();
  g_autoptr(FlMethodChannel) channel =
      fl_method_channel_new(fl_plugin_registrar_get_messenger(registrar),
                            "keyboard_invoker",
                            FL_METHOD_CODEC(codec));
  fl_method_channel_set_method_call_handler(channel, method_call_cb,
                                            g_object_ref(plugin),
                                            g_object_unref);

  g_object_unref(plugin);
}