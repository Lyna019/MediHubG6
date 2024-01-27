import '/commons/images.dart';
import 'package:flutter/material.dart';
import '/commons/styles.dart';

class MyProduct extends StatefulWidget {
  final String? image;
  final String? name;
  final String? condition;
  final int? price;

  MyProduct({required this.image, required this.name, required this.price, required this.condition,Key? key})
      : super(key: key);

  @override
  _MyProductState createState() => _MyProductState();
}

class _MyProductState extends State<MyProduct> {

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          showImage(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  productName(),
                  productPrice(),
                  productCondition(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
Widget showImage() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
    ),
    child: 
        Container(
          width: 150, // Set the width here
          height: 150, // Set the height here
          child: Image.asset(
            widget.image! ?? logo,
            fit: BoxFit.contain, // Use BoxFit.cover to maintain aspect ratio
          ),
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
        '${widget.price!} DA'??'ERROR',
        style: PriceTextStyle,
      ),
    );
  }
  Widget productCondition() {
    return Container(
      margin: EdgeInsets.only(left: 15.0,bottom: 5.0),
      child: Text(
        '${widget.condition!} '??'ERROR',
        style: PriceTextStyle,
      ),
    );
  }

}