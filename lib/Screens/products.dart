import 'dart:async';

import 'package:medihub_1/Screens/My list/myproduct.dart';
import 'package:medihub_1/color/colors.dart';
import 'package:medihub_1/commons/sentences.dart';

import 'product/productDetail.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import '/commons/styles.dart';
import '/commons/images.dart';
import '../../Supabase/databasefunctions.dart';

class Products extends StatefulWidget {
  final String categoryName;
  final Function(String) onCategoryChanged;
  Products({required this.categoryName,required this.onCategoryChanged, Key? key}) : super(key: key);

  @override
  _HomeProductsState createState() => _HomeProductsState();
}

class _HomeProductsState extends State<Products> {
  static const String rentText = 'Rent';
  static const String donationText = 'Donation';
  late Future<List<Map<String, dynamic>>> myProductsRent;
  late Future<List<Map<String, dynamic>>> myProductsDonate;
  late int categoryId;


  @override
  void initState() {
    super.initState();
    print(widget.categoryName);

    // Choose the appropriate stream based on categoryName
    int categoryId=getCategoryId(widget.categoryName);
    if (categoryId == 0) {
      print('HI FROM ALL');
      myProductsRent= DatabaseFunctions().getProductsRentAll();
      myProductsDonate= DatabaseFunctions().getProductsDonateAll();
    } else {
      print('HI not FROM ALL');
      myProductsRent = DatabaseFunctions().getProductsRentByCategory(categoryId);
      myProductsDonate= DatabaseFunctions().getProductsDonateByCategory(categoryId);
    }

  }
  int getCategoryId(String categoryName){

    int id=0;

    if(categoryName==firstCategory)
    {
      id=1;
    }
    else if(categoryName==secondCategory)
    {
      id=2;
    }
    else if(categoryName==thirdCategory)
    {
      id=3;
    }
    else if(categoryName==fourthCategory)
    {
      id=4;
    }

    return id ;

  }
  @override
void didUpdateWidget(covariant Products oldWidget) {
  super.didUpdateWidget(oldWidget);
  // Check if the category has changed and update accordingly
  if (oldWidget.categoryName != widget.categoryName) {
    setState(() {
      int categoryId=getCategoryId(widget.categoryName);
    if (categoryId == 0) {
      print('HI FROM ALL');
      myProductsRent= DatabaseFunctions().getProductsRentAll();
      myProductsDonate= DatabaseFunctions().getProductsDonateAll();
    } else {
      print('HI not FROM ALL');
      myProductsRent = DatabaseFunctions().getProductsRentByCategory(categoryId);
      myProductsDonate= DatabaseFunctions().getProductsDonateByCategory(categoryId);
    }
    });
  }
}
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(10.0),
              child: Text(widget.categoryName!, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
             
            ),
           myBoxDecoration('Rent'),
           allProductsWidget(myProductsRent),
           myBoxDecoration('Donations'),
           allProductsWidget(myProductsDonate),
          ],
        ),
      ),
    );
  }
FutureBuilder<List<Map<String, dynamic>>> allProductsWidget(
  Future<List<Map<String, dynamic>>> myProductsFuture,
) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: myProductsFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.done) {
        if (snapshot.hasData) {
          List<Map<String, dynamic>> myProducts = snapshot.data!;
          return GridView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 270,
            ),
            itemCount: myProducts.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print('---------------------------------------------------------------------------------------------------------');
                  print(myProducts[index]['id']);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        productId: myProducts[index]['id'] ?? 'Default Value',
                      ),
                    ),
                  );
                },
                child: Product(
                  image: myProducts[index]['product_image'] ?? logo,
                  name: myProducts[index]['product_name'] ?? 'Default Value',
                  price: myProducts[index]['price'].toString() ?? 'Default Value',
                ),
              );
            },
          );
        } else if (snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
          // Display a generic error message for any type of error
          return  Text(
              'No internet connection ',
              style: TextStyle(fontSize: 16, color: Colors.red),
            
          );
        } else {
          return CircularProgressIndicator();
        }
      } else {
        // Future is still in progress
        return CircularProgressIndicator();
      }
    },
  );
}

  Widget myBoxDecoration(String text) {
    return Container(
      margin: EdgeInsets.all(10.0),
      padding: EdgeInsets.all(10.0),
      width: 200,
      decoration: BoxDecoration(
        color: midnightcolor,
        borderRadius: BorderRadius.only(topRight: Radius.circular(100),bottomRight: Radius.circular(100),),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: midnightcolor,
            width: 1.0,
          ),
        ),
      ),
      child:Text(
              text,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
    );
  }

 
}
