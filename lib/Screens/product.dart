import 'package:medihub_1/color/colors.dart';

import '/commons/images.dart';
import 'package:flutter/material.dart';
import '/commons/styles.dart';

class Product extends StatefulWidget {
  final String? image;
  final String? name;
  final String? price;

  Product({required this.image, required this.name, required this.price, Key? key})
      : super(key: key);

  @override
  _ProductState createState() => _ProductState();
}

class _ProductState extends State<Product> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
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
                  width: 2.0,
                ),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showImage(),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                productName(),
                productPrice(),
                productOwner(),
                
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget showImage() {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,),
      child: Stack(
        alignment: Alignment.topRight,
        children: [
          Image.asset(
            widget.image! ??logo,
            height: 125,
            width: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            top: -10.0,
            right: -4.0,
            child: IconButton(
              iconSize: 40,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? green : midnightcolor,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                });
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget productName() {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Text(
        widget.name! ?? 'ERROR',
        style: titleTextStyle,
      ),
    );
  }

  Widget productPrice() {
    return Container(
      margin: EdgeInsets.only(left: 15.0,bottom: 5.0),
      child: Text(
        (widget.price! ?? 'ERROR') +' DZD /Day',
        style: PriceTextStyle,
      ),
    );
  }

  Widget productOwner() {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: ClipOval(
              child: Image.asset(
                unkown,
                width: 30,
                height: 30,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Text(
                "Abdou",
                style: subTitleTextStyle,
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
