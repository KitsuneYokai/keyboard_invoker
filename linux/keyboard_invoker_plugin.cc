#include "include/keyboard_invoker/keyboard_invoker_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <string>

#include "keyboard_invoker_plugin_private.h"

#define KEYBOARD_INVOKER_PLUGIN(obj)                                     \
  (G_TYPE_CHECK_INSTANCE_CAST((obj), keyboard_invoker_plugin_get_type(), \
                              KeyboardInvokerPlugin))

struct _KeyboardInvokerPlugin
{
  GObject parent_instance;
};

G_DEFINE_TYPE(KeyboardInvokerPlugin, keyboard_invoker_plugin, g_object_get_type())

// Called when a method call is received from Flutter.
static void keyboard_invoker_plugin_handle_method_call(
    KeyboardInvokerPlugin *self,
    FlMethodCall *method_call)
{
  g_autoptr(FlMethodResponse) response = nullptr;

  const gchar *method = fl_method_call_get_name(method_call);

  if (strcmp(method, "getPlatformVersion") == 0)
  {
    response = get_platform_version();
  }
  else if (strcmp(method, "invokeKey") == 0)
  {
    // get the arguments
    FlValue *args = fl_method_call_get_args(method_call);
    // get the keyCode as string 
    FlValue *keyCodeValue = fl_value_lookup_string(args, "keyCode");
    // convert the keyCode to int
    response = invoke_key(fl_value_get_string(keyCodeValue));
  }
  else if (strcmp(method, "holdKey") == 0)
  {
    // get the arguments
    FlValue *args = fl_method_call_get_args(method_call);
    // get the keyCode as string 
    FlValue *keyCodeValue = fl_value_lookup_string(args, "keyCode");
    // convert the keyCode to int
    response = hold_key(fl_value_get_string(keyCodeValue));
  }
  else if (strcmp(method, "releaseKey") == 0)
  {
    // get the arguments
    FlValue *args = fl_method_call_get_args(method_call);
    // get the keyCode as string 
    FlValue *keyCodeValue = fl_value_lookup_string(args, "keyCode");
    // convert the keyCode to int
    response = release_key(fl_value_get_string(keyCodeValue));
  }
  else
  {
    response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
  }
  fl_method_call_respond(method_call, response, nullptr);
}

FlMethodResponse *get_platform_version()
{
  struct utsname uname_data = {};
  uname(&uname_data);
  g_autofree gchar *version = g_strdup_printf("Linux %s", uname_data.version);
  g_autoptr(FlValue) result = fl_value_new_string(version);
  return FL_METHOD_RESPONSE(fl_method_success_response_new(result));
}
// TODO: make this better
FlMethodResponse *invoke_key(const char* keyCode)
{
    // Execute the system command
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
        // return false if the command failed
        g_autoptr(FlValue) result = fl_value_new_bool(false);
        FlMethodResponse *response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
        return response;
    }
}

FlMethodResponse *hold_key(const char* keyCode)
{
    // Execute the system command
    std::string command = "xdotool keydown ";
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
        // return false if the command failed
        g_autoptr(FlValue) result = fl_value_new_bool(false);
        FlMethodResponse *response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
        return response;
    }
}
FlMethodResponse *release_key(const char* keyCode)
{
    // Execute the system command
    std::string command = "xdotool keyup ";
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
        // return false if the command failed
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
