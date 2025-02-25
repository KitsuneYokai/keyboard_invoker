import 'dart:io';
import 'package:flutter/material.dart';
// import provider for the keyboard invoker
import 'package:provider/provider.dart';

import 'package:keyboard_invoker/keyboard_invoker.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

/// TODO: Create a Better Example for the v2.0.0 (2.0.0 because of so many breaking changes)
/// Things to note:
///   - do not include a text field that gets focused when invoking the macro recording/Default,
///     and point out in the readme, that it should not be used to input text into its own application
///     or advise against it (have to do some testing on that one)
///
///     If a user dose, and invokes a sequence including a modifier `shift` for example, the next char gets
///     skiped, and the next char follows.
///
///     If its a sequence of keys, that gets invoked, when the user holds down a modifier `shift` for example,
///     The next char (after that one that disappears) is cappitalized, until the held down KeyRecord is played
///     This also includes the alt modifier
///
///     This happens on:
///       - Windows
///       - Linux (have to test)
///       - MacOs (have to test)
///
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
  List<KeyRecording> keyboardKeyList = [
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyDown),
    KeyMap.keyB.keyRecording(),
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyUp),
    KeyMap.keyR.keyRecording(),
    KeyMap.keyA.keyRecording(),
    KeyMap.keyT.keyRecording(),
    KeyMap.keyW.keyRecording(),
    KeyMap.keyU.keyRecording(),
    KeyMap.keyR.keyRecording(),
    KeyMap.keyS.keyRecording(),
    KeyMap.keyT.keyRecording(),
    KeyMap.space.keyRecording(),
    KeyMap.keyU.keyRecording(),
    KeyMap.keyN.keyRecording(),
    KeyMap.keyD.keyRecording(),
    KeyMap.space.keyRecording(),
    KeyMap.keyE.keyRecording(),
    KeyMap.keyI.keyRecording(),
    KeyMap.keyN.keyRecording(),
    KeyMap.space.keyRecording(),
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyDown),
    KeyMap.keyG.keyRecording(),
    KeyMap.keyR.keyRecording(),
    KeyMap.keyO.keyRecording(),
    KeyMap.keyS.keyRecording(),
    KeyMap.keyS.keyRecording(),
    KeyMap.keyE.keyRecording(),
    KeyMap.keyS.keyRecording(),
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyUp),
    KeyMap.space.keyRecording(),
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyDown),
    KeyMap.keyB.keyRecording(),
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyUp),
    KeyMap.keyI.keyRecording(),
    KeyMap.keyE.keyRecording(),
    KeyMap.keyR.keyRecording(),
    KeyMap.altLeft.keyRecording(keyEventType: KeyEventType.keyDown),
    KeyMap.numpad3.keyRecording(),
    KeyMap.altLeft.keyRecording(keyEventType: KeyEventType.keyUp),
  ];

  Duration invokeDelay = Duration(seconds: 3);

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
              children: [
                if (Platform.isLinux) ...[
                  Text("Is X11: ${keyboardInvokerPlugin.isX11}"),
                  Text(
                      "Is xdotool installed: ${keyboardInvokerPlugin.isXdotoolInstalled}"),
                ],
                Text(
                    "Recording: ${keyboardInvokerPlugin.recorder.isRecording}"),
                // add a checkbox to enable/disable the delay recording,
              ],
            ),
            Row(
              children: [
                const Text("Record Delay:"),
                Checkbox(
                  value: keyboardInvokerPlugin.recorder.includeDelays,
                  onChanged: (value) {
                    keyboardInvokerPlugin.recorder.includeDelays = value!;
                  },
                )
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
                children: keyboardInvokerPlugin.recorder.recordedKeys
                    .map((e) => Text(
                          "EventType: ${e.keyEventType}: ${e.logicalKeyId?.keyLabel} - Linux: ${e.linux} - Windows: ${e.windows} - Mac: ${e.mac} - delay: ${e.delay}",
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
                    onPressed: keyboardInvokerPlugin.recorder.isRecording
                        ? () {
                            // stop recording
                            keyboardInvokerPlugin.recorder.stopRecording();
                          }
                        : () {
                            // start recording
                            keyboardInvokerPlugin.recorder.startRecording();
                          },
                    child: keyboardInvokerPlugin.recorder.isRecording
                        ? const Text("Stop Macro Recording")
                        : const Text("Start Macro Recording")),
                ElevatedButton(
                    onPressed: () {
                      // clear the recorded keys
                      keyboardInvokerPlugin.recorder.clearRecording();
                    },
                    child: const Text("Clear Recorded Macro")),
                ElevatedButton(
                  onPressed: () async {
                    // Focus the text field
                    _focusNode.requestFocus();

                    //delay with the invokeDelay
                    await Future.delayed(invokeDelay);

                    try {
                      // Stop recording
                      keyboardInvokerPlugin.recorder.stopRecording();

                      // Invoke the recorded macro
                      await keyboardInvokerPlugin.recorder.invokeRecording();
                    } catch (e) {
                      String errorMessage = '';

                      if (e is LinuxError) {
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

                      await Future.delayed(invokeDelay);

                      try {
                        // Stop recording
                        keyboardInvokerPlugin.recorder.stopRecording();

                        // Invoke the recorded macro
                        await keyboardInvokerPlugin.invokeKeys(
                          keyboardKeyList,
                        );
                      } catch (e) {
                        String errorMessage = '';

                        if (e is LinuxError) {
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
                ElevatedButton(
                    child: const Text("Invoke Test Macro (FORCE NUM TRUE)"),
                    onPressed: () async {
                      // Focus the text field
                      _focusNode.requestFocus();

                      await Future.delayed(invokeDelay);

                      try {
                        // Stop recording
                        keyboardInvokerPlugin.recorder.stopRecording();

                        // Invoke the recorded macro
                        await keyboardInvokerPlugin.invokeKeys(
                          keyboardKeyList,
                          forceNumState: true,
                        );
                      } catch (e) {
                        String errorMessage = '';

                        if (e is LinuxError) {
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
                    }),
                ElevatedButton(
                    child: const Text("Print NumLockState"),
                    onPressed: () async {
                      showAboutDialog(context: context, children: [
                        Text((await keyboardInvokerPlugin.checkNumLockState())
                            .toString())
                      ]);
                    })
              ],
            )
          ],
        ));
  }
}
