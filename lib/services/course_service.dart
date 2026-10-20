import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart'; // Import ini yang menghilangkan error debugPrint
import '../models/course.dart';

// TAHAP 9: Memisahkan proses baca data ke layer Service
class CourseService {
  // Fungsi asinkron untuk memuat daftar course
  Future<List<Course>> loadCourses() async {
    try {
      // Mencoba membaca file JSON dari assets
      final jsonString = await rootBundle.loadString('student_data.json');
      final data = jsonDecode(jsonString) as Map<String, dynamic>;
      final list = data['courses'] as List<dynamic>;

      // Melakukan konversi dari List<dynamic> menjadi List<Course>
      return list.map((e) => Course.fromJson(e as Map<String, dynamic>)).toList();

    } catch (e) {
      // FALLBACK: Jika file JSON tidak ditemukan, kita kembalikan data simulasi
      debugPrint('File JSON gagal dibaca, menggunakan data simulasi: $e');
      final mockJson = '''
      {
        "courses": [
          {"code": "MOB09-A", "title": "Data Source (Mock)", "credits": 2, "status": "Active"},
          {"code": "MOB09-B", "title": "Service Layer (Mock)", "credits": 3, "status": "Planned"}
        ]
      }
      ''';
      final data = jsonDecode(mockJson) as Map<String, dynamic>;
      final list = data['courses'] as List<dynamic>;
      return list.map((e) => Course.fromJson(e as Map<String, dynamic>)).toList();
    }
  }
}