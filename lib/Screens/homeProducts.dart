import 'package:medihub_1/color/colors.dart';

import 'product/productDetail.dart';
import 'products.dart';
import 'package:flutter/material.dart';
import 'product.dart';
import 'package:medihub_1/Screens/search/search.dart';
import '/commons/styles.dart';
import '/commons/images.dart';
import '/commons/sentences.dart';

class HomeProducts extends StatefulWidget {
  final String selectedCategory;

  HomeProducts({required this.selectedCategory});

  @override
  _HomeProductsState createState() => _HomeProductsState();
}

class _HomeProductsState extends State<HomeProducts>with SingleTickerProviderStateMixin {

  String selectedCategory='All' ;

  @override
  void initState() {
    super.initState();
    if(widget.selectedCategory=='')
    {
      selectedCategory='All' ;
    }
    else{
      selectedCategory=widget.selectedCategory;
    }
    
  }
  void onCategoryChanged(String newCategory) {
  setState(() {
    selectedCategory = newCategory;
  });
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
                padding: EdgeInsets.all(10.0),
                child: Row(children: [
                  Text('Categories',style: titleTextStyle,),
                  Spacer(),
                  search(),
                ],),
              ),

              getAllCategories(),
              Products(
  categoryName: selectedCategory,
  onCategoryChanged: onCategoryChanged,
)

            ],
            ),
            ),
            ),
            );
          
  }

Widget search() {
  return Material(
    child: Container(
      margin: EdgeInsets.all( 10.0),
      child: IconButton( 
        icon: Icon(
          Icons.search,
          color: Colors.black,
          size: 30,)
          ,onPressed: (){
          showSearch(context: context, delegate: DataSearch());
          }),
        ),
      );
}
 Widget getAllCategories() {
  return Container(
        height: 130,
        child: ListView(
          scrollDirection: Axis.horizontal,
            children: [
              getcategory(logo, 'All ', navigateToCategory),
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