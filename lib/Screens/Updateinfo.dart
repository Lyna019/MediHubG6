import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:medihub_1/color/colors.dart';



class UpdatePersonalInfoPage extends StatefulWidget {
  @override
  _UpdatePersonalInfoPageState createState() => _UpdatePersonalInfoPageState();
}

class _UpdatePersonalInfoPageState extends State<UpdatePersonalInfoPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch and set initial data here
    _fetchInitialData();
  }
  File? imageFile;

 Future<void> _pickImage() async {
  final ImagePicker _picker = ImagePicker();

  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    setState(() {
      imageFile = File(pickedFile.path);
    });
  } else {
    // Handle the case where the user cancels the image picking process
    print("No image selected");
  }
}

  // Method to fetch initial data
  void _fetchInitialData() {
    // Replace the following lines with your logic to fetch data
    nameController.text = "Mohammed ";
    emailController.text = "Mohamed.Moh@gmail.com";
    phoneController.text = "0558969592";
    addressController.text = " 64 Achour";
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
    automaticallyImplyLeading: true,
  ),
      body: SingleChildScrollView(
        child: Column(
        children: [
        SizedBox(height: 30.0),
      CircleAvatar(
        radius: 60,
        backgroundImage: AssetImage('assets/images/profile.jpg'), // Replace with your image asset
      ),
      SizedBox(height: 16.0),
      Text(
        'Username',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    
      SizedBox(height: 20.0),
          Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
          
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildStyledContainer(_buildTextField('Name', 'Enter your name', nameController)),
            SizedBox(height: 16.0),
            _buildStyledContainer(_buildTextField('Email', 'Enter your email', emailController, TextInputType.emailAddress)),
            SizedBox(height: 16.0),
            _buildStyledContainer(_buildTextField('Phone Number', 'Enter your phone number', phoneController, TextInputType.phone)),
            SizedBox(height: 16.0),
            _buildStyledContainer(_buildTextField('Home Address', 'Enter your home address', addressController)),
            SizedBox(height: 16.0),
            _buildStyledContainer(_buildUploadImage()),
            SizedBox(height: 16.0),
            _buildSubmitButton(context),
          ],
        ),
      ),
      
      ],
      ),
      ),
    );
  }

  Widget _buildStyledContainer(Widget child) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Color(0xFFe3e3e3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            spreadRadius: 1,
            blurRadius: 2,
          ),
        ],
        color: Colors.white,
      ),
      child: child,
    );
  }

  Widget _buildTextField(String label, String hintText, TextEditingController controller, [TextInputType keyboardType = TextInputType.text]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  Widget _buildUploadImage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Upload Profile Image',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(child: IconButton(
          onPressed: () {
            _pickImage();
          },
          icon: Icon(Icons.photo_library, size: 40, color:Color(0xFF3CF6B5)),
        ),
        ),
      ],
    );
  }
  

  Widget _buildSubmitButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Add submit logic
        _showConfirmationDialog(context);
      },
      child:Text(
              'Save',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
      style: ElevatedButton.styleFrom(
                  // Set the background color of the button
                  backgroundColor: Color(0xFF3CF6B5),
                ),
    );
  }

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
          side: BorderSide(
            color:Color(0xFF3CF6B5), // Set your desired border color here
            width: 2.0, // Set the border width
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
          title: Text(
            "Confirm Update",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            "Are you sure you want to update your personal information?",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                _submitUpdate(); // Add your update logic here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text(
                "Update",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Color(0xFF3CF6B5),
              ),
            ),
          ],
        );
      },
    );
  }
  

  void _submitUpdate() {
    // Add logic to submit the updated personal information
    print('Name: ${nameController.text}');
    print('Email: ${emailController.text}');
    print('Phone Number: ${phoneController.text}');
    print('Home Address: ${addressController.text}');
    // Add additional logic as needed
  }
}
