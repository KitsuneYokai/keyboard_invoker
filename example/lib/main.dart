import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:keyboard_invoker/keyboard_invoker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _keyboardInvokerPlugin = KeyboardInvoker();
  late FocusNode _focusNode;

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
  List macroRecording = [
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text('Keyboard_invoker example'),
          ),
          body: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text('Running on: $_platformVersion\n'),
                  ),
                  TextField(
                    focusNode: _focusNode,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'TextField',
                    ),
                  ),
                  // macro test button
                  ElevatedButton(
                      onPressed: () async {
                        // focusing the text field
                        _focusNode.requestFocus();
                        // invoking the macro
                        for (var macro in macroRecording) {
                          final result =
                              await _keyboardInvokerPlugin.invokeKey(macro);
                          if (!result) {
                            print("Error invoking macro");
                            break;
                          }
                        }
                      },
                      child: const Text("invoke macro")),
                  // modifier test button (shift hold and release)
                  ElevatedButton(
                      onPressed: () async {
                        // focusing the text field
                        _focusNode.requestFocus();
                        // hold down the shift key before invoking the macro
                        await _keyboardInvokerPlugin
                            .holdKey(LogicalKeyboardKey.shift.keyId);
                        // invoking the macro
                        for (var macro in macroRecording) {
                          final result =
                              await _keyboardInvokerPlugin.invokeKey(macro);
                          if (!result) {
                            print("Error invoking macro");
                            break;
                          }
                        }
                        // releasing the shift key after invoking the macro
                        await _keyboardInvokerPlugin
                            .releaseKey(LogicalKeyboardKey.shift.keyId);
                      },
                      child: const Text("Test modifier (shift)"))
                ],
              ))),
    );
  }
}
