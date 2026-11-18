import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService.instance.currentUser;
    return Scaffold(
      appBar: AppBar(title: const Text('KosFinder Home')),
      body: Center(child: Text('Berhasil Login sebagai:\n${user?.email ?? '-'}', textAlign: TextAlign.center, style: const TextStyle(fontSize: 18))),
    );
  }
}