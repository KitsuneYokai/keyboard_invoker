#include <flutter_linux/flutter_linux.h>
#include <string>

#include "include/keyboard_invoker/keyboard_invoker_plugin.h"

// This file exposes some plugin internals for unit testing. See
// https://github.com/flutter/flutter/issues/88724 for current limitations
// in the unit-testable API.

// Handle the platform method call.
FlMethodResponse *invoke_key(const char* keyCode, bool leftShift, bool rightShift, bool leftAlt, bool rightAlt, bool leftControl, bool rightControl, bool leftMeta, bool rightMeta);