import 'package:flutter/material.dart';
import '../Forgetpass.dart';
import '../navscreen.dart';
import 'signup.dart';
import 'auth_utils.dart';
import '../home.dart'; 
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override

  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
 
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  final secureStorage = FlutterSecureStorage();
 
 
 Future<void> saveUserId(String userId) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', userId);
}
  Future<void> _signIn(BuildContext context) async {
  if (!_formKey.currentState!.validate()) {
    return;
  }

  const String apiUrl = 'https://flask-signup.vercel.app/users.signin'; // API endpoint for signin

  final Map<String, dynamic> data = {
    'phone_number': phoneNumberController.text, // User's phone number
    'password': passwordController.text, // User's password
  };

  final response = await http.post(
    Uri.parse(apiUrl),
    body: json.encode(data),
    headers: {'Content-Type': 'application/json'},
  );

  if (response.statusCode == 200) {
    final responseBody = json.decode(response.body);
    if (responseBody['token'] != null) {
      await secureStorage.write(key: 'jwt_token', value: responseBody['token']);
      final storedToken = await secureStorage.read(key: 'jwt_token');
      print('Stored JWT Token: $storedToken');

      // Extract and validate the user ID
      final userId = responseBody['id'];
      if (userId != null) {
  if (userId is int) {
    await saveUserId(userId.toString()); // Convert int to String before saving
  } else if (userId is String) {
    await saveUserId(userId);
  } else {
    print('User ID is not an int or String');
    _showSnackBar(context, 'Signin failed. User ID format is not recognized.');
    return;
  }}

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NavigationScreen()),
      );

      _showSnackBar(context, 'Signin successful');
      
    } else {
      _showSnackBar(context, 'Signin failed. No token received.');
    }
  } else {
    _showSnackBar(context, 'Signin failed. Please try again.');
  }
}

void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}


  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 39),
                Align(
                 alignment: Alignment.center,

                 child :Container(
                  height: 126,
                  width: 158,
                  child: Image.asset(
                      'assets/images/signin.png'), // Replace with the actual image path
                ),
                ),
                SizedBox(height: 14),
               Align(
                    alignment: Alignment.center,
                    child: Text(
                      "MediHub",
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black, // Midnight Blue

                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Rent, donate, review and share",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(height: 43),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: TextFormField(
                    controller: phoneNumberController,
                    decoration: InputDecoration(
                      hintText: "Phone Number",
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 15,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                  ),
                ),
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(left: 1, right: 7),
                  child: TextFormField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      hintText: "Password",
                      contentPadding:
                          EdgeInsets.only(left: 19, top: 15, bottom: 15),
                    ),
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    onFieldSubmitted: (_) {
                      // Handle login logic here
                    },
                  ),
                ),
                SizedBox(height: 22),
                ElevatedButton(
  onPressed: () async {
    await _signIn(context); // Correctly calling the _signIn function
  },
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xe52f8dfb),
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                SizedBox(height: 10),

                GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AndroidSmallFiveScreen(),
                  ),
                );
              },
              
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Forget Password?",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
                            SizedBox(height: 10),

              Padding(
                padding: EdgeInsets.only(left: 90.0),
                child: SignInButton(
                  Buttons.Google,
                  text: "Continue with Google",
                  onPressed: () {
                    Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ),
                );
                  
                  },
                ),
              ),
                SizedBox(height: 70),
               // Inside the build() method of AndroidSmallOneScreen class
SizedBox(height: 25.0),
Align(
  alignment: Alignment.centerRight,
  child: Padding(
    padding: EdgeInsets.only(right: 88.0),
    child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignUp()),
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Haven’t account please",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 12.0),
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    ),
  ),
),
              ],
            ),
          ),
        ),
      ),
    );
  }
  
}
