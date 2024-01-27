import 'package:flutter/material.dart';
import 'package:medihub_1/Screens/AddProduct.dart';
import 'package:medihub_1/Screens/Updateinfo.dart';
import 'package:medihub_1/Screens/setting.dart';
import 'package:medihub_1/Screens/settings.dart';
import 'package:medihub_1/Screens/My list/MyProducts.dart';
import 'package:medihub_1/color/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> getUserId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('id'); // Returns null if 'userId' is not set
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/lg.jpg'), // Replace with your image asset
            ),
            SizedBox(height: 16.0),
            Text(
              'Username',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 36.0),
            ShadowedBox(
                textColor: midnightcolor, // Set text color to red
  iconColor: midnightcolor,
              text: 'Update personal information',
              onPressed: () {
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdatePersonalInfoPage(), // Change 1 to the correct index for Mobility Aids
      ),
    );              },
              icon: Icons.person,
            ),
            SizedBox(height: 20.0),
            ShadowedBox(
                textColor: midnightcolor, // Set text color to red
  iconColor: midnightcolor,
              text: 'Add my product',
              onPressed: () {
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(), // Change 1 to the correct index for Mobility Aids
      ),
    );              },
              icon: Icons.add_box,
            ),
            SizedBox(height: 20.0),
            ShadowedBox(
                textColor: midnightcolor, // Set text color to red
  iconColor: midnightcolor,
              text: 'My Products',
              onPressed: () async {
  String? userIdString = await getUserId();

  if (userIdString != null) {
    int userId = int.parse(userIdString);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MyProducts(userId: userId),
      ),
    );
  } else {
    // Handle the case where userId is null (e.g., show an error or navigate to login)
  }
},
              icon: Icons.favorite,
            ),
            SizedBox(height: 20.0),
            ShadowedBox(
              textColor: midnightcolor, // Set text color to red
  iconColor: midnightcolor,

              text: 'Settings',
              onPressed: () {
Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsPage(), // Change 1 to the correct index for Mobility Aids
      ),
    );              },
              icon: Icons.settings,
            ),
            SizedBox(height: 20.0),
          ShadowedBox(
  text: 'Logout',
  onPressed: () {
    _showLogoutConfirmationDialog(context);
  },
  icon: Icons.logout,
  textColor: Colors.red, // Set text color to red
  iconColor: Colors.red, // Set icon color to red
)

          ],
        ),
      ),
    );
  }
}

void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color:Color.fromARGB(255, 246, 66, 60), // Set your desired border color here
            width: 2.0, // Set the border width
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        title: Text(
          "Logout",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to logout?",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child:  Text(
              "Cancel",
              style: TextStyle(
                color: Colors.black,
              ),
            ),
            ),
            TextButton(
              onPressed: () {
                // Perform logout logic here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
    "Logout",
    style: TextStyle(
      color: Colors.white,
    ),
  ),
  style: TextButton.styleFrom(
    backgroundColor: Colors.red,
  ),
            ),
          ],
        );
      },
    );
}class ShadowedBox extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData icon;
  final Color textColor; // Added parameter for text color
  final Color iconColor; // Added parameter for icon color

  ShadowedBox({
    required this.text,
    required this.onPressed,
    required this.icon,
    required this.textColor,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        shadowColor: Colors.grey,
        elevation: 5,
        fixedSize: Size.fromHeight(60.0), // Set the desired height
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 30.0), // Set the desired icon size
          SizedBox(width: 18),
          Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 15.0, // Set the desired text size
            ),
          ),
        ],
      ),
    );
  }
}


class CircleIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color backgroundColor;

  CircleIconButton({
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
  });

 @override
Widget build(BuildContext context) {
  return ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      primary: Colors.transparent,
      shape: CircleBorder(),
    ),
    child: Container(
      alignment: Alignment.center,
      padding: EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
      ),
      child: Icon(
        icon,
        color: Colors.black,
      ),
    ),
  );
}

}
