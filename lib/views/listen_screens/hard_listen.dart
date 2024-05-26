import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../constants/listen_texts/hard.dart' as hardText;

class SpeechScreenHard extends StatefulWidget {
  @override
  _SpeechScreenHardState createState() => _SpeechScreenHardState();
}

class _SpeechScreenHardState extends State<SpeechScreenHard> {
  FlutterTts flutterTts = FlutterTts();
  List<String> lines = hardText.vehiclePollutantsText
      .split('\n')
      .where((line) => line.trim().isNotEmpty)
      .toList();

  Future<void> _speak(String text) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LEVEL: Difficult', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade600,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: lines.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _speak(lines[index]),
            child: Container(
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.red.shade400,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                lines[index],
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}
