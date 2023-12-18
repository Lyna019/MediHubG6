import 'package:medihub_1/color/colors.dart';

import '/commons/images.dart';
import '/commons/styles.dart';
import 'package:flutter/material.dart';
import 'package:medihub_1/Screens/chat.dart';

class ProductDetail extends StatefulWidget {
  List<String>? images;
  final data;
  ProductDetail({required this.images,this.data, Key? key}) : super(key: key);

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> with SingleTickerProviderStateMixin {
  List<String>? img;

  @override
  void initState() {
    super.initState();
    img = [widget.data['image']];
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
      child:SingleChildScrollView(
        child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300,
            child: showImages(),
          ),
          SizedBox(height: 10),
          Row(children: [
            name(widget.data['name']),
            Spacer(),
            score(4.5),
          ],),
          SizedBox(height: 10),
           Row(children: [
            price(widget.data['price']),
            Spacer(),
            location('location'),
          ],),

          SizedBox(height: 10),
          myLineDecoration(),

          SizedBox(height: 10),
          message(),
          myLineDecoration(),

          SizedBox(height: 10),
          myLineDecoration(),
          description(),
          SizedBox(height: 10),
          myLineDecoration(),

          SizedBox(height: 10),
          myLineDecoration(),
          rentelRules(),
          SizedBox(height: 10),
          myLineDecoration(),

          SizedBox(height: 10),
          myLineDecoration(),
          Text('Renter information:',style: titleTextStyle,),
          productOwner(),
          SizedBox(height: 10),
          myLineDecoration(),

          SizedBox(height: 20),
          myLineDecoration(),
          Text('Reviews:',style: titleTextStyle,),
          reviews(),
          
        ],
      ),)
    ),
    );
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
  Widget showImages() {
    return PageView.builder(
      itemCount:img != null ? widget.images!.length : 0,
      itemBuilder: (context, index) {
        return Image.asset(
          img![index],
          width: double.infinity,
          fit: BoxFit.contain,
        );
      },
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

  Widget price(String price){
    return Container(
      padding: EdgeInsets.only(left: 10.0),
          child: Text(
            '$price DA/day',
            textAlign: TextAlign.left,
            style: PriceTextStyle,
          ),
    );
  }
  Widget score(double score) {
    score = score.clamp(0.0, 5.0);
    return Row(
          children: [
            Row(
              children: List.generate(
                score.floor(),
                (index) => Icon(Icons.star, color: Colors.orange,size: 20,),
              ),
            ),
            if ((score - score.floor()) > 0) Icon(Icons.star_half, color: Colors.orange,size: 20,),
          ],
        );
  }
  Widget message(){
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
          receiverName: widget.data['owner name'],
          initialMessage: 'Is this equipment available?', // Set your message content
        ),
      ),
    );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: green, // Set the button's background color
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

Widget productOwner(){
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
            child :Text(widget.data['owner name'],
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