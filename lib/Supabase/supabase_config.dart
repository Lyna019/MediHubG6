import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static void initializeSupabase() async {
    await Supabase.initialize(
      url: 'https://eookpobfniytgmprafet.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVvb2twb2Jmbml5dGdtcHJhZmV0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1OTExMzcsImV4cCI6MjAxODE2NzEzN30.RcpPNSGpBC1Ji-iH7HpaXMC9Imkn-cs-MM_aUoBI01k',
  );
  }
}
final supabase = Supabase.instance.client;
