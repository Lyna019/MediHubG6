import 'package:flutter/material.dart';
import 'package:medihub_1/Screens/AddProduct.dart';
import 'package:medihub_1/Screens/profile.dart';
import 'package:medihub_1/Screens/search/search.dart';
import 'package:medihub_1/Screens/search/search.dart';
import '../Screens/chat_memb.dart';
import 'home.dart';
import 'profile.dart';
import 'chat.dart';
class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  late String initialReceiverName; // Use 'late' to indicate it will be initialized later

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    initialReceiverName = ''; // Set an empty string as the default value
    _screens = [
      HomeScreen(),
      Container(),
      AddProductPage(),
      ChatMembersScreen(),
      ProfileScreen(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (int index) {

          if(index==1){
              showSearch(context: context, delegate: DataSearch());
          }
         else{
           _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
         }
        },
        showSelectedLabels: false,
        showUnselectedLabels: false,
        iconSize: 29,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: Color(0xFF3CF6B5),
        unselectedItemColor: Color.fromARGB(255, 6, 4, 145),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Message',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
