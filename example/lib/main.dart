import 'dart:io';

import 'package:flutter/material.dart';
// import provider for the keyboard invoker
import 'package:flutter/services.dart';
import 'package:keyboard_invoker/keyboard_invoker.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard_invoker example',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Keyboard_invoker example'),
          ),
          // using the provider
          body: ChangeNotifierProvider<KeyboardInvoker>(
              create: (context) {
                return KeyboardInvoker();
              },
              child: const KeyboardInvokerExample())),
    );
  }
}

class KeyboardInvokerExample extends StatefulWidget {
  const KeyboardInvokerExample({super.key});

  @override
  State<KeyboardInvokerExample> createState() => _KeyboardInvokerExampleState();
}

class _KeyboardInvokerExampleState extends State<KeyboardInvokerExample> {
  late FocusNode _focusNode;
  final macroRecordingScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    macroRecordingScrollController.dispose();
    super.dispose();
  }

  // This is the LogicalKeyboardKey List
  List<LogicalKeyboardKey> keyboardKeyList = [
    LogicalKeyboardKey.shiftLeft,
    LogicalKeyboardKey.keyB,
    LogicalKeyboardKey.keyR,
    LogicalKeyboardKey.keyA,
    LogicalKeyboardKey.keyT,
    LogicalKeyboardKey.keyW,
    LogicalKeyboardKey.keyU,
    LogicalKeyboardKey.keyR,
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.keyT,
    LogicalKeyboardKey.space,
    LogicalKeyboardKey.keyU,
    LogicalKeyboardKey.keyN,
    LogicalKeyboardKey.keyD,
    LogicalKeyboardKey.space,
    LogicalKeyboardKey.keyE,
    LogicalKeyboardKey.keyI,
    LogicalKeyboardKey.keyN,
    LogicalKeyboardKey.space,
    LogicalKeyboardKey.keyG,
    LogicalKeyboardKey.keyR,
    LogicalKeyboardKey.keyO,
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.keyE,
    LogicalKeyboardKey.keyS,
    LogicalKeyboardKey.space,
    LogicalKeyboardKey.keyB,
    LogicalKeyboardKey.keyI,
    LogicalKeyboardKey.keyE,
    LogicalKeyboardKey.keyR,
  ];

  @override
  Widget build(BuildContext context) {
    final keyboardInvokerPlugin = Provider.of<KeyboardInvoker>(context);

    return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (Platform.isLinux) ...[
                  Text("Is X11: ${keyboardInvokerPlugin.isX11}"),
                  Text(
                      "Is xdotool installed: ${keyboardInvokerPlugin.isXdotoolInstalled}"),
                ],
                Text("Recording: ${keyboardInvokerPlugin.isRecording}"),
              ],
            ),
            TextField(
              focusNode: _focusNode,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Test Field',
              ),
            ),
            Expanded(
                child: SingleChildScrollView(
              controller: macroRecordingScrollController,
              child: Column(
                children: keyboardInvokerPlugin.recordedKeys
                    .map((e) => Text(
                          "Key: ${e["keyLabel"]} Code: ${e["keyCode"]} Event: ${e["event"]} Modifiers: ${e["modifiers"]}",
                          style: const TextStyle(fontSize: 20),
                        ))
                    .toList(),
              ),
            )),
            // Test Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                        ? const Text("Stop Macro Recording")
                        : const Text("Start Macro Recording")),
                ElevatedButton(
                    onPressed: () {
                      // clear the recorded keys
                      keyboardInvokerPlugin.recordedKeys = [];
                    },
                    child: const Text("Clear Recorded Macro")),
                ElevatedButton(
                  onPressed: () async {
                    // Focus the text field
                    _focusNode.requestFocus();

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
                ),
                ElevatedButton(
                    onPressed: () async {
                      // Focus the text field
                      _focusNode.requestFocus();
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
                    child: const Text("Invoke Test Macro")),
              ],
            )
          ],
        ));
  }
}
