import 'package:flutter/material.dart';
import '../../Supabase/databasefunctions.dart';
import './myproduct.dart';
import '/commons/styles.dart';
import '/commons/images.dart';
import './editproduct.dart';

class MyProducts extends StatefulWidget {
  final int userId;

  MyProducts({required this.userId, Key? key}) : super(key: key);

  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  late Future<List<Map<String, dynamic>>> userProducts =
      DatabaseFunctions().getProductsOfUserById(widget.userId);

  @override
  void initState() {
    super.initState();
  }

  Future<void> _refresh() async {
    setState(() {
      userProducts = DatabaseFunctions().getProductsOfUserById(widget.userId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My List',
          style: titleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.blue,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Material(
        child: Container(
          color: Colors.white,
          child: RefreshIndicator(
            onRefresh: _refresh,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder<List<Map<String, dynamic>>>(
                    future: userProducts,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error loading data'));
                      }
                      else if (snapshot.hasError && snapshot.connectionState == ConnectionState.done) {
          // Display a generic error message for any type of error
          return  Text(
              'No internet connection ',
              style: TextStyle(fontSize: 16, color: Colors.red),
            
          );
        }
                      final userProducts = snapshot.data;

                      if (userProducts == null || userProducts.isEmpty) {
                        return Center(child: Text('No products found.'));
                      }

                      return GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1,
                          mainAxisExtent: 200,
                        ),
                        itemCount: userProducts.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: MyProduct(
                              image: userProducts[index]['product_image'] ??
                                  logo,
                              name: userProducts[index]['product_name'],
                              price: userProducts[index]['price'],
                              onDelete: () async {
                                try {
                                  await DatabaseFunctions()
                                      .deleteProduct(
                                          userProducts[index]['id']);
                                  _refresh(); // Reload the products after deletion
                                } catch (error) {
                                  print('Error deleting product: $error');
                                }
                              },
                              onEdit: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditProductDetail(
                                        productId: userProducts[index]['id'] ??
                                            'Default Value'),
                                  ),
                                );

                                // Check if there is a result and update the UI accordingly
                                if (result != null) {
                                  _refresh(); // Reload the products after editing
                                }
                              },
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
