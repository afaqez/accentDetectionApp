import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:accent_detection_app/models/user.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  UserModel?
      _currentUser; // Declare a nullable variable to hold the current user data

  @override
  void initState() {
    super.initState();
    _getCurrentUser(); // Call method to get current user data when the screen initializes
  }

  Future<void> _getCurrentUser() async {
    // Get the current user's email address
    String? email = FirebaseAuth.instance.currentUser?.email;

    if (email != null) {
      // Query the Firestore collection 'users' for the document with the matching email
      var userQuery =
          await _db.collection('users').where('email', isEqualTo: email).get();

      if (userQuery.docs.isNotEmpty) {
        // Get the first document from the query result
        var userDoc = userQuery.docs.first;

        // Access the document data
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        setState(() {
          // Update the current user data
          _currentUser = UserModel(
            id: userDoc.id,
            firstName: userData['firstName'] ?? '',
            lastName: userData['lastName'] ?? '',
            email: userData['email'] ?? '',
            password: userData['password'] ?? '',
          );

          // Update the text controllers with current user data
          _firstNameController.text = _currentUser!.firstName;
          _lastNameController.text = _currentUser!.lastName;
          _emailController.text = _currentUser!.email;
          _passwordController.text = _currentUser!.password;
        });
      } else {
        throw Exception("User document does not exist");
      }
    } else {
      throw Exception("User email is null");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
      ),
      backgroundColor: Colors.lightBlue[100],
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Edit Your Profile',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              SizedBox(height: 18),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: Text('Save Changes'),
                onPressed: () {
                  _updateProfile(); // Call method to update the user profile
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      // Validate the form
      if (_currentUser != null) {
        // Check if _currentUser is not null
        UserModel updatedUser = UserModel(
          id: _currentUser!.id,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          email: _emailController.text,
          password: _passwordController.text,
        );

        // Update the user data in Firestore
        try {
          await _db.collection('users').doc(_currentUser!.id).update(
                updatedUser.toJson(),
              );

          // Show a success dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Success'),
                content: Text('Your profile has been updated!'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } catch (error) {
          // Show an error dialog if update fails
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Error'),
                content:
                    Text('Failed to update profile. Please try again later.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }
}
