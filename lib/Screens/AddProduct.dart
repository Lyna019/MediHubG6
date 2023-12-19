import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Screens/product.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import './controllers/productcontroller.dart';
import 'dart:convert';
class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  final ProductController productController = Get.find();
  bool isRent = false;
  String? selectedCategory;
  String? selectedCondition;
  String productName = '';
  double price = 0.0;
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


  void _submitProduct() async{

  // Assuming imageFile is a File object representing the product image
  String imagePath = imageFile!.path; // Use the null assertion operator (!) here

  Product newProduct = Product(
    image: imagePath,
    name: productName,
    price: price.toString(),
    rating: 0.0,
    selectedCategory: selectedCategory, // Provide the selected category
    selectedCondition: selectedCondition, // Provide the selected condition
  );
  if (imageFile == null) {
    
    print("No image selected");
    return;
  }
String base64Image = base64Encode(imageFile!.readAsBytesSync());

  // Prepare the request payload
  var data = {
    'name': productName,
    'price': price.toString(),
    'category': selectedCategory,
    'condition': selectedCondition,
    'image': base64Image,  // or handle as multipart file
  };

  // Making HTTP POST request
  var response = await http.post(
    Uri.parse('http://flask-signup.vercel.app/add_product'),
    body: json.encode(data),
    headers: {'Content-Type': 'application/json'},

  );

  if (response.statusCode == 200) {
    print('Product added successfully');
    // Handle successful response
  } else {
    print('Failed to add product');
    // Handle error response
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
              _buildStyledContainer(_buildTextField1('Product Name')),
              SizedBox(height: 16.0),
              _buildStyledContainer(_buildSwitch()),
              if (isRent) _buildStyledContainer(_buildTextField2('Price Per Day')),
              SizedBox(height: 16.0),
              _buildStyledContainer(_buildDropdown1( ['Mobility Aids', 'Medical Equipments', ' Medical supplies'])),
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
        onChanged: (value) => setState(() => selectedCategory = value),
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
            _pickImage();
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



    





 






