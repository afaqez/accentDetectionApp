import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:accent_detection_app/views/listen_screens/easy_listen.dart';
import 'package:accent_detection_app/views/listen_screens/hard_listen.dart';
import 'package:accent_detection_app/views/user_authentication/login_page.dart';
import 'package:accent_detection_app/views/listen_screens/mediumlisten.dart';

class ListenExerciseLevel extends StatelessWidget {
  const ListenExerciseLevel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Builder(
        builder: (BuildContext context) => SingleChildScrollView(
          child: Container(
            color: Colors.blue,
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
                            InkWell(
                              onTap: () {
                                Scaffold.of(context).openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.blue,
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
                              " Listening Exercise ",
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
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  height: height * 0.75,
                  width: width,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 2.9,
                      mainAxisSpacing: 65,
                      crossAxisSpacing: 20,
                    ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: 3, // Change itemCount to 3
                    itemBuilder: (context, index) {
                      String cardText = '';
                      IconData iconData;
                      Color cardColor;
                      if (index == 0) {
                        cardText = 'Easy';
                        iconData = Icons.lightbulb_outline;
                        cardColor = Colors.green.shade300;
                      } else if (index == 1) {
                        cardText = 'Intermediate';
                        iconData = Icons.school_outlined;
                        cardColor = Colors.blue.shade300;
                      } else {
                        cardText = 'Difficult';
                        iconData = Icons.warning_amber_outlined;
                        cardColor = Colors.red.shade300;
                      }
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SpeechScreenEasy()),
                            );
                          } else if (index == 1) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpeechScreenMedium(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SpeechScreenHard(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: cardColor,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black26,
                                spreadRadius: 7,
                                blurRadius: 14,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                iconData,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                cardText,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              title: const Text('Contact Us '),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle privacy action
              },
            ),
            Divider(
              // Add this Divider widget
              color: Colors.blue,
              height: 1, // Adjust the height as needed
              thickness: 3, // Adjust the thickness as needed
            ),
            ListTile(
              title: const Text('Share '),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle my account action
              },
            ),
            Divider(
              // Another Divider for separation
              color: Colors.blue,
              height: 1,
              thickness: 3,
            ),
            ListTile(
              title: const Text('Rate '),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle edit action
              },
            ),
            Divider(
              // Another Divider for separation
              color: Colors.blue,
              height: 1,
              thickness: 3,
            ),
            ListTile(
              title: const Text('Privacy Policy  '),
              onTap: () {
                Navigator.pop(context); // Close the drawer
                // Handle edit action
              },
            ),
            Divider(
              // Another Divider for separation
              color: Colors.blue,
              height: 1,
              thickness: 3,
            ),
            ListTile(
              title: const Text('Sign Out '),
              onTap: () {
                _signOut(context); // Call sign out method
              },
            ),
            Divider(
              // Another Divider for separation
              color: Colors.blue,
              height: 1,
              thickness: 3,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } catch (e) {
      // Handle sign out errors
      print('Error signing out: $e');
      // You can show a snackbar or dialog to inform the user about the error
    }
  }
}

/*void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}*/
