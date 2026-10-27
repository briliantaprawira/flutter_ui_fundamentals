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
  // TAHAP 6: Fungsi penambah data di Provider
  Future<void> addCourse(Course course) async {
    try {
      // Kirim data ke API
      final newCourse = await repository.addCourse(course);

      // Jika berhasil, tambahkan data tersebut ke daftar lokal di layar
      _courses.add(newCourse);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  // TAHAP 7: Fungsi penghapus data di Provider
  Future<void> deleteCourse(Course course) async {
    // Pastikan course memiliki ID dari database sebelum dihapus
    if (course.id == null) return;

    try {
      // 1. Hapus data dari API (database internet)
      await repository.deleteCourse(course.id!);

      // 2. Hapus data dari daftar utama di layar
      _courses.removeWhere((c) => c.id == course.id);

      // 3. Hapus juga dari daftar favorit (jika kebetulan sedang difavoritkan)
      _favoriteCourses.removeWhere((c) => c.id == course.id);

      notifyListeners(); // Perbarui UI agar kartu course langsung hilang
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
  // TAHAP 8: Fungsi update data di Provider
  Future<void> updateCourse(Course course) async {
    try {
      // 1. Kirim data pembaruan ke API
      final updatedCourse = await repository.updateCourse(course);

      // 2. Cari posisi (index) data lama di dalam list _courses
      final index = _courses.indexWhere((c) => c.id == course.id);

      if (index != -1) {
        // 3. Timpa data lama dengan data baru hasil balikan dari server
        _courses[index] = updatedCourse;

        // 4. Perbarui juga di daftar favorit jika mata kuliah tersebut disukai
        final favIndex = _favoriteCourses.indexWhere((c) => c.id == course.id);
        if (favIndex != -1) {
          _favoriteCourses[favIndex] = updatedCourse;
        }

        notifyListeners(); // Render ulang UI agar perubahan teks terlihat
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
    }
  }
}