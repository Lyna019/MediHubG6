import 'package:flutter/material.dart';
import '../navscreen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:ui'; // Import for ImageFilter
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'signin.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController userProfileController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Form key for validation

  Future<void> _signUp(BuildContext context) async {
    if (!_formKey.currentState!.validate()) {
      // Check if the form is valid
      return;
    }

    const  String apiUrl = 'https://flask-signup.vercel.app/users.signup'; // Ensure correct API endpoint

    final Map<String, dynamic> data = {
      'name': userProfileController.text, // Corrected keys
      'phone_number': phoneNumberController.text,
      'password': passwordController.text,
    };
    void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: json.encode(data),
        headers: {'Content-Type': 'application/json'},
        
        
      );

      if (response.statusCode == 201) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavigationScreen()), // Replace with your HomeScreen
        );
        _showSnackBar(context, 'Signup successful');
      } else {
        print('Failed to sign up with status code: ${response.statusCode}');
        print('Response body: ${response.body}');
        _showSnackBar(context, 'Signup failed. Please try again.');
      }
    } catch (e) {
      _showSnackBar(context, 'Error: ${e.toString()}');
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            // Background and other UI elements...

            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(1.0, 150.0, 1.0, 0),
                child: Form(
                  key: _formKey,
                  child: Container(
                    // Container settings...
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.0),
                        _buildUserProfile(context),
                        SizedBox(height: 20.0),
                        _buildPhoneNumber(context),
                        SizedBox(height: 20.0),
                        _buildPassword(context),
                        SizedBox(height: 20.0),
                        _buildConfirmPassword(context),
                        SizedBox(height: 40.0),
                        _buildSignUp(context),
                        SizedBox(height: 20.0),
                        CustomDivider(),
                        Padding(
              padding: EdgeInsets.only(left: 90.0),
              child: SignInButton(
               Buttons.Google,
             text: "Sign up with Google",
              onPressed: () {
      // Handle sign-in with Google
              },
             ),
),
SizedBox(height: 100.0),
                     Padding(
  padding: EdgeInsets.only(left: 40.0),
  child: Row(
    children: [
      Text(
        "    Already have an account?",
        style: TextStyle(fontSize: 15.0),
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SigninScreen()),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: const Color.fromARGB(255, 82, 162, 228),
            ),
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
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget methods like _buildUserProfile, _buildPhoneNumber, etc...
  Widget _buildUserProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: userProfileController,
        decoration: InputDecoration(
          hintText: "Full Name",
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhoneNumber(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: phoneNumberController,
        decoration: InputDecoration(
          hintText: "Phone Number",
        ),
        keyboardType: TextInputType.phone,
        validator: (value) {
          final phoneRegex = r'^\d{10}$';
          if (value == null || value.isEmpty) {
            return 'Phone number is required';
          } else if (!RegExp(phoneRegex).hasMatch(value)) {
            return 'Invalid phone number';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
          hintText: "Password",
        ),
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a password';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildConfirmPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
        controller: confirmPasswordController,
        decoration: InputDecoration(
          hintText: "Confirm Password",
        ),
        obscureText: true,
        validator: (value) {
          if (value != passwordController.text) {
            return 'Passwords do not match';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        onPressed: () {
          _signUp(context);
        },
        child: Text(
          'Sign up',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF3CF6B5),
          minimumSize: Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }}

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            height: 1,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            ' OR ',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            height: 1,
          ),
        ),
      ],
    );
  }
}

