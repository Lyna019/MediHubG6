import 'package:flutter/material.dart';
import '../Forgetpass.dart';
import 'signup.dart';
import '../home.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';





class SigninScreen extends StatefulWidget {
  SigninScreen({Key? key}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final supabase = Supabase.instance.client;

  @override
  void initState() {
    super.initState();
    _setupAuthListener();
  }

  void _setupAuthListener() {
    supabase.auth.onAuthStateChange.listen((data) {
      final event = data.event;
      if (event == AuthChangeEvent.signedIn) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    
     
   
  

    TextEditingController phoneNumberController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    // Assuming you have TextEditingController for phone number and password
    String phoneNumber = phoneNumberController.text;
    String password = passwordController.text;

    // Validate inputs
    if (phoneNumber.isEmpty || password.isEmpty) {
      _showSnackBar(context, 'Fields can\'t be empty');
      return;
    }

    // Add phone number validation logic if needed

    // Making an HTTP POST request to the backend
    var response = await http.post(
      Uri.parse('http://10.0.2.2:5000/users.signin'), // Replace with your actual backend URL
      body: {
        'phone_number': phoneNumber,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      // Handle successful login
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showSnackBar(context, 'Signin failed. Please try again.');
    }
  },
                  child:Text(
              'Sign Up',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xe52f8dfb),
                    minimumSize: Size(double.infinity, 48),
                    shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),

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
                  _googleSignIn();
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
  void _showSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
    content: Text(message),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<AuthResponse> _googleSignIn() async {
    /// TODO: update the Web client ID with your own.
    ///
    /// Web Client ID that you registered with Google Cloud.
    const webClientId = '235504955269-2e13it3hb9fv0sse0lk0denqj71i9cqm.apps.googleusercontent.com';
    const iosClientId = '235504955269-79eup1rptd533fk72i67pcmhdp4niko4.apps.googleusercontent.com';


   

    
    final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: iosClientId,
    serverClientId: webClientId,
  );
  final googleUser = await googleSignIn.signIn();
  final googleAuth = await googleUser!.authentication;
  final accessToken = googleAuth.accessToken;
  final idToken = googleAuth.idToken;

  if (accessToken == null) {
    throw 'No Access Token found.';
  }
  if (idToken == null) {
    throw 'No ID Token found.';
  }

  // Correct the provider reference based on your package or implementation
  return supabase.auth.signInWithIdToken(
    provider: Provider.google, // This is a placeholder. Replace with the correct reference.
    idToken: idToken,
    accessToken: accessToken,
  );
}



} 


