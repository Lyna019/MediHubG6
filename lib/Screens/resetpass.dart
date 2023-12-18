import 'package:flutter/material.dart';
import 'package:medihub_1/Screens/home.dart';

class AndroidSmallSevenScreen extends StatelessWidget {
  AndroidSmallSevenScreen({Key? key}) : super(key: key);

  TextEditingController newpasswordController = TextEditingController();
  TextEditingController newpasswordController1 = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _formKey,
          child: Container(
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 15, top: 10, right: 15),
            child: Column(
              children: [
                _buildResetPasswordSection(context),
                SizedBox(height: 20),
                TextFormField(
                  controller: newpasswordController1,
                  decoration: InputDecoration(
                    hintText: "Confirm The New Password",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 15,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                ),
                SizedBox(height: 234),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => HomeScreen(),
    ),
  );
                  },
                  child:Text(
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
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
                SizedBox(height: 5),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResetPasswordSection(BuildContext context) {
    return SizedBox(
      height: 320,
      width: 368,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 285,
            height: 50,
            child: Center(
              child: Text(
                "Reset password",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Image(
            image: AssetImage('assets/images/reset2.webp'),
            width: 350,
            height: 180,
          ),
          SizedBox(height: 20),
          Container(
            width: 368,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: TextFormField(
              controller: newpasswordController,
              decoration: InputDecoration(
                hintText: "Enter The New Password",
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 12,
                ),
              ),
              obscureText: true,
            ),
          ),
        ],
      ),
    );
  }
}
