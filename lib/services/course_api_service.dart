import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/course.dart';

class CourseApiService {
  CourseApiService(this.baseUrl);
  final String baseUrl;

  // Fungsi GET (Tahap 4)
  Future<List<Course>> getCourses() async {
    final response = await http.get(Uri.parse('$baseUrl/courses'));
    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil course');
    }
    final List data = jsonDecode(response.body) as List;
    return data.map((e) => Course.fromJson(e as Map<String, dynamic>)).toList();
  }

  // TAHAP 6: Fungsi POST untuk tambah data
  Future<Course> addCourse(Course course) async {
    final response = await http.post(
      Uri.parse('$baseUrl/courses'),
      headers: {'Content-Type': 'application/json'}, // Wajib untuk POST JSON
      body: jsonEncode(course.toJson()), // Ubah objek Dart jadi teks JSON
    );

    // Status 201 artinya "Created" (berhasil dibuat)
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Course.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception('Gagal menambahkan course');
    }
  }
  // TAHAP 7: Fungsi DELETE untuk menghapus data
  Future<void> deleteCourse(int id) async {
    // Endpoint delete biasanya membutuhkan ID spesifik di URL
    final response = await http.delete(Uri.parse('$baseUrl/courses/$id'));

    // Status 200 (OK) atau 204 (No Content) menandakan berhasil dihapus
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Gagal menghapus course');
    }
  }
}