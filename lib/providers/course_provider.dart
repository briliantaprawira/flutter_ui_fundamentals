import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  final CourseRepository repository;
  CourseProvider({required this.repository});

  final Set<String> _favorites = {};
  Set<String> get favorites => _favorites;

  // TAHAP 13: Helper untuk mengecek apakah suatu course difavoritkan
  bool isFavorite(String code) => _favorites.contains(code);

  // TAHAP 13: Helper untuk mendapatkan daftar objek Course yang difavoritkan
  List<Course> get favoriteCourses {
    return courses.where((c) => _favorites.contains(c.code)).toList();
  }

  List<Course> courses = [];
  bool isLoading = false;
  String? error;

  void toggleFavorite(String courseId) {
    if (_favorites.contains(courseId)) {
      _favorites.remove(courseId);
    } else {
      _favorites.add(courseId);
    }
    // notifyListeners(); <--- Buat ini menjadi komentar untuk simulasi error
  }

  Future<void> loadCourses() async {
    isLoading = true;
    error = null;
    notifyListeners();
    try {
      courses = await repository.getCourses();
    } catch (e) {
      error = e.toString();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}