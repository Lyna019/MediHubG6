import 'package:flutter/material.dart';
import 'Screens/splash.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get/get.dart';
import 'package:medihub_1/Screens/controllers/productcontroller.dart';
 
  



const supabaseUrl = 'https://eookpobfniytgmprafet.supabase.co';
const supabaseKey = String.fromEnvironment('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVvb2twb2Jmbml5dGdtcHJhZmV0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1OTExMzcsImV4cCI6MjAxODE2NzEzN30.RcpPNSGpBC1Ji-iH7HpaXMC9Imkn-cs-MM_aUoBI01k');

Future<void> main() async {
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseKey);
  runApp(MyApp());
}
final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Get.put(ProductController());
   
    return MaterialApp(
     home: SplashScreen(),
    );
  }
}

