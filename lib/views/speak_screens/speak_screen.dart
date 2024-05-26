import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class STText extends StatefulWidget {
  @override
  _TTSpeechState createState() => _TTSpeechState();
}

class _TTSpeechState extends State<STText> {
  User get user => FirebaseAuth.instance.currentUser!;
  String get userId => user.uid;

  bool isClicked = false;
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  String? _filePath;

  @override
  void initState() {
    super.initState();
    _recorder = FlutterSoundRecorder();
    _recorder!.openRecorder();
  }

  @override
  void dispose() {
    _recorder!.closeRecorder();
    super.dispose();
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.microphone.status;
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.microphone].request();
      return permissionStatus[Permission.microphone] ?? PermissionStatus.denied;
    } else {
      return permission;
    }
  }

  Future<void> _startRecording() async {
    final PermissionStatus permissionStatus = await _getPermission();
    if (permissionStatus != PermissionStatus.granted) {
      // Handle case where permission is not granted
      return;
    }

    Directory tempDir = await getTemporaryDirectory();
    String tempPath = '${tempDir.path}/temp_audio.aac';

    setState(() {
      _filePath = tempPath;
      _isRecording = true;
    });

    await _recorder!.startRecorder(toFile: tempPath);
  }

  Future<void> _stopRecording() async {
    await _recorder!.stopRecorder();
    setState(() {
      _isRecording = false;
    });
  }

  Future<String> _uploadRecording() async {
    String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    Reference ref =
        FirebaseStorage.instance.ref().child('$userId/$timestamp.aac');

    await ref.putFile(File(_filePath!));

    return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.purple.shade200,
          child: Column(
            children: [
              Container(
                height: height * 0.25,
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 35,
                        left: 20,
                        right: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 30,
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.purple.shade200,
                              // Add your user profile image here
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 20,
                        left: 30,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            " Speech to Text  ",
                            style: TextStyle(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "  TTS    &   STT",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white54,
                              letterSpacing: 1,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                color: Colors.white,
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          isClicked = !isClicked;
                        });
                        if (_isRecording) {
                          await _stopRecording();
                          String downloadUrl = await _uploadRecording();
                          print("Download URL: $downloadUrl");
                        } else {
                          await _startRecording();
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 1000),
                        padding: EdgeInsets.all(isClicked ? 50 : 25),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors
                              .purple.shade200, // Change the color as needed
                        ),
                        child: Icon(
                          Icons.mic_none_sharp,
                          size: isClicked ? 80 : 40,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    TextFormField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText:
                            'The text is .......', // Add your hint text here
                        fillColor: Colors.purple.shade100.withOpacity(0.5),
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
