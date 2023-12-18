import 'package:flutter/material.dart';
import 'resetpass.dart';
class AndroidSmallFiveScreen extends StatelessWidget {
  AndroidSmallFiveScreen({Key? key}) : super(key: key);

  TextEditingController phoneNumberController = TextEditingController();
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
            padding: EdgeInsets.only(left: 16, top: 39, right: 16),
            child: Column(
              children: [
                Container(
                  width: 271,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: 
                  Center(
                    child:Text(
                    "Forget password",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    )
                    ),
                  ),
                ),
                SizedBox(height: 30),

                Image(image: AssetImage('assets/images/reset.webp'),
                width: 350,
                height: 250,),
                Padding(
                  padding: EdgeInsets.symmetric( horizontal: 14,
                      vertical: 1,) ,
                  child:
                Text("Please Enter Your Phone Number To Recieve a \n Verification Code",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w500), textAlign: TextAlign.center,
),
                ),
                SizedBox(height: 15),
                TextFormField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    hintText: "Enter Your Phone Number",
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 15,
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                ),
                SizedBox(height: 160),
                ElevatedButton(
                  onPressed: () {
                    // Handle continue logic here
                    onTapContinue(context);
                  },
                  child:Text(
              'Continue',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48), backgroundColor: Colors.blue,
                                        shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),

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

  void onTapContinue(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AndroidSmallSixScreen(),
      ),
    );
  }
}

class AndroidSmallSixScreen extends StatelessWidget {
  AndroidSmallSixScreen({Key? key}) : super(key: key);

  TextEditingController textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(left: 16, top: 39, right: 16),
          child: Column(
            children: [
               Container(
                  width: 271,
                  margin: EdgeInsets.symmetric(horizontal: 8),
                  child: 
                  Center(
                    child:Text(
                    "Forget password",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    )
                    ),
                  ),
                ),
                  SizedBox(height: 30),

                Image(image: AssetImage('assets/images/forgot-password-concept-illustration_114360-1123.jpg'),
                width: 350,
                height: 250,),
              SizedBox(height: 30),
              TextFormField(
                controller: textFieldController,
                decoration: InputDecoration(
                  hintText: "Enter The Code You Receive",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 15,
                  ),
                ),
                textInputAction: TextInputAction.done,
              ),
              SizedBox(height: 199),
             ElevatedButton(
              onPressed: () {
               Navigator.push(
               context,
               MaterialPageRoute(builder: (context) => AndroidSmallSevenScreen()),
                 );
                  },
                child:Text(
              'Continue',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
                style: ElevatedButton.styleFrom(
                 minimumSize: Size(double.infinity, 48), backgroundColor: Colors.blue,
                                      shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(30)),

  ),
),
              SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

