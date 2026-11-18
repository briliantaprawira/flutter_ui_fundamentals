import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

// Memanggil file yang benar dari folder pages
import 'pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // 2. Inisialisasi Supabase (PASTIKAN MENGGANTI INI DENGAN KODE ASLIMU!)
  await Supabase.initialize(
    url: 'https://xiydbqmtupnoriwoegiw.supabase.co',
    anonKey: 'sb_publishable_T9DfQ566EpHliQWceZPicQ_-lYiGMSk',
  );

  runApp(const KosFinderApp());
}

class KosFinderApp extends StatelessWidget {
  const KosFinderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KosFinder',
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      // Menggunakan LoginPage, bukan LoginScreen
      home: const LoginPage(),
    );
  }
}