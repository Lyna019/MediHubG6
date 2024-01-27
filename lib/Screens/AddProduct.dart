import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import'../Screens/homeProducts.dart';
import 'package:path/path.dart' as p;
import 'package:jwt_decoder/jwt_decoder.dart';


import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import'package:medihub_1/Screens/users/auth_utils.dart';

import './controllers/productcontroller.dart';
import 'dart:convert';
import 'package:supabase/supabase.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}
const supabaseUrl = 'https://eookpobfniytgmprafet.supabase.co';
const supabaseKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVvb2twb2Jmbml5dGdtcHJhZmV0Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwMjU5MTEzNywiZXhwIjoyMDE4MTY3MTM3fQ.cRfqIgErex8V3dBgAhGkmG53Plz5IEU1b3upcl4Ma7w';


class _AddProductPageState extends State<AddProductPage> {
  final secureStorage = FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  final ProductController productController = Get.find();
  final ImagePicker _picker = ImagePicker();
  bool isRent = false;
  String? selectedCategory;
  int? selectedCategoryId; 
  String? selectedCondition;
  String productName = '';
  double price = 0.0;
  File? imageFile;  // Single File variable to hold the selected image
 late  final SupabaseClient supabase; // Declare the SupabaseClient

  @override
  void initState() {
    super.initState();
    
    supabase = SupabaseClient(supabaseUrl, supabaseKey);
    
  }

Map<String, int> categoryIds = {
  'Mobility Aids': 1,
  'Diagnostic Equipments': 2,
  'Medical Supplies': 3,
  'Medical Equipements': 4,
  
};



  // Method for picking image from gallery or taking a picture
  Future<void> _pickOrTakeImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
    }
  }

  // Method to change the selected image
  Future<void> _changeSelectedImage() async {
    // Show options to take a new picture or select from gallery
    final option = await showModalBottomSheet<int>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take Picture'),
                onTap: () => Navigator.of(context).pop(1),
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () => Navigator.of(context).pop(2),
              ),
            ],
          ),
        );
      },
    );

    // Act based on selected option
    if (option == 1) {
      await _pickOrTakeImage(ImageSource.camera);
    } else if (option == 2) {
      await _pickOrTakeImage(ImageSource.gallery);
    }
  }

void _submitProduct() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Map<String, dynamic> data = {
        'product_name': productName,
        'price': price.toString(),
        'category_id': selectedCategoryId,
        'condition': selectedCondition,
      };

      if (imageFile != null) {
        // Convert image to base64 string
        final bytes = await imageFile!.readAsBytes();
        data['product_image'] = base64Encode(bytes); // Storing image as a base64 string
      }

      _addProduct(data);
    } else {
      print('Form is not valid');
    }
    
  }


Future<void> _addProduct(Map<String, dynamic> data) async {
  try {
    final response = await supabase.from('products').insert([data]);

    if (response == null) {
      print('Response is null. Possible network issue or misconfiguration.');
      // Handle this situation, maybe show a Snackbar
      return;
    }

    if (response.error != null) {
      print('Failed to add product: ${response.error.message}');
      // Handle the error, maybe show a Snackbar
      return;
    }

    print('Product added successfully. Response data: ${response.data}');
    // Navigate or show a success message

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeProducts(selectedCategory: selectedCategory ?? 'All')),
    );
  } catch (e) {
    print('Error during the insert operation: $e');
    // Handle the error, maybe show a Snackbar
  }
}




 
  void _showSubmissionConfirmationDialog(BuildContext context) {
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
          "Confirm Submission",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          "Are you sure you want to Add your Product to the Viewlist?",
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
    _submitProduct(); // Add your submission logic here
    Navigator.of(context).pop(); // Close the dialog
  },
  child: Text(
    "Submit",
    style: TextStyle(
      color: Colors.black,
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
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        automaticallyImplyLeading: false,
        
        
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           
            SizedBox(width: 25.0),
            Center(
              child:Text(
              'Add My Product',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),)
            
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
      SizedBox(height: 30.0),
      CircleAvatar(
        radius: 60,
         
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
              _buildStyledContainer(_buildTextField1('Product Name')),
              SizedBox(height: 16.0),
              _buildStyledContainer(_buildSwitch()),
              if (isRent) _buildStyledContainer(_buildTextField2('Price Per Day')),
              SizedBox(height: 16.0),
              _buildStyledContainer(_buildDropdown1( ['Mobility Aids', 'Medical Equipments', ' Medical supplies','Medical Equipements'])),
              SizedBox(height: 16.0),
              _buildStyledContainer(_buildDropdown(['New', 'Used', 'Good condition'])),
              SizedBox(height: 16.0),
              _buildStyledContainer(_buildUploadImage()),
              SizedBox(height: 16.0),
              _buildSubmitButton(),
            ],
    
          ),
        ),
    ],
      ),
      
    ),
      )
    );
  }
 


  

  Widget _buildStyledContainer(Widget child) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
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

  Widget _buildTextField2( String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        TextFormField(
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onChanged: (value) {
            setState(() {
              price = double.tryParse(value) ?? 0;
            });
          },
        ),
      ],
    );
  }
  Widget _buildTextField1( String hintText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        TextFormField(
          
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          ),
          
          validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        onChanged: (value) {
            setState(() {
              productName = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildSwitch() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.0),
      
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Row(
          children: [
            Text(
          'Donate',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
            Expanded(
              child: Center(
                child: Switch(
                  activeColor: Color(0xFF3CF6B5), // Set the color here
                  value: isRent,
                  onChanged: (value) {
                    setState(() {
                      isRent = value;
                    });
                  },
                ),
              ),
            ),
            Text(
          ' Rent',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
          ],
        ),
      ],
    ),
  );
}


  Widget _buildDropdown( List<String> items) {
  // Remove duplicate values from the list
  items = items.toSet().toList();

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      
       DropdownButtonFormField<String>(
              value: selectedCondition,
              hint: Text(
                'Condition',
              ),
              onChanged: (value) =>
                  setState(() => selectedCondition = value),
              validator: (value) => value == null ? 'field required' : null,
              items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
                  child: Text(item),
                );
              }).toList(),
              decoration: InputDecoration(
          // Set the hover color for the entire field
          hoverColor: Color(0xFF3CF6B5),
          border: InputBorder.none,
        ),
      ),
    ],
  );
}


  Widget _buildDropdown1(List<String> items) {
  // Remove duplicate values from the list
  items = items.toSet().toList();


  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      DropdownButtonFormField<String>(
        value: selectedCategory,
        hint: Text(
          'Category',
        ),
        onChanged: (value) => setState(() {
      selectedCategory = value;
      selectedCategoryId = categoryIds[value!]; // Get the corresponding ID
    }),
        validator: (value) => value == null ? 'Field required' : null,
        items: items.map((item) {
          return DropdownMenuItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        decoration: InputDecoration(
          // Set the hover color for the entire field
          hoverColor: Color(0xFF3CF6B5),
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
          'Upload Product Image',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Center(child: 
        IconButton(
          onPressed: () {
            _changeSelectedImage();
          },
          
          icon: Icon( Icons.upload, size: 50.0)),
        ),
      ],
    );
  }

 Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          // Form is valid, submit the product
          _showSubmissionConfirmationDialog(context);
        }
      },
      child:Text(
              'Submit',
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

  



    





 





}
