import 'package:flutter/material.dart';
import 'models/course.dart';
import 'repositories/course_repository.dart';

// TAHAP 11: Provider mengelola Async State (Loading, Data, Error)
class CourseProvider extends ChangeNotifier {
  // Provider kini bergantung pada Repository untuk mengambil data
  final CourseRepository repository;

  CourseProvider({required this.repository});

  // State untuk Data Favorit (dari Tahap 5)
  final Set<String> _favorites = {};
  Set<String> get favorites => _favorites;

  // State untuk Async Data Mata Kuliah
  List<Course> courses = [];
  bool isLoading = false;
  String? error;

  void toggleFavorite(String courseId) {
    if (_favorites.contains(courseId)) {
      _favorites.remove(courseId);
    } else {
      _favorites.add(courseId);
    }
    notifyListeners();
  }

  // Method untuk mengambil data dari Repository
  Future<void> loadCourses() async {
    isLoading = true; // Set status ke Loading
    error = null;     // Bersihkan error sebelumnya (jika ada)
    notifyListeners(); // Beritahu UI untuk menampilkan animasi Loading

    try {
      courses = await repository.getCourses(); // Minta data ke Repository
    } catch (e) {
      error = e.toString(); // Tangkap error jika terjadi kegagalan
    } finally {
      isLoading = false; // Matikan status Loading
      notifyListeners(); // Beritahu UI bahwa proses selesai (baik sukses maupun error)
    }
  }
}