import 'package:flutter/material.dart';
import 'pageindicator.dart';
import '../Screens/homeProducts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xffffffff),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(11, 11, 14, 10),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(14, 0, 12, 0),
                      height: 156,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: [
                          buildImage('assets/images/home.webp'),
                          buildImage('assets/images/image2.webp'),
                          buildImage('assets/images/image3.webp'),
                          buildImage('assets/images/image4.webp'),
                          buildImage('assets/images/image5.webp'),
                        ],
                      ),
                    ),
                    PageIndicator(currentPage: _currentPage, pageCount: 5),
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Text(
                      'Rent or Donate Medical',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.2125,
                        color: Color(0xff000000),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 41,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 75, 0),
                          constraints: BoxConstraints(maxWidth: 158),
                          child: RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                height: 1.2125,
                                color: Color(0xff000000),
                              ),
                              children: [
                                TextSpan(text: '   Find the equipment \n'),
                                TextSpan(
                                  text: '   And make a difference',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2125,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                         GestureDetector(
                 onTap: () {
    // Use Navigator to push the NavigationsScreen with the corresponding index
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeProducts(selectedCategory: 'All',), // Change 1 to the correct index for Mobility Aids
      ),
    );
  },
                  child:
                        Container(
                          width: 102,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xe52f8dfb),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              'Explore',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                height: 1.2125,
                                color: Color(0xffffffff),
                              ),
                            ),
                          ),
                        ),
                         ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(11, 9, 14, 54),
              width: double.infinity,
              height: 600,
              decoration: BoxDecoration(
                color: Color(0xff2f8cfa),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                    child: Text(
                      'Popular categories',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.2125,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(3, 0, 0, 19),
                    width: double.infinity,
                    height: 52,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                         GestureDetector(
                  onTap: () {
    // Use Navigator to push the NavigationsScreen with the corresponding index
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeProducts(selectedCategory: 'All',), // Change 1 to the correct index for Mobility Aids
      ),
    );
  },
                  child:
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 50, 0),
                          padding: EdgeInsets.fromLTRB(4, 7, 16, 6),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                               
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 18, 0),
                                width: 49,
                                height: 39,
                                child: Image.asset(
                                  'assets/images/HA.png', // Replace with actual URL
                                  width: 44,
                                  height: 39,
                                ),
                              ),
                                
                              Container(
                                constraints: BoxConstraints(maxWidth: 56),
                                child: Text(
                                  'Mobility Aids',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2125,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                        GestureDetector(
      onTap: () {
    // Use Navigator to push the NavigationsScreen with the corresponding index
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeProducts(selectedCategory: 'Mobility Aids',), // Change 1 to the correct index for Mobility Aids
      ),
    );
  },
      child:
                        Container(
                          padding: EdgeInsets.fromLTRB(8, 8, 9, 5),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 3, 0),
                                width: 47,
                                height: 39,
                                child: Image.asset(
                                  'assets/images/HB.png', // Replace with actual URL
                                  width: 47,
                                  height: 39,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 2),
                                constraints: BoxConstraints(maxWidth: 79),
                                child: Text(
                                  'Diagnostic \nequipment',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2125,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                  
                  Container(
                    margin: EdgeInsets.fromLTRB(3, 0, 0, 24),
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                         GestureDetector(
                 onTap: () {
    // Use Navigator to push the NavigationsScreen with the corresponding index
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeProducts(selectedCategory: 'Diagnostic Equipment',), // Change 1 to the correct index for Mobility Aids
      ),
    );
  },
                  child:
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 5, 53, 0),
                          padding: EdgeInsets.fromLTRB(7, 3, 19, 4),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                             
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 16, 3),
                                width: 40,
                                height: 30,
                                child: Image.asset(
                                  'assets/images/HC.png', // Replace with actual URL
                                  width: 33,
                                  height: 36,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 2, 0, 0),
                                constraints: BoxConstraints(maxWidth: 60),
                                child: Text(
                                  'Medical \nSupplie',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2125,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                          
                              
                            ],
                          ),
                          ),
                        
                        ),
                    
                    
                    
                     GestureDetector(
                 onTap: () {
    // Use Navigator to push the NavigationsScreen with the corresponding index
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomeProducts(selectedCategory: 'Medical Supplies',), // Change 1 to the correct index for Mobility Aids
      ),
    );
  },
                  child:
                        Container(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 12, 1),
                                width: 35,
                                height: 38,
                                child: Image.asset(
                                  'assets/images/HD.png', // Replace with actual URL
                                  width: 35,
                                  height: 38,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                                constraints: BoxConstraints(maxWidth: 83),
                                child: Text(
                                  'Medical \nequipment',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2125,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          ),
                        ),
                      ],
                    ),
                  
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 9),
                    child: Text(
                      'Donate',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 1.2125,
                        color: Color(0xffffffff),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                    width: double.infinity,
                    height: 52,
                    child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         GestureDetector(
                 onTap: () {
        // Add navigation logic for the first container
        // For example, Navigator.push(context, MaterialPageRoute(builder: (context) => YourNewPage()));
                            },
                  child:
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 53, 0),
                          padding: EdgeInsets.fromLTRB(8, 8, 19, 8),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 39,
                                height: 36,
                                child: Image.asset(
                                  'assets/images/HE.png', // Replace with actual URL
                                  width: 39,
                                  height: 36,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  'Medicines',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2125,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                          
                          
                            ],
                          ),
                          ),
                        ),
                         GestureDetector(
                 onTap: () {
        // Add navigation logic for the first container
        // For example, Navigator.push(context, MaterialPageRoute(builder: (context) => YourNewPage()));
                            },
                  child:
                        Container(
                          padding: EdgeInsets.fromLTRB(7, 8, 6, 6),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Color(0xffffffff),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 7, 0),
                                width: 35,
                                height: 38,
                                child: Image.asset(
                                  'assets/images/HD.png', // Replace with actual URL
                                  width: 35,
                                  height: 38,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 1),
                                constraints: BoxConstraints(maxWidth: 83),
                                child: Text(
                                  'Medical \nequipments',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    height: 1.2125,
                                    color: Color(0xff000000),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    ),
    );
  }
  
}
Widget buildImage(String imagePath) {
    return Container(
      margin: EdgeInsets.fromLTRB(14, 0, 12, 11),
      padding: EdgeInsets.fromLTRB(18, 12, 18, 9),
      width: double.infinity,
      height: 156,
      decoration: BoxDecoration(
        color: Color(0xe52f8dfb),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(imagePath),
          ),
        ),
      ),
    );
  }
  
  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: Image.asset(
        'assets/images/lg.png',
        width: 15,
        height: 20,
      ),
      title: Center(
        child: Text(
          'MediHub        ',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 25, 25, 112), // Midnight Blue
          ),
        ),
      ),
    );
  }

