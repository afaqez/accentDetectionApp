import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../../constants/listen_texts/medium.dart' as mediumText;

class SpeechScreenMedium extends StatefulWidget {
  @override
  _SpeechScreenEasyState createState() => _SpeechScreenEasyState();
}

class _SpeechScreenEasyState extends State<SpeechScreenMedium> {
  FlutterTts flutterTts = FlutterTts();
  List<String> lines = mediumText.deforestationText
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
        title:
            Text('LEVEL:INTERMEDIATE ', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue.shade600,
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
                color: Colors.blue.shade300,
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
