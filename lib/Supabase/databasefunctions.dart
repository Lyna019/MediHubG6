import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:medihub_1/Supabase/supabase_config.dart';
class DatabaseFunctions {
  static final _instance = DatabaseFunctions._internal();

  factory DatabaseFunctions() {
    return _instance;
  }
  DatabaseFunctions._internal();

  Future<List<Map<String, dynamic>>> getProductsRentAll() async {
    final data = await supabase
      .from('products')
      .select('*')
      .not('price', 'eq', 0) ;
    return data;
  }
  Future<List<Map<String, dynamic>>> getProductsDonateAll() async {
    final data = await supabase
      .from('products')
      .select('*')
      .eq('price', 0);
    return data;
  }
  Future<List<Map<String, dynamic>>> getProductsRentByCategory(int category_id) async {
    final data = await supabase
      .from('products')
      .select('*')
      .eq('category_id', category_id)
      .not('price', 'eq', 0);
      print('===================================================================================================');
      print(data);
      return data;
  }
  Future<List<Map<String, dynamic>>> getProductsDonateByCategory(int category_id) async {
    final data = await supabase
      .from('products')
      .select('*')
      .eq('category_id', category_id)
      .eq('price', 0);
      print('===================================================================================================');
      print(data);
      return data;
  }
  Future<List<Map<String, dynamic>>> getProductsOfUserById(int userId) async {
    final data = await supabase
      .from('products')
      .select('*')
      .eq('user_id', userId);

      print('==========================================getProductsOfUserById================================================');
      print(userId);
      print(data);
      return data;
  }
   Future<void> deleteProduct( int productId) async {
    // Perform the update operation using Supabase
    // Example: Update product where id matches productId
    
  await supabase
  .from('products')
  .delete()
  .match({ 'id': productId });
    
  }
  Future<void> updateProduct(String name,int price,String condition,int productId) async {
    
    await supabase
        .from('products')
        .update({
          'product_name': name,
          'price': price,
          'condition': condition,
        })
        .eq('id', productId);

    // Handle the updated product as needed
  }
  Future<List<Map<String, dynamic>>> getRowProductById(int id) async {
    final data = await supabase
      .from('products')
      .select('*,users!inner(name)')
      .eq('id', id);
      print('===================================================================================================');
      print(data);
      return data;
  }
  Future<List<Map<String, dynamic>>> getUserById(int id) async {
    final data = await supabase
      .from('users')
      .select('name')
      .eq('id', id);
      print('=================================fromUsers========================================================');
      print(data);
      return data;
  }


}