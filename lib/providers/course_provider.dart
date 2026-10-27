import 'package:flutter/material.dart';
import '../models/course.dart';
import '../repositories/course_repository.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider({required this.repository});

  final CourseRepository repository;

  List<Course> _courses = [];
  List<Course> get courses => _courses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  // === FITUR FAVORIT YANG DISESUAIKAN ===
  final List<Course> _favoriteCourses = [];

  List<Course> get favoriteCourses => _favoriteCourses;
  List<Course> get favorites => _favoriteCourses;

  // Menerima String (kode) dari UI
  bool isFavorite(String code) {
    return _favoriteCourses.any((c) => c.code == code);
  }

  // Menerima String (kode) dari UI
  void toggleFavorite(String code) {
    if (isFavorite(code)) {
      _favoriteCourses.removeWhere((c) => c.code == code);
    } else {
      // Cari course asli dari daftar _courses berdasarkan kodenya
      try {
        final courseToAdd = _courses.firstWhere((c) => c.code == code);
        _favoriteCourses.add(courseToAdd);
      } catch (e) {
        debugPrint('Course tidak ditemukan');
      }
    }
    notifyListeners();
  }
  // =======================================

  Future<void> loadCourses() async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      _courses = await repository.getCourses();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}