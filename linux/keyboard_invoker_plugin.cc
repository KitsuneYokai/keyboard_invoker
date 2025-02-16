#include "include/keyboard_invoker/keyboard_invoker_plugin.h"

#include <flutter_linux/flutter_linux.h>
#include <gtk/gtk.h>
#include <sys/utsname.h>
#include <string>

#include "keyboard_invoker_plugin_private.h"

#define KEYBOARD_INVOKER_PLUGIN(obj)                                       \
    (G_TYPE_CHECK_INSTANCE_CAST((obj), keyboard_invoker_plugin_get_type(), \
                                KeyboardInvokerPlugin))

struct _KeyboardInvokerPlugin
{
    GObject parent_instance;
};

G_DEFINE_TYPE(KeyboardInvokerPlugin, keyboard_invoker_plugin, g_object_get_type())

/**
 * This function invokes a key on the host system (press and release in one go)
 *
 * @param keyCode The key code xdotool should execute
 * @return FL_METHOD_RESPONSE returns true if the operation was sucessfully executed
 */
static FlMethodResponse *invoke_key(const char *keyCode)
{
    std::string command = "xdotool key " + std::string(keyCode);
    int result = system(command.c_str());
    g_autoptr(FlValue) return_value = fl_value_new_bool(result == 0);
    return FL_METHOD_RESPONSE(fl_method_success_response_new(return_value));
}

/**
 * This function holds a key on the host system
 *
 * @param keyCode The key code xdotool should hold
 * @return FL_METHOD_RESPONSE returns true if the operation was sucessfully executed
 */
static FlMethodResponse *hold_key(const char *keyCode)
{
    std::string command = "xdotool keydown " + std::string(keyCode);
    int result = system(command.c_str());
    g_autoptr(FlValue) return_value = fl_value_new_bool(result == 0);
    return FL_METHOD_RESPONSE(fl_method_success_response_new(return_value));
}

/**
 * This function releases a key on the host system
 *
 * @param keyCode The key code xdotool should execute
 * @return FL_METHOD_RESPONSE returns true if the operation was sucessfully executed
 */
static FlMethodResponse *release_key(const char *keyCode)
{
    std::string command = "xdotool keyup " + std::string(keyCode);
    int result = system(command.c_str());
    g_autoptr(FlValue) return_value = fl_value_new_bool(result == 0);
    return FL_METHOD_RESPONSE(fl_method_success_response_new(return_value));
}

/**
 * This function gets executed if a method call is executed by dart.
 *
 * it checks for the method name, and executes the 'invokeKey', 'invokeKey' or'invokeKey'
 * accordingly to the fired method call.
 *
 * Parameters:
 * @param self The KeyboardInvokerPlugin class
 * @param method_call the method call seld by dart
 *
 * Returns:
 * @returns FL_METHOD_RESPONSE
 */
static void keyboard_invoker_plugin_handle_method_call(
    KeyboardInvokerPlugin *self,
    FlMethodCall *method_call)
{
    g_autoptr(FlMethodResponse) response = nullptr;
    const gchar *method = fl_method_call_get_name(method_call);
    FlValue *args = fl_method_call_get_args(method_call);

    if (strcmp(method, "validatePermissions") == 0)
    {
        // since linux dosnt require permissions to execute this, we just gonna return a success
        g_autoptr(FlValue) result = fl_value_new_bool(true);
        response = FL_METHOD_RESPONSE(fl_method_success_response_new(result));
    }
    // if we get invoke-, hold- or release key, we gonna check for the key code argument,
    // and execute the coresponding function
    else if (strcmp(method, "invokeKey") == 0 ||
             strcmp(method, "holdKey") == 0 ||
             strcmp(method, "releaseKey") == 0)
    {
        // lets check if the arguments are send as flutter map type, if it dose, we extract
        // the keycode from it, typecheck it, and invoke the method function
        if (fl_value_get_type(args) != FL_VALUE_TYPE_MAP)
        {
            response = FL_METHOD_RESPONSE(fl_method_error_response_new(
                "INVALID_ARGUMENT",
                "Expected map with keyCode",
                nullptr));
        }
        else
        {
            // type check and get the keyCOde parameter form the map, if it is not present, we
            // gonna raise a exception
            FlValue *key_code_value = fl_value_lookup_string(args, "keyCode");
            if (key_code_value == nullptr || fl_value_get_type(key_code_value) != FL_VALUE_TYPE_STRING)
            {
                response = FL_METHOD_RESPONSE(fl_method_error_response_new(
                    "INVALID_ARGUMENT",
                    "Expected string keyCode",
                    nullptr));
            }
            else
            {
                // Finally, we get the key code as char array, compare the method call, and
                // execute the function coresponding to the method call
                const char* key_str = fl_value_get_string(key_code_value);

                // invokeKey
                if (strcmp(method, "invokeKey") == 0)
                {
                    response = invoke_key(key_str);
                }
                // holdKey
                else if (strcmp(method, "holdKey") == 0)
                {
                    response = hold_key(key_str);
                }
                // releaseKey
                else if (strcmp(method, "releaseKey") == 0)
                {
                    response = release_key(key_str);
                }
            }
        }
    }

    // If the method call dosn't meet any of the above condtions,
    // we gona raise the MethodNotImplemented Exception
    else
    {
        response = FL_METHOD_RESPONSE(fl_method_not_implemented_response_new());
    }

    // send the response
    fl_method_call_respond(method_call, response, nullptr);
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