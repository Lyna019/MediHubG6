import 'package:flutter/material.dart';
import 'package:medihub_1/Screens/product/productDetail.dart';
import '../myresault.dart';
import '../../../commons/images.dart';
import '../../../Supabase/databasefunctions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataSearch extends SearchDelegate{
  final myProducts = DatabaseFunctions().getProductsRentAll();
  final myProductsName= DatabaseFunctions().getProductsDonateAll();

  Future<List<Map<String, dynamic>>> filterByProductName(String query) async {
    final products = await myProducts;
    List<Map<String, dynamic>> filteredProducts = products
         .where((product) =>
        product['product_name']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
    .toList();
    print(query);

    return filteredProducts;
  }

  
  @override
  List<Widget>? buildActions(BuildContext context) {
    
    return [
      IconButton(onPressed:(){
        query='';
      }, 
      icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: ( ) {
           close(context, null);
      },
     icon: Icon(Icons.arrow_back, ));
  }

  @override
Widget buildResults(BuildContext context) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: filterByProductName(query),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading data'));
      }

      final data = snapshot.data;

      if (data == null || data.isEmpty) {
        return Center(child: Text('No results found.'));
      }

      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
                onTap: () {
                  print('---------------------------------------------------------------------------------------------------------');
                  print(data[index]['id']);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        productId: data[index]['id'] ?? 'Default Value',
                      ),
                    ),
                  );
                },
                child:  MyProduct( 
                image: data[index]['product_image'] ?? logo, 
                name: data[index]['product_name'] ?? 'Default Name', 
                price: data[index]['price'] ?? 'Default price', condition: 
                data[index]['condition']??'good',),
        
              );
        },
      );
    },
  );
}


  @override
  Widget buildSuggestions(BuildContext context) {
    if(query=='')
    {
       return allSuggestions(myProducts)  ;
    }
    else {
       return allSuggestions(filterByProductName(query))  ;
    }
    
  }
Widget allSuggestions(Future<List<Map<String, dynamic>>> myFuture) {
  return FutureBuilder<List<Map<String, dynamic>>>(
    future: myFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }
      if (snapshot.hasError) {
        return const Center(child: Text('Error loading data'));
      }

      final data = snapshot.data;
      print('data===========================================================================');
      print(data);

      return ListView.builder(
        itemCount: data?.length ?? 0,
        itemBuilder: (context, index) {
          return containerSuggestions(data?[index]['product_name'] ?? 'Default Name');
        },
      );
    },
  );
}
  Widget result(String q){
    return FutureBuilder<List<Map<String, dynamic>>>(
    future: filterByProductName(q),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return const Center(child: Text('Error loading data'));
      }

      final data = snapshot.data;

      if (data == null || data.isEmpty) {
        return Center(child: Text('No results found.'));
      }

      return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return InkWell(
                onTap: () {
                  print('---------------------------------------------------------------------------------------------------------');
                  print(data[index]['id']);
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        productId: data[index]['id'] ?? 'Default Value',
                      ),
                    ),
                  );
                },
                child:  MyProduct( 
                image: data[index]['product_image'] ?? logo, 
                name: data[index]['product_name'] ?? 'Default Name', 
                price: data[index]['price'] ?? 'Default price', condition: 
                data[index]['condition']??'good',),
        
              );
        },
      );
    },
  );

  }
  Widget containerSuggestions(String? suggestion){
    return Container(
      child: InkWell(
                onTap: () {
                  print('---------------------------------------------------------------------------------------------------------');
                  query=suggestion!;
                },
                child:Row(children: [
        IconButton(onPressed: (){}, icon:Icon(Icons.search),),
        Text('${suggestion}'),
        Spacer(),
        RotationTransition(
           turns: AlwaysStoppedAnimation(45 / 360), // 45 degrees in radians
           child:  IconButton(
                     onPressed: (){
                        query=suggestion!;
                      }, 
                      icon:Icon(Icons.arrow_back),),
        ),
      ]),
              ),
    );
  }
}