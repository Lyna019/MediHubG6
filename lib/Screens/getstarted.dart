import 'package:flutter/material.dart';
import 'package:medihub_1/Screens/users/signup.dart';
import '../color/colors.dart';
class getstarted extends StatelessWidget {
  const getstarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(color: Colors.white),
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 49,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/getstart.png'),
                height: 300,
                width: 300,
              ),
              SizedBox(height: 4),
              Container(
                width: 315,
                margin: EdgeInsets.only(
                  left: 8,
                  right: 7,
                ),
                child: Center(
                  child: Text(
                    "Find And Rent Medical Equipments",
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontFamily:"Montserrat",
                      fontSize: 25,
                      color:midnightcolor
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6),
              Container(
                width: 325,
                margin: EdgeInsets.only(left: 7),
                child: Text(
                  "Discover a wide range of medical \nequipment available for rent. Easily\nfind the equipment you need and connect ",
                  maxLines: 4,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 15,fontFamily:"Montserrat"),
                ),
              ),
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => SignUp()),
          );
        // Handle sign up button press
      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: midnightcolor,
                  padding: EdgeInsets.symmetric(horizontal: 110, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child:Text(
              'Get Started',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
             
    ),
        
            ],
          ),
        ),
      ),
    );
  }

 
}