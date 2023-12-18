 import 'package:flutter/material.dart';

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

