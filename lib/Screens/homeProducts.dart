import 'package:medihub_1/color/colors.dart';
import './controllers/productcontroller.dart';
import 'package:get/get.dart';

import '/screens/products.dart';
import 'package:flutter/material.dart';
import '/commons/styles.dart';
import '/commons/images.dart';
import '/commons/sentences.dart';

class HomeProducts extends StatefulWidget {

  final ProductController productController = Get.find();
  final String selectedCategory;

  HomeProducts({required this.selectedCategory});

  @override
  _HomeProductsState createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts>with SingleTickerProviderStateMixin {

  String selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('MediHub',style: titleTextStyle,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: Colors.blue,size: 30,),
          onPressed: () {
            Navigator.of(context).pop(); 
          },
        ),
      ),
      body: Container(
         color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: search(),
              ),

              Container(
                padding: EdgeInsets.all(10.0),
                child: Text('Categories',style: titleTextStyle,),
              ),

              getAllCategories(),
              Products(categoryName: selectedCategory,)
            ],),),),);
          
  }

Widget search() {
  return Material(
    child: Container(
      margin: EdgeInsets.all( 10.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search',
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.all(10),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white, 
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: Color(0xFF3CF6B5), 
            ),
          ),
          suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    ),
  );
}
 Widget getAllCategories() {
  return Container(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
            children: [
              getcategory(firstcategory_image, firstCategory, navigateToCategory),
              getcategory(secondcategory_image,secondCategory, navigateToCategory),
              getcategory(thirdcategory_image, thirdCategory, navigateToCategory),
              getcategory(fourthcategory_image, fourthCategory, navigateToCategory),
            ],
          
      ),
    );
}
void navigateToCategory(String categoryName) {
    setState(() {
    selectedCategory = categoryName;
    });
  }
Widget getcategory(String categoryimage,String categoryname,Function(String) onTap){
    return GestureDetector(
    onTap: () {
      onTap(categoryname);
    },
    child:Container(
      width: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: categoryname == selectedCategory ?  green : Colors.grey[200],
            ),
            child: ClipOval(
              child: Image.asset(
                categoryimage ?? 'errorimage',
                width: 50,
                height: 50,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child :Text(
            categoryname ?? "errorname",
            style: categoryname == selectedCategory ?  subTitleblueTextStyle : subTitleTextStyle,
            textAlign: TextAlign.center,
          ),
          )// Add spacing between the circle and text
        ],
      ),),);
  }

}