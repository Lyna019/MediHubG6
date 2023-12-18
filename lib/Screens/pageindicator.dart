import 'package:flutter/material.dart';
import 'package:medihub_1/color/colors.dart';
class PageIndicator extends StatelessWidget {
  final int currentPage;
  final int pageCount;

  PageIndicator({required this.currentPage, required this.pageCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          pageCount,
          (index) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            width: 16.0,
            height: 8.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: index == currentPage ? Colors.blue : midnightcolor,
            ),
          ),
        ),
      ),
    );
  }
}