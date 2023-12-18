import 'package:flutter/material.dart';
import 'package:medihub_1/color/colors.dart';

class SearchResult {
  final String imageUrl;
  final double price;
  final String providerName;

  SearchResult({
    required this.imageUrl,
    required this.price,
    required this.providerName,
  });
}

class SearchPageres extends StatelessWidget {
  final List<SearchResult> recommendedResults = [
    SearchResult(
      imageUrl: 'assets/images/home.webp',
      price: 10.0,
      providerName: 'Provider 1',
    ),
    SearchResult(
      imageUrl: 'assets/images/home.webp',
      price: 15.0,
      providerName: 'Provider 2',
    ),
    SearchResult(
      imageUrl: 'assets/images/home.webp',
      price: 15.0,
      providerName: 'Provider 2',
    ),
  ];
  List<SearchResult> locationResults = [
    SearchResult(
      imageUrl: 'assets/images/home.webp',
      price: 25.0,
      providerName: 'Provider 4',
    ),
    SearchResult(
      imageUrl: 'assets/images/home.webp',
      price: 30.0,
      providerName: 'Provider 5',
    ),
    SearchResult(
      imageUrl: 'assets/images/home.webp',
      price: 35.0,
      providerName: 'Provider 6',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CenteredTextWidget(
                dynamicText:
                    'Explore The wide range of equipment under Your Interest'),
            _buildResultSection(context, 'Paid', recommendedResults),
            _buildResultSectionloc(context, 'Donation ', locationResults),
          ],
        ),
      ),
    );
  }

  Widget _buildResultSectionloc(
      BuildContext context, String title, List<SearchResult> results) {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 190,
            height: 30,
            decoration: BoxDecoration(
              color: midnightcolor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
              ),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 233, 238, 242),
              ),
            ),
          ),
          SizedBox(height: 18.0),
          Container(
            height: 200.0,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: Color.fromARGB(255, 145, 198, 255),
                          width: 2.0),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    width: 150.0,
                    margin: EdgeInsets.only(right: 8.0),
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30.0),
                          child: Image.asset(
                            result.imageUrl,
                            width: 130.0,
                            height: 120.0,
                          ),
                        ),
                        SizedBox(height: 18.0),
                        Text(
                          'FREE',
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: midnightcolor,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          result.providerName,
                          style: TextStyle(
                            color: midnightcolor,
                            fontSize: 14.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection(
    BuildContext context, String title, List<SearchResult> results) {
  return Container(
    margin: EdgeInsets.only(
      top: 20,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 190,
          height: 30,
          decoration: BoxDecoration(
            color: midnightcolor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10.0),
              bottomRight: Radius.circular(10.0),
            ),
          ),
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 233, 238, 242),
            ),
          ),
        ),
        SizedBox(height: 18.0),
        Container(
          height: 200.0,
          width: MediaQuery.of(context)
              .size
              .width, // Ensure proper width constraints
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              final result = results[index];
              return GestureDetector(
                onTap: () {
                  // Handle the tap gesture, for example, navigate to a detail page
                 
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.blue,
                        width: 2.0), // Set the border color and width
                    borderRadius:
                        BorderRadius.circular(12.0), // Set the border radius
                  ),
                  width: 150.0,
                  margin: EdgeInsets.only(right: 8.0),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                            30.0), // Adjust the border radius
                        child: Image.asset(
                          result.imageUrl,
                          width: 130.0,
                          height: 120.0,
                        ),
                      ),
                      SizedBox(height: 18.0),
                      Text(
                        '\$${result.price.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: midnightcolor),
                      ),
                      SizedBox(height: 4.0),
                      Text(
                        result.providerName,
                        style: TextStyle(
                          color: midnightcolor,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );
}

}

class CenteredTextWidget extends StatelessWidget {
  final String dynamicText;

  CenteredTextWidget({required this.dynamicText});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          top: 30,
        ),
        child: Text(
          dynamicText,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 29, 147, 243),
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
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
