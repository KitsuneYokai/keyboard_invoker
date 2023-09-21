import 'package:flutter/material.dart';
import 'dart:async';
// import provider for the keyboard invoker
import 'package:flutter/services.dart';
import 'package:keyboard_invoker/keyboard_invoker.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

final _keyboardInvokerPlugin = KeyboardInvoker();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  late FocusNode _focusNode;
  final macroRecordingScrollController = ScrollController();

  List<Map<String, dynamic>> _recordedKeys = [];
  bool _isRecording = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    // initializing the focus node
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    // disposing the focus node
    _focusNode.dispose();
    super.dispose();
  }

  // This is the macro recording ("bratwurst und ein grosses bier")
  List testMacroRecording = [
    LogicalKeyboardKey.keyB.keyId,
    LogicalKeyboardKey.keyR.keyId,
    LogicalKeyboardKey.keyA.keyId,
    LogicalKeyboardKey.keyT.keyId,
    LogicalKeyboardKey.keyW.keyId,
    LogicalKeyboardKey.keyU.keyId,
    LogicalKeyboardKey.keyR.keyId,
    LogicalKeyboardKey.keyS.keyId,
    LogicalKeyboardKey.keyT.keyId,
    LogicalKeyboardKey.space.keyId,
    LogicalKeyboardKey.keyU.keyId,
    LogicalKeyboardKey.keyN.keyId,
    LogicalKeyboardKey.keyD.keyId,
    LogicalKeyboardKey.space.keyId,
    LogicalKeyboardKey.keyE.keyId,
    LogicalKeyboardKey.keyI.keyId,
    LogicalKeyboardKey.keyN.keyId,
    LogicalKeyboardKey.space.keyId,
    LogicalKeyboardKey.keyG.keyId,
    LogicalKeyboardKey.keyR.keyId,
    LogicalKeyboardKey.keyO.keyId,
    LogicalKeyboardKey.keyS.keyId,
    LogicalKeyboardKey.keyS.keyId,
    LogicalKeyboardKey.keyE.keyId,
    LogicalKeyboardKey.keyS.keyId,
    LogicalKeyboardKey.space.keyId,
    LogicalKeyboardKey.keyB.keyId,
    LogicalKeyboardKey.keyI.keyId,
    LogicalKeyboardKey.keyE.keyId,
    LogicalKeyboardKey.keyR.keyId,
  ];
  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _keyboardInvokerPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // simple macro recording function
  recordKeys(RawKeyEvent event) {
    String keyLabel = event.logicalKey.keyLabel;
    int keyCode = event.logicalKey.keyId;

    bool isRepeat = event.repeat;

    Map<String, dynamic> macroMap = {
      "keyLabel": null,
      "code": null,
      "event": null,
    };

    // don't record the key if it's a repeated event
    if (!isRepeat) {
      // only record the modifier keys on a key down event
      if (event is RawKeyDownEvent) {
        if (keyLabel.toLowerCase().contains("shift") ||
            keyLabel.toLowerCase().contains("ctrl") ||
            keyLabel.toLowerCase().contains("alt") ||
            keyLabel.toLowerCase().contains("meta")) {
          macroMap["keyLabel"] = keyLabel;
          macroMap["code"] = keyCode;
          macroMap["event"] = KeyType.keyDown;

          setState(() {
            _recordedKeys = [..._recordedKeys, macroMap];
          });
        }
        // record the keys on a key up event, so they are not held down
      } else if (event is RawKeyUpEvent) {
        macroMap["keyLabel"] = keyLabel;
        macroMap["code"] = keyCode;
        macroMap["event"] = KeyType.keyInvoke;

        if (keyLabel.toLowerCase().contains("shift") ||
            keyLabel.toLowerCase().contains("ctrl") ||
            keyLabel.toLowerCase().contains("alt") ||
            keyLabel.toLowerCase().contains("meta")) {
          macroMap["event"] = KeyType.keyUp;
        }
        // set the state
        setState(() {
          _recordedKeys = [..._recordedKeys, macroMap];
        });
      }
    }
  }

  startRecording() {
    // clear the recorded keys
    setState(() {
      _recordedKeys = [];
      _isRecording = true;
    });
    // add the listener
    RawKeyboard.instance.addListener(recordKeys);
  }

  stopRecording() {
    // remove the listener
    RawKeyboard.instance.removeListener(recordKeys);
    // set the state
    setState(() {
      _isRecording = false;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                  Center(
                    child: Text('Running on: $_platformVersion\n'),
                  ),
                  TextField(
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Test Field',
                    ),
                  ),
                  Text("Recording: $_isRecording"),
                  Expanded(
                      child: SingleChildScrollView(
                    controller: macroRecordingScrollController,
                    child: Column(
                      children: _recordedKeys
                          .map((e) => Text(
                                "Key: ${e["keyLabel"]} Code: ${e["code"]} Event: ${e["event"]}",
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
                            // invoking the macro
                            for (var macro in testMacroRecording) {
                              final result =
                                  await _keyboardInvokerPlugin.invokeKey(macro);
                              if (!result) {
                                print("Error invoking macro");
                                break;
                              }
                            }
                          },
                          child: const Text("Test Macro (bratwurst)")),
                      // modifier test button (shift hold and release)
                      ElevatedButton(
                          onPressed: () async {
                            // focusing the text field
                            _focusNode.requestFocus();
                            // hold down the shift key before invoking the macro
                            bool shiftModifier = await _keyboardInvokerPlugin
                                .holdKey(LogicalKeyboardKey.shiftRight.keyId);
                            // invoking the macro
                            if (shiftModifier == false) {
                              print("Error holding down shift key");
                              return;
                            } else {
                              print("Holding down shift key");
                            }
                            for (var macro in testMacroRecording) {
                              final result =
                                  await _keyboardInvokerPlugin.invokeKey(macro);
                              if (!result) {
                                print("Error invoking macro");
                                break;
                              }
                            }
                            // releasing the shift key after invoking the macro
                            await _keyboardInvokerPlugin.releaseKey(
                                LogicalKeyboardKey.shiftRight.keyId);
                          },
                          child: const Text("Test Macro (bratwurst)(shift)"))
                    ],
                  ),

                  // macro recording buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: _isRecording
                              ? () {
                                  // stop recording
                                  stopRecording();
                                }
                              : () {
                                  // start recording
                                  startRecording();
                                },
                          child: _isRecording
                              ? const Text("stop Macro Recording")
                              : const Text("Start Macro Recording")),
                      ElevatedButton(
                          onPressed: () {
                            // clear the recorded keys
                            setState(() {
                              _recordedKeys = [];
                            });
                          },
                          child: const Text("Clear Recorded Macro")),
                      ElevatedButton(
                          onPressed: () {
                            // focusing the text field
                            _focusNode.requestFocus();
                            // start recording
                            //stopRecording();
                            // invoke the recorded macro
                            for (var macro in _recordedKeys) {
                              if (macro["event"] == KeyType.keyDown) {
                                _keyboardInvokerPlugin.holdKey(macro["code"]);
                              } else if (macro["event"] == KeyType.keyUp) {
                                _keyboardInvokerPlugin
                                    .releaseKey(macro["code"]);
                              } else if (macro["event"] == KeyType.keyInvoke) {
                                _keyboardInvokerPlugin.invokeKey(macro["code"]);
                              }
                            }
                          },
                          child: const Text("Invoke Recorded Macro")),
                    ],
                  )
                ],
              ))),
    );
  }
}
