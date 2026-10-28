import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Tambahan import Supabase
import 'services/course_supabase_service.dart'; // Ubah import ke layanan Supabase
import 'repositories/course_repository.dart';
import 'providers/course_provider.dart';
import 'screens/main_screen.dart'; 

void main() async {
  // TAHAP 10: Inisialisasi Supabase wajib dilakukan sebelum runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  // PENTING: Ganti URL dan anonKey di bawah ini dengan milikmu dari Dashboard Supabase!
 await Supabase.initialize(
    // Tambahkan tanda kutip tunggal di awal dan akhir URL
    url: 'https://xiydbqmtupnoriwoegiw.supabase.co', 
    
    // Tambahkan tanda kutip tunggal di awal dan akhir anonKey
    anonKey: 'sb_publishable_T9DfQ566EpHliQWceZPicQ_-lYiGMSk',
  );

  // GANTI layanan yang digunakan dari CourseApiService menjadi CourseSupabaseService
  final repository = CourseRepository(CourseSupabaseService());

  runApp(
    ChangeNotifierProvider(
      create: (context) => CourseProvider(repository: repository)..loadCourses(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}