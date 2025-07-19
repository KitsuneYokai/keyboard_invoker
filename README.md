# keyboard_invoker

**keyboard_invoker** is a Flutter lib that allows you to invoke and record keys on the host os.

## Features

- **Record Keys**: Capture a sequence of key presses to create custom macros.
- **Invoke Keys**: Invoke recorded or predefined key sequences on your host OS.
- **Install XdoTool (Linux only)**: Easily set up the required tool for Linux support with a single command.

## Platform Support

| Windows | Linux | MacOS |
| :-----: | :---: | :---: |
|   ✔️    |  ✔️   |  ✔️   |

## Getting Started

To use the **keyboard_invoker** lib inside your Flutter project you can follow those simple steps:

### Installing

To add **keyboard_invoker** to your Flutter project, open your project folder in the command prompt and run the following command:

```sh
flutter pub add keyboard_invoker
```

Now you should be able to use the **keyboard_invoker** lib inside your project.

### Installing (latest github commit)

If you would like to use the latest version, committed to the main branch, you can edit your `pubspec.yaml` file and change the `keyboard_invoker` dependency from this:

```yaml
...
dependencies:
  keyboard_invoker: <installed version>
...
```

to something like this:

```yaml
...
dependencies:
  keyboard_invoker:
    git:
      url: https://github.com/KitsuneYokai/keyboard_invoker.git
      ref: main
...
```

and now you should be able to use the latest version of **keyboard_invoker**, committed to the main branch.

**!!! It's not advised to use the main branch in production, as it may contain breaking changes or bugs !!!**

## Usage/Examples

In this example we gonna use the [Provider](https://pub.dev/packages/provider) package to keep track of the KeyboardInvoker states.

Here is an short example:

### Implementing the KeyboardInvoker

```dart
void main() {
  final _keyboardInvoker = KeyboardInvoker();

  runApp(
    ChangeNotifierProvider(
      create: (_) => _keyboardInvoker,
      child: const MyApp(),
    ),
  );
}

```

Then, you can access it inside your widgets build method like this:

```dart
@override
Widget build(BuildContext context) {
  final keyboardInvokerPlugin = Provider.of<KeyboardInvoker>(context);
  ...
}
```

### Record Keys

```dart
ElevatedButton(
  onPressed: () {
    // Start or stop the recording depending on the current state of the recorder
    if (keyboardInvoker.recorder.isRecording) {
      keyboardInvoker.recorder.stopRecording();
    } else {
      keyboardInvoker.recorder.startRecording();
    }
  },
  child: Icon(
    keyboardInvoker.recorder.isRecording
        ? Icons.stop_circle
        : Icons.fiber_manual_record,
    color: keyboardInvoker.recorder.isRecording
        ? Colors.red
        : Colors.white,
  ),
)
```

### Invoke a Macro using the KeyRecordingsMap

```dart
...

final List<KeyRecording> _demoSequence = [
  KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyDown),
  KeyMap.keyH.keyRecording(), // defaults to keyInvoke = down + up in an instant
  KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyUp),
  KeyMap.keyE.keyRecording(),
  KeyMap.keyL.keyRecording(),
  KeyMap.keyL.keyRecording(),
  KeyMap.keyO.keyRecording(),
  KeyMap.space.keyRecording(delay: 500), // Adding a delay
  KeyMap.keyW.keyRecording(),
  KeyMap.keyO.keyRecording(),
  KeyMap.keyR.keyRecording(),
  KeyMap.keyL.keyRecording(),
  KeyMap.keyD.keyRecording(),
];

...

ElevatedButton(
  onPressed: () async {
    await keyboardInvoker.invokeKeys(_demoSequence);
  },
  child: const Text("Invoke Demo Sequence"),
)
```

### Convert a list of LogicalKeyboardKeys to a Macro List and invoke it

```dart
// A List of LogicalKeyboardKey´s to invoke on the host os
final List<LogicalKeyboardKey> keyboardKeyList = [
    LogicalKeyboardKey.keyH,
    LogicalKeyboardKey.keyI,
]

...

ElevatedButton(
  onPressed: () async {
    try {
      // convert our logical keys to KeyRecording objects
      final keyRecordings =
          KeyRecordingsMap.fromLogicalKeyList(
        _logicalKeyboardKeys,
      );

      // invoke the keys
      await keyboardInvoker.invokeKeys(keyRecordings,
          forceNumState: _forceNumState);
    } catch (e) {
      showError(context, e);
    }
  },
  child: const Icon(Icons.keyboard_command_key),
),
```

For more examples, check out the [example app](https://github.com/KitsuneYokai/keyboard_invoker/tree/main/example/lib/main.dart).

## Contributing

Contributions to **keyboard_invoker** are very welcome, whether it's fixing bugs, improving documentation, or adding new features.
If you encounter a bug or have a feature request, please [open an issue](https://github.com/KitsuneYokai/keyboard_invoker/issues) on GitHub.

## License

This plugin is released under the [MIT License](LICENSE).
