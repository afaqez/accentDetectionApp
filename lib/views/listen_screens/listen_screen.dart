import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:accent_detection_app/views/listen_screens/listen_exercise_screen.dart';
import 'package:accent_detection_app/views/user_authentication/login_page.dart';
import 'package:accent_detection_app/views/listen_screens/create_your_own_exercise_screen.dart';

class basicTTS extends StatelessWidget {
  const basicTTS({Key? key}) : super(key: key);

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
                                Scaffold.of(context)
                                    .openDrawer(); // Open the drawer
                              },
                              child: Icon(
                                Icons.sort,
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
                              " Listen ",
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
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          if (index == 0) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TTSManager(),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ListenExerciseLevel(),
                              ),
                            );
                          }
                        },
                        child: Container(
                          margin:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 40),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.blue.shade300,
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
                              Text(
                                index == 0
                                    ? ' Create Own Exercise '
                                    : 'Listen Exercises',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
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
