
import 'package:flutter/material.dart';
import 'package:medihub_1/color/colors.dart';


class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool receiveNotifications = false;
  bool useCamera = false;
  bool useMicrophone = false;
  bool useLocation = false;
  String selectedLanguage = 'English';

  bool initialReceiveNotifications = true;
  bool initialUseCamera = true;
  bool initialUseMicrophone = true;
  bool initialUseLocation = true;
  String initialSelectedLanguage = 'English';

  @override
  void initState() {
    super.initState();

    // Save initial settings
    initialReceiveNotifications = receiveNotifications;
    initialUseCamera = useCamera;
    initialUseMicrophone = useMicrophone;
    initialUseLocation = useLocation;
    initialSelectedLanguage = selectedLanguage;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
    backgroundColor: Colors.white,
    title: Text(
      "Update Profile Info",
      style: TextStyle(color: midnightcolor),
    ),
    centerTitle: true,
    leading: Ink(
      decoration: ShapeDecoration(
        
        color: Color(0xFF3CF6B5),
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressed: () {
          Navigator.pop(context); // Handle back button press
        },
      ),
    ),
  ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.0),
            _buildSetting('Receive Notifications', Icons.notifications,
                receiveNotifications, (value) => setState(() => receiveNotifications = value)),
            SizedBox(height: 30.0),
            _buildSetting('Use Camera', Icons.camera,
                useCamera, (value) => setState(() => useCamera = value)),
            SizedBox(height: 30.0),
            _buildSetting('Use Microphone', Icons.mic,
                useMicrophone, (value) => setState(() => useMicrophone = value)),
            SizedBox(height: 30.0),
            _buildSetting('Use Location', Icons.location_on,
                useLocation, (value) => setState(() => useLocation = value)),
            SizedBox(height: 30.0),
            _buildDropdown('Language', ['English', 'French']),
            SizedBox(height: 100.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Save button logic
                    _saveSettings();
                  },
                  child: Text(
                    "Save",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF3CF6B5),
                    minimumSize: Size(150, 40),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Cancel button logic
                    _cancelSettings();
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: Size(150, 40),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSetting(
      String label, IconData icon, bool value, Function(bool) onChanged) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        label,
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: Switch(
        activeColor: Colors.blue,
        value: value,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        DropdownButton<String>(
          value: selectedLanguage,
          onChanged: (value) {
            setState(() {
              selectedLanguage = value!;
            });
          },
          items: items.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
        ),
      ],
    );
  }

  void _saveSettings() {
    // Add logic to save the settings
    print('Receive Notifications: $receiveNotifications');
    print('Use Camera: $useCamera');
    print('Use Microphone: $useMicrophone');
    print('Use Location: $useLocation');
    print('Selected Language: $selectedLanguage');
    // Implement your saving logic here
  }

  void _cancelSettings() {
    // Revert to initial settings
    setState(() {
      receiveNotifications = initialReceiveNotifications;
      useCamera = initialUseCamera;
      useMicrophone = initialUseMicrophone;
      useLocation = initialUseLocation;
      selectedLanguage = initialSelectedLanguage;
    });

    // Add any additional logic needed when canceling
    print('Settings canceled');
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
        backgroundColor: Colors.transparent,
        shape: CircleBorder(),
      ),
      child: Container(
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