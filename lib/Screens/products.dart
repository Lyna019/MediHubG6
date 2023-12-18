import 'package:medihub_1/color/colors.dart';
import '/screens/productDetail.dart';
import 'package:flutter/material.dart';
import '/screens/product.dart';
import '/commons/styles.dart';
import '/commons/images.dart';

class Products extends StatefulWidget {
  final String categoryName;
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
  Products({required this.categoryName, Key? key}) : super(key: key);

  @override
  _HomeProductsState createState() => _HomeProductsState();
}

class _HomeProductsState extends State<Products> {
  static const String rentText = 'Rent';
  static const String donationText = 'Donation';
  List<String> images=[firstcategory_image,firstcategory_image];
  

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                    padding: EdgeInsets.all(10.0),
                    child: Text(widget.categoryName,style: titleTextStyle,),
                  ),
              myBoxDecoration('Rent'),
              GridView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisExtent: 270,
  ),
  itemCount: widget.items!.length, 
  itemBuilder: (context, index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetail(images: images, data: widget.items![index]),
          ),
        );
      },
      child: Product(
        image: widget.items![index]['image'],
        name: widget.items![index]['name'],
        price: widget.items![index]['price'],
        selectedCategory: widget.items![index]['selectedCategory'],
        selectedCondition: widget.items![index]['selectedCondition'],
      ),
    );
  },
),

              myBoxDecoration('Donnations'),
              GridView.builder(
  physics: NeverScrollableScrollPhysics(),
  shrinkWrap: true,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisExtent: 270,
  ),
  itemCount: widget.items!.length, 
  itemBuilder: (context, index) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProductDetail(images: images, data: widget.items![index]),
          ),
        );
      },
      child: Product(
        image: widget.items![index]['image'],
        name: widget.items![index]['name'],
        price: widget.items![index]['price'],
        selectedCategory: widget.items![index]['selectedCategory'],
        selectedCondition: widget.items![index]['selectedCondition'],
      ),
    );
  },
),

              
            ],
          ),
        ),
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
