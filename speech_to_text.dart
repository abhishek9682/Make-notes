import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'note_model.dart';

class Note extends StatefulWidget {
  final List<NoteModel> notes;
  const Note({super.key, required this.notes});
  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(
      onResult: _onSpeechResult,
      listenFor: const Duration(minutes: 10), // long duration
      pauseFor: const Duration(seconds: 50),   // silence tolerance
      partialResults: true,
      listenMode: ListenMode.dictation,       // continuous mode
    );
    setState(() {});
  }


  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(
      //     "🎤 Voice Notes",
      //     style: TextStyle(fontSize: 20, color: Colors.deepOrangeAccent),
      //   ),
      //   centerTitle: true,
      //   backgroundColor: Colors.cyanAccent,
      // ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(15)
                  ),
                  child: Center(
                    child: Text(
                      "🎤 Voice Notes",
                      style: TextStyle(fontSize: 35, color: Colors.deepOrangeAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50,),
              // Microphone button with glowing effect
              GestureDetector(
                onTap: () {
                  if (!_speechToText.isListening) {
                    _startListening();
                  } else {
                    _stopListening();
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      if (_speechToText.isListening)
                        BoxShadow(
                          color: Colors.redAccent.withOpacity(0.6),
                          blurRadius: 40,
                          spreadRadius: 10,
                        ),
                    ],
                    gradient: const LinearGradient(
                      colors: [Colors.deepOrange, Colors.orangeAccent],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: const Icon(
                    Icons.mic,
                    size: 80,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // Status text
              Text(
                _speechToText.isListening
                    ? "Listening..."
                    : _speechEnabled
                    ? "Tap the mic to start"
                    : "Speech not available",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),

              const SizedBox(height: 30),

              // Result box with glassmorphism
              Container(
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.symmetric(horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.white.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Text(
                  _lastWords.isEmpty
                      ? '🎙️ Your speech will appear here...'
                      : _lastWords,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}