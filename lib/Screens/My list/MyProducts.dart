import 'package:flutter/material.dart';
import './myproduct.dart';
import '/commons/styles.dart';
import '/commons/images.dart';
import './editproduct.dart';

class MyProducts extends StatefulWidget {
  final List? items=[
    {
      'image':firstcategory_image,
      'name':'Wheelchair',
      'price':'154.00',
      'owner name':'Mostapha Ahmed',

    },
    {
      'image':secondcategory_image,
      'name':'Wheelchair',
      'price':'154.00',
      'owner name':'Mostapha Ahmed',

    },
    {
      'image':thirdcategory_image,
      'name':'Wheelchair',
      'price':'154.00',
      'owner name':'Mostapha Ahmed',

    }
  ];
  MyProducts({Key? key}) : super(key: key);

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  List<String> images=[firstcategory_image,firstcategory_image];
  

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('My List',style: titleTextStyle,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.blue,size: 30,),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
      ),
      body: Material(
      child: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisExtent: 200,
                ),
                itemCount: widget.items!.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    child: MyProduct(
                      image: widget.items![index]['image'],
                      name: widget.items![index]['name'],
                      price: widget.items![index]['price'],
                      onDelete: () {
                      setState(() {
                        widget.items!.removeAt(index);
                      });},
                      onEdit: () {
                          _navigateToEditScreen(context, index);
                        },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ));
  }
  void _navigateToEditScreen(BuildContext context, int index) async {
    // Navigate to the edit screen and get the updated product information
    final updatedProduct = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditProductDetail(
          images: images,
          data: widget.items![index],
        ),
      ),
    );
}
}