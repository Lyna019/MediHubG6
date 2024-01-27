import 'package:flutter/material.dart';
import 'package:medihub_1/color/colors.dart';
import 'package:medihub_1/commons/images.dart';
import 'package:medihub_1/Supabase/databasefunctions.dart';
import '/commons/styles.dart';

class EditProductDetail extends StatefulWidget {
  final int productId;

  EditProductDetail({required this.productId, Key? key}) : super(key: key);

  @override
  State<EditProductDetail> createState() => _EditProductDetailState();
}

class _EditProductDetailState extends State<EditProductDetail>
    with SingleTickerProviderStateMixin {
  String? img;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  late Future<List<Map<String, dynamic>>> product;

  @override
  void initState() {
    super.initState();
    initProductData();
  }

  Future<void> initProductData() async {
    product = DatabaseFunctions().getRowProductById(widget.productId!);
    List<Map<String, dynamic>> productRow = await product;

    setState(() {
      img = productRow[0]['product_image'];
      nameController.text = productRow[0]['product_name'];
       priceController.text = productRow[0]['price'].toString(); 
      conditionController.text = productRow[0]['condition'] ?? 'good';
    });
  }
void _saveChanges() async {
  try {
    // Retrieve updated values from your controllers
    String updatedName = nameController.text;
    int updatedPrice = int.parse(priceController.text); // Convert String to int
    String updatedCondition = conditionController.text;

    // Call the updateProduct function
    await DatabaseFunctions().updateProduct(
      updatedName,
      updatedPrice,
      updatedCondition,
      widget.productId,
    );

    // If the update is successful, pass the updated data back to the previous screen
    Navigator.pop(context, {
      'updatedName': updatedName,
      'updatedPrice': updatedPrice,
      'updatedCondition': updatedCondition,
    });
  } catch (error) {
    print('Error updating product: $error');
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MediHub', style: titleTextStyle),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue, size: 30),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          // Add Save Changes button
          TextButton(
            onPressed: _saveChanges,
            child: Text(
              'Save Changes',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: midnightcolor,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 300,
                child: showImage(img ?? logo),
              ),

              SizedBox(height: 10),
              nameField(),

              SizedBox(height: 10),
              priceField(),

              SizedBox(height: 10),
              myLineDecoration(),

              SizedBox(height: 10),
              myLineDecoration(),
              SizedBox(height: 10),
              myLineDecoration(),

              SizedBox(height: 10),
              myLineDecoration(),
              conditionField(),
              SizedBox(height: 10),
              myLineDecoration(),
            ],
          ),
        ),
      ),
    );
  }

  Widget myLineDecoration() {
    return Container(
      margin: EdgeInsets.only(top: 5, bottom: 5),
      height: 0.1,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
      ),
    );
  }

 Widget showImage(String img) {
    return  Image.asset(
          img?? logo,
          width: double.infinity,
          fit: BoxFit.contain,
        );
      }
  Widget nameField() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: nameController,
        decoration: InputDecoration(
          labelText: 'Name',
          labelStyle: titleTextStyle,
        ),
      ),
    );
  }

  Widget priceField() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: priceController,
        decoration: InputDecoration(
          labelText: 'Price',
          labelStyle: titleTextStyle,
        ),
      ),
    );
  }

  Widget conditionField() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: conditionController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Condition',
          labelStyle: titleTextStyle,
        ),
      ),
    );
  }
}
