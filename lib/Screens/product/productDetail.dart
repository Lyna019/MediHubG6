import 'package:medihub_1/color/colors.dart';
import 'package:medihub_1/Supabase/databasefunctions.dart';

import '/commons/images.dart';
import '/commons/styles.dart';
import 'package:flutter/material.dart';
import 'package:medihub_1/Screens/chat.dart';

class ProductDetail extends StatefulWidget {
  final productId;
  ProductDetail({required this.productId, Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> with SingleTickerProviderStateMixin {
  List<String>? img;
  late Future<List<Map<String, dynamic>>> product=DatabaseFunctions().getRowProductById(widget.productId!);
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
      body:Container(
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child:FutureBuilder<List<Map<String, dynamic>>>(
      future: product,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while waiting for data
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No data available');
        } else if (snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
          // Display a generic error message for any type of error
          return  Text(
              'No internet connection ',
              style: TextStyle(fontSize: 16, color: Colors.red),
            
          );
        }
        else {
          // Access the data inside the snapshot
          List<Map<String, dynamic>> data = snapshot.data!;
          Map<String, dynamic> productData = data[0]; //  there is only one row
          print('hi from user');
          print(productData['product_name']);
         return SingleChildScrollView(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            child: showImage(productData['product_image'] ?? logo),
          ),
          SizedBox(height: 10),
          Row(children: [
            name(productData['product_name']),
            Spacer(),
            condition(productData['condition']),
          ],),
          SizedBox(height: 10),
           Row(children: [
            price(productData['price']),
            Spacer(),
          ],),

          SizedBox(height: 10),
          myLineDecoration(),

          SizedBox(height: 10),
          message(productData),
          myLineDecoration(),


          SizedBox(height: 10),
          myLineDecoration(),
          Text('Renter information:',style: titleTextStyle,),
          productOwner(productData['users']['name']),
          
          SizedBox(height: 10),
          
    
          
        ],
      ),);
  }}),
    ));
  }
 Widget myLineDecoration(){
  return Container(
          margin: EdgeInsets.only(top: 5,bottom: 5),
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
 Widget name(String name) {
    return Container(
      padding: EdgeInsets.only(left: 10.0),
      child: Text(
            name,
            textAlign: TextAlign.left,
            style: titleTextStyle,
          ),
    );
  }
  Widget location(String location ){
    return Container( 
          margin: EdgeInsets.only(top: 10.0,right: 5.0),
          child:Row(
          children:[
          Icon(
          Icons.location_on,
          color: midnightcolor,
          size: 20,
          ),
          SizedBox(width: 3),
          Text(
          location,
          style: paragraphTextStyle,
          ),
        ],));
  }
  Widget condition(String condition ){
    return Container( 
          margin: EdgeInsets.only(top: 10.0,right: 5.0),
          child:Row(
          children:[
          SizedBox(width: 3),
          Text(
          condition,
          style: PriceTextStyle,
          ),
        ],));
  }
  Widget price(int price){
    return Container(
      padding: EdgeInsets.only(left: 10.0),
          child: Text(
            '$price DA/day',
            textAlign: TextAlign.left,
            style: PriceTextStyle,
          ),
    );
  }

  Widget message(Map<String, dynamic> productData){
    return  Container(
      margin: EdgeInsets.all(10.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.9),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
           Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.chat,
                size: 20.0,
                color: Colors.blue,
              ),
              SizedBox(width: 8.0),
              Text(
                'Send renter a message',
                style: titleTextStyle,
               ),
            ],
          ),
          SizedBox(height: 8.0),
          TextFormField(
            initialValue: 'Is this equipment available?',
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
            borderSide: BorderSide(
              color: green, 
            ),
          ),
        ),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatScreen(
          receiverName: productData['owner name'],
          initialMessage: 'Is this equipment available?', // Set your message content
        ),
      ),
    );
            },
            style: ElevatedButton.styleFrom(
              primary: green, // Set the button's background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),

            child:Text(
              'Send',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget reviews() {
    return Container(
      child:  Column(
            children: [
              review(),
              review(),
            ],
          ),
    );
  }

Widget productOwner(String user){
    return  Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            height: 60,
            padding: EdgeInsets.all(8.0),
            margin: EdgeInsets.only(left:8.0,right: 8.0,top: 8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey[200], 
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
          Container(
            margin: EdgeInsets.only(left: 2.0),
            child :Text(user,
            style: titleTextStyle,
            textAlign: TextAlign.left,
          ),
          )
        ],
      );
  }
Widget review() {
  return Container(
    margin: EdgeInsets.only(top: 10.0),
    child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
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
                margin: EdgeInsets.all(5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        "Name",
                        style: reviewpersonnameTextStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Container(
                      child: Text(
                        "esikeidjecficdokmxksnjencjfenchfenv",
                        style: paragraphTextStyle,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      
  );
}
  Widget addReview(){
    return Row(
          children: [
            Container(
              width: 40,
              height: 40,
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
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
            
          ],);
  }
  Widget description() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description:',
          style: titleCategoryTextStyle,
        ),
        SizedBox(height: 10),
        Text(
          'Product Description goes here.hxhhxgshj Product Description goes here.hxhhxgshj Product Description goes here.hxhhxgshj',
          style: categoryTextStyle,
        ),
      ],
    );
  }
  Widget rentelRules() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Rentel Rules:',
          style: titleCategoryTextStyle,
        ),
        SizedBox(height: 10),
        Text(
          '.Product Description goes here\n.hxhhxgshj Product Description goes\n.hxhhxgshj Product Description goes here.hxhhxgshj',
          style: categoryTextStyle,
        ),
      ],
    );
  }
}