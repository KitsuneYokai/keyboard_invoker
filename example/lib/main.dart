import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:keyboard_invoker/keyboard_invoker.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Keyboard Invoker Demo',
      theme: ThemeData.dark(),
      home: ChangeNotifierProvider<KeyboardInvoker>(
        create: (context) => KeyboardInvoker(),
        child: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This is a List of KeyRecording objects that represent the sequence of keys
  // In this case, it will type "Hello world"
  final List<KeyRecording> _demoSequence = [
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyDown),
    KeyMap.keyH.keyRecording(),
    KeyMap.shiftLeft.keyRecording(keyEventType: KeyEventType.keyUp),
    KeyMap.keyE.keyRecording(),
    KeyMap.keyL.keyRecording(),
    KeyMap.keyL.keyRecording(),
    KeyMap.keyO.keyRecording(),
    KeyMap.space.keyRecording(),
    KeyMap.keyW.keyRecording(),
    KeyMap.keyO.keyRecording(),
    KeyMap.keyR.keyRecording(),
    KeyMap.keyL.keyRecording(),
    KeyMap.keyD.keyRecording(),
  ];

  // This bool is used to force the Num Lock state to be ON or OFF, it can be null
  // in this case the current os state will be used
  bool? _forceNumState;

  // This double is used to set the delay before invoking the keys
  double _sliderValue = 3.0;

  @override
  Widget build(BuildContext context) {
    // Lets define the callback functions
    final KeyboardInvoker keyboardInvoker =
        Provider.of<KeyboardInvoker>(context);

    // This function shows an error dialog
    void showError(BuildContext context, dynamic error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(error.toString()),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    // Callback functions
    // This function toggles if a delay should be recorded
    void toggleRecordDelay(bool value) {
      keyboardInvoker.recorder.includeDelays = value;
    }

    // This function clears a recording
    void clearRecording() {
      keyboardInvoker.recorder.clearRecording();
    }

    // This function invokes the recorded keys on the host os
    void invokeRecording() async {
      // Lets play the recording, with the delay set by the slider
      // we also force the Num Lock state if needed, this can be useful
      // when the Num Lock is switched off but is needed to be on or vice versa
      try {
        // Delay before invoking the keys
        await Future.delayed(Duration(seconds: _sliderValue.round()));

        // Invoke the recording
        await keyboardInvoker.recorder
            .invokeRecording(forceNumState: _forceNumState);
      } catch (e) {
        // if we have an error we show an error dialog
        showError(context, e);
      }
    }

    // This function invokes the _demoSequence KeyRecording objects on the host os
    void invokeDemoSequence() async {
      try {
        await Future.delayed(Duration(seconds: _sliderValue.round()));
        await keyboardInvoker.invokeKeys(_demoSequence,
            forceNumState: _forceNumState);

        // If the host os is windows we draw an ascii hart ♥
        if (Platform.isWindows) {
          await keyboardInvoker.invokeKeys([
            KeyMap.altLeft.keyRecording(keyEventType: KeyEventType.keyDown),
            KeyMap.numpad3.keyRecording(),
            KeyMap.altLeft.keyRecording(keyEventType: KeyEventType.keyUp),
          ], forceNumState: true);
        }
      } catch (e) {
        // if we have an error we show an error dialog
        showError(context, e);
      }
    }

    // This function gets the current Num Lock state and shows it in a dialog
    void getCurrentNumLockState() async {
      try {
        final numLockState = await keyboardInvoker.checkNumLockState();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Num Lock State'),
            content: Text('Num Lock is ${numLockState ? 'ON' : 'OFF'}'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } catch (e) {
        showError(context, e);
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Keyboard Invoker Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Recording status
            Card(
              child: Column(children: [
                ListTile(
                  title: Text("Record Delay"),
                  trailing: Switch(
                    value: keyboardInvoker.recorder.includeDelays,
                    onChanged: (value) {
                      toggleRecordDelay(value);
                    },
                  ),
                ),
                ListTile(
                  title: Text("Force Num Lock State"),
                  trailing: DropdownButton<bool>(
                    value: _forceNumState,
                    onChanged: (value) {
                      // This will force the Num Lock state to be ON or OFF
                      // before invoking the keys, it can be useful when the
                      // Num Lock is switched, off, but is needed to be on or vice versa
                      setState(() => _forceNumState = value);
                    },
                    items: [
                      DropdownMenuItem(
                        value: null,
                        child: const Text('Default'),
                      ),
                      DropdownMenuItem(
                        value: true,
                        child: const Text('Force ON'),
                      ),
                      DropdownMenuItem(
                        value: false,
                        child: const Text('Force OFF'),
                      ),
                    ],
                  ),
                ),
                ListTile(
                    title: Text(
                        "Delay before invoking keys: $_sliderValue seconds")),
                ListTile(
                  title: Slider(
                    value: _sliderValue,
                    min: 0,
                    max: 10,
                    divisions: 10,
                    onChanged: (value) {
                      setState(() => _sliderValue = value);
                    },
                  ),
                ),
              ]),
            ),
            const SizedBox(height: 10),

            // Control buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  alignment: WrapAlignment.center,
                  children: [
                    Tooltip(
                      message: keyboardInvoker.recorder.isRecording
                          ? 'Stop Recording'
                          : 'Start Recording',
                      child: ElevatedButton(
                        onPressed: () {
                          // Start or stop the recording depending on the current state
                          // of the recorder
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
                      ),
                    ),
                    Tooltip(
                      message: 'Clear Recording',
                      child: ElevatedButton(
                        onPressed: () => clearRecording(),
                        child: const Icon(Icons.clear),
                      ),
                    ),
                    Tooltip(
                      message: 'Play Recording',
                      child: ElevatedButton(
                        onPressed: () async {
                          invokeRecording();
                        },
                        child: const Icon(Icons.play_arrow),
                      ),
                    ),
                    Tooltip(
                      message: 'Play Demo Sequence',
                      child: ElevatedButton(
                        onPressed: () async {
                          invokeDemoSequence();
                        },
                        child: const Icon(Icons.playlist_play),
                      ),
                    ),
                    Tooltip(
                      message: 'Get current Num Lock State',
                      child: ElevatedButton(
                        onPressed: () async {
                          getCurrentNumLockState();
                        },
                        child: const Icon(Icons.keyboard),
                      ),
                    )
                  ],
                ),
              ),
            ),

            const Text("Recorded Keys", style: TextStyle(fontSize: 20)),
            // Recorded keys display
            Expanded(
              child: Card(
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: keyboardInvoker.recorder.recordedKeys.length,
                  itemBuilder: (context, index) {
                    final key = keyboardInvoker.recorder.recordedKeys[index];
                    return ListTile(
                      title: Text('Key: ${key.logicalKeyId?.keyLabel}'),
                      subtitle: Text(
                          'Event: ${key.keyEventType} - Delay: ${key.delay}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
