# keyboard_invoker

**keyboard_invoker** is a Flutter plugin that allows you to record keys and invoke them on the host operating system.

## Features

- **Record and Replay Keys**: Easily record a sequence of keyboard keys and replay them when needed.

- **Convert to MacroMap**: Convert a list of LogicalKeyboardKeys into a MacroMap for later invocation.

## Platform Support

| Windows | Linux | MacOS |
| :-----: | :---: | :---: |
|   ✔️    |  ✔️   |  ✔️   |

## Getting Started

To get started with **keyboard_invoker**, follow these steps:

### Installation

To add **keyboard_invoker** to your Flutter project, open your project folder in the command prompt and run the following command:

```sh
flutter pub add keyboard_invoker
```

## Setting Up on Linux

To get started on Linux, you'll need to install `xdotool` and configure your display server to use `X11`.

### Installing xdotool

To install `xdotool`, open your terminal and run the following command:

```sh
sudo apt-get install xdotool
```

### Configuring Your Display Server (For Ubuntu 22.04)

For Ubuntu 22.04, you'll also need to adjust your display server settings. To do this:

```sh
sudo nano /etc/gdm3/custom.conf
```

Find the line that reads `WaylandEnable=false`, uncomment it if necessary, save the changes, and then reboot your system for the settings to take effect.

## Setting Up on MacOS

On MacOS, the setup is simpler, as you won't need to install any additional software. However, you will need to grant permission for monitoring your keyboard input when prompted while trying to invoke a macro.

Keep in mind that this plugin wont work with Flutter apps in debug mode on MacOS. You'll need to build a release version for it to function properly, only for MacOS tough.

## Usage/Examples

We gonna use the Provider package to keep track of the KeyboardInvoker states.

Here is an short example:

```dart
// ChangeNotifierProvider doesn't need to be at the root of your app
void main() {
  final _keyboardInvokerPlugin = KeyboardInvoker();

  runApp(
    ChangeNotifierProvider(
      create: (_) => _keyboardInvokerPlugin,
      child: const MyApp(),
    ),
  );
}

```

Then, you can access it inside your build method like this:

```dart
@override
Widget build(BuildContext context) {
  final keyboardInvokerPlugin = Provider.of<KeyboardInvoker>(context);
  ...
}
```

**Record a sequence of keys**

```dart
ElevatedButton(
  onPressed: keyboardInvokerPlugin.isRecording
  ? () async {
    // stop recording
    await keyboardInvokerPlugin.stopRecording();
  }
  : () async {
    // start recording
    await keyboardInvokerPlugin.startRecording();
  },
  child: keyboardInvokerPlugin.isRecording
    ? const Text("stop Macro Recording")
    : const Text("Start Macro Recording")
)
```

**Invoke a Recorded sequence of keys**

```dart
ElevatedButton(
  onPressed: () async {
    try {
      // Stop recording
      await keyboardInvokerPlugin.stopRecording();
      // Invoke the recorded macro
      await keyboardInvokerPlugin.invokeMacroList(
        keyboardInvokerPlugin.recordedKeys,
      );
    } catch (e) {
      String errorMessage = '';
      if (e is X11NotActiveInstalled) {
        errorMessage = e.message;
      } else if (e is XdotoolNotInstalled) {
        errorMessage = e.message;
      } else {
        errorMessage = 'An error occurred: ${e.toString()}';
      }
      // Use the captured context to show the dialog
      showAboutDialog(
        context: context,
        children: [
          Text('Error invoking macro: $errorMessage'),
        ],
      );
    }
  },
  child: const Text("Invoke Recorded Macro"),
)
```

**Invoke a LogicalKeyList**

```dart
// A List of LogicalKeyboardKey´s to invoke on the host os
final List<LogicalKeyboardKey> keyboardKeyList = [
    LogicalKeyboardKey.shiftLeft,
    LogicalKeyboardKey.keyH,
    LogicalKeyboardKey.keyI,
]

ElevatedButton(
  onPressed: () async {
    try {
      // Stop recording
      await keyboardInvokerPlugin.stopRecording();
      // convert the macro list to a list of maps
      List<Map<String, dynamic>> macroList =
          await keyboardInvokerPlugin
              .logicalKeyboardKeysToMacro(keyboardKeyList);
      // Invoke the recorded macro
      await keyboardInvokerPlugin.invokeMacroList(
        macroList,
      );
    } catch (e) {
      String errorMessage = '';
      if (e is X11NotActiveInstalled) {
        errorMessage = e.message;
      } else if (e is XdotoolNotInstalled) {
        errorMessage = e.message;
      } else {
        errorMessage = 'An error occurred: ${e.toString()}';
      }
      // Use the captured context to show the dialog
      showAboutDialog(
        context: context,
        children: [
          Text('Error invoking macro: $errorMessage'),
        ],
      );
    }
  },
  child: const Text("Invoke Test Macro")
)
```

## Contributing

We welcome contributions to **keyboard_invoker**. If you encounter a bug or have a feature request, please [open an issue](https://github.com/KitsuneYokai/keyboard_invoker/issues) on GitHub.

## License

This plugin is released under the [MIT License](LICENSE).
