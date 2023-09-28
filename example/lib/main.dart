import 'package:flutter/material.dart';
// import provider for the keyboard invoker
import 'package:flutter/services.dart';
import 'package:keyboard_invoker/keyboard_invoker.dart';
import 'package:provider/provider.dart';

final _keyboardInvokerPlugin = KeyboardInvoker();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => _keyboardInvokerPlugin,
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late FocusNode _focusNode;
  final macroRecordingScrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // initializing the focus node
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // disposing the focus node
    _focusNode.dispose();
    super.dispose();
  }

  // This is the macro List
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

    if (macroRecordingScrollController.hasClients) {
      macroRecordingScrollController.jumpTo(
        macroRecordingScrollController.position.maxScrollExtent + 27,
      );
    }

    return MaterialApp(
      title: 'Keyboard_invoker example',
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Keyboard_invoker example'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Test Field',
                    ),
                  ),
                  Text("Recording: ${keyboardInvokerPlugin.isRecording}"),
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
                  // macro test button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () async {
                            // focusing the text field
                            _focusNode.requestFocus();
                            // convert the macro list to a list of maps
                            List<Map<String, dynamic>> macroList =
                                await keyboardInvokerPlugin
                                    .logicalKeyboardKeysToMacro(
                                        keyboardKeyList);
                            // invoke the macro
                            await keyboardInvokerPlugin
                                .invokeMacroList(macroList);
                          },
                          child: const Text("Test Macro (bratwurst)")),
                      // modifier test button (shift hold and release)
                      ElevatedButton(
                          onPressed: () async {
                            // focusing the text field
                            _focusNode.requestFocus();
                            // invoking the macro with shift
                          },
                          child: const Text("Test Macro (bratwurst)(shift)"))
                    ],
                  ),

                  // macro recording buttons
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
                              ? const Text("stop Macro Recording")
                              : const Text("Start Macro Recording")),
                      ElevatedButton(
                          onPressed: () {
                            // clear the recorded keys
                            keyboardInvokerPlugin.recordedKeys = [];
                          },
                          child: const Text("Clear Recorded Macro")),
                      ElevatedButton(
                          onPressed: () async {
                            // focusing the text field
                            _focusNode.requestFocus();
                            // stop recording
                            keyboardInvokerPlugin.stopRecording();
                            keyboardInvokerPlugin.invokeRecordedKeyList();
                          },
                          child: const Text("Invoke Recorded Macro")),
                    ],
                  )
                ],
              ))),
    );
  }
}
