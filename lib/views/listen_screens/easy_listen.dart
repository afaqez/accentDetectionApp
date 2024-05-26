import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../constants/listen_texts/easy.dart' as easyText;

class SpeechScreenEasy extends StatefulWidget {
  @override
  _SpeechScreenEasyState createState() => _SpeechScreenEasyState();
}

class _SpeechScreenEasyState extends State<SpeechScreenEasy> {
  FlutterTts flutterTts = FlutterTts();
  List<String> lines = easyText.longTermWarmingText
      .split('\n')
      .where((line) => line.isNotEmpty)
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
        title: Text('LEVEL: EASY', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.lightGreen,
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
                color: Colors.lightGreenAccent.shade100,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                lines[index],
                style:
                    TextStyle(fontSize: 18, color: Colors.lightGreen.shade800),
              ),
            ),
          );
        },
      ),
    );
  }
}
