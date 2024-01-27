import 'package:flutter/material.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;
  bool camera = true;
  bool contacts = true;
  bool microphone = true;
  bool phone = true;
  bool location = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Settings',
            style: TextStyle(color: Colors.black), // Text color
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          SwitchListTile(
            title: Text('Notifications'),
            value: notifications,
            onChanged: (bool value) {
              setState(() {
                notifications = value;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: Text('Camera'),
            value: camera,
            onChanged: (bool value) {
              setState(() {
                camera = value;
              });
            },
            secondary: Icon(Icons.camera),
          ),
          SwitchListTile(
            title: Text('Contacts'),
            value: contacts,
            onChanged: (bool value) {
              setState(() {
                contacts = value;
              });
            },
            secondary: Icon(Icons.contacts),
          ),
          SwitchListTile(
            title: Text('Microphone'),
            value: microphone,
            onChanged: (bool value) {
              setState(() {
                microphone = value;
              });
            },
            secondary: Icon(Icons.mic),
          ),
          SwitchListTile(
            title: Text('Phone'),
            value: phone,
            onChanged: (bool value) {
              setState(() {
                phone = value;
              });
            },
            secondary: Icon(Icons.phone),
          ),
          SwitchListTile(
            title: Text('Location'),
            value: location,
            onChanged: (bool value) {
              setState(() {
                location = value;
              });
            },
            secondary: Icon(Icons.location_on),
          ),
          ListTile(
            title: Text('Language'),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              // Navigate to language settings screen
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Handle Save button press
                },
                
                
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // Handle Cancel button press
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green, // Background color
                ),
                child: Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
