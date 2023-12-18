import 'package:flutter/material.dart';
import 'package:medihub_1/color/colors.dart';
import '/commons/styles.dart';

class EditProductDetail extends StatefulWidget {
  final List<String>? images;
  final Map<String, dynamic> data;

  EditProductDetail({required this.images, required this.data, Key? key})
      : super(key: key);

  @override
  State<EditProductDetail> createState() => _EditProductDetailState();
}

class _EditProductDetailState extends State<EditProductDetail>
    with SingleTickerProviderStateMixin {
  List<String>? img;
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController rentalRulesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    img = [widget.data['image']];
    nameController.text = widget.data['name'];
    priceController.text = widget.data['price'];
    descriptionController.text = widget.data['description'] ?? 'Product description it has fkenkjvnkc sjc bvhvejblk ';
    rentalRulesController.text = widget.data['rentalRules'] ?? '.kjqdewjfewifbj\n.udh2rgwfbjkcnb\n.idjewjfhjgn';
  }
  void _saveChanges() {
    final updatedProduct = {
      'image': img![0],
      'name': nameController.text,
      'price': priceController.text,
      'description': descriptionController.text,
      'rentalRules': rentalRulesController.text,
    };

    Navigator.pop(context, updatedProduct);
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
              style: TextStyle(fontSize: 17,
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
                child: showImages(),
              ),

              SizedBox(height: 10),
              nameField(),

              SizedBox(height: 10),
              priceField(),

              SizedBox(height: 10),
              myLineDecoration(),

              SizedBox(height: 10),
              myLineDecoration(),
              descriptionField(),
              SizedBox(height: 10),
              myLineDecoration(),

              SizedBox(height: 10),
              myLineDecoration(),
              rentalRulesField(),
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

  Widget showImages() {
    return PageView.builder(
      itemCount: img != null ? widget.images!.length : 0,
      itemBuilder: (context, index) {
        return Image.asset(
          img![index],
          width: double.infinity,
          fit: BoxFit.contain,
        );
      },
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

  Widget descriptionField() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: descriptionController,
        maxLines: 3, 
        decoration: InputDecoration(
          labelText: 'Description',
          labelStyle: titleTextStyle,
        ),
      ),
    );
  }

  Widget rentalRulesField() {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: TextFormField(
        controller: rentalRulesController,
        maxLines: 3,
        decoration: InputDecoration(
          labelText: 'Rental Rules',
          labelStyle: titleTextStyle,
        ),));
  }
}