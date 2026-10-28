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

  bool isFavorite(String code) {
    return _favoriteCourses.any((c) => c.code == code);
  }

  void toggleFavorite(String code) {
    if (isFavorite(code)) {
      _favoriteCourses.removeWhere((c) => c.code == code);
    } else {
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

  // TAHAP 6: Fungsi penambah data di Provider
  Future<void> addCourse(Course course) async {
    try {
      // Disesuaikan: Memanggil createCourse dari repository Supabase
      final newCourse = await repository.createCourse(course);

      _courses.add(newCourse);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // TAHAP 7: Fungsi penghapus data di Provider
  Future<void> deleteCourse(Course course) async {
    if (course.id == null) return;

    try {
      await repository.deleteCourse(course.id!);
      _courses.removeWhere((c) => c.id == course.id);
      _favoriteCourses.removeWhere((c) => c.id == course.id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }

  // TAHAP 8: Fungsi update data di Provider
  Future<void> updateCourse(Course course) async {
    if (course.id == null) return;

    try {
      // Disesuaikan: Mengirimkan 2 argumen (id, course) dan tidak ditampung di variabel
      await repository.updateCourse(course.id!, course);

      final index = _courses.indexWhere((c) => c.id == course.id);

      if (index != -1) {
        // Disesuaikan: Langsung gunakan objek 'course' dari parameter untuk menimpa data lokal
        _courses[index] = course;

        final favIndex = _favoriteCourses.indexWhere((c) => c.id == course.id);
        if (favIndex != -1) {
          _favoriteCourses[favIndex] = course;
        }

        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}