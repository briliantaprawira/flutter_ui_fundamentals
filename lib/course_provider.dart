import 'package:flutter/material.dart';

// TAHAP 5: Membuat class state yang mewarisi ChangeNotifier
class CourseProvider extends ChangeNotifier {
  // Menggunakan Set (bukan List) agar tidak ada duplikasi ID favorit
  final Set<String> _favorites = {};

  // Getter untuk membaca data dari luar
  Set<String> get favorites => _favorites;

  // Method untuk menambah/menghapus favorit
  void toggleFavorite(String courseId) {
    if (_favorites.contains(courseId)) {
      _favorites.remove(courseId); // Hapus jika sudah ada
    } else {
      _favorites.add(courseId); // Tambah jika belum ada
    }

    // SANGAT PENTING: Memberi tahu UI agar merender ulang bagian yang berubah
    notifyListeners();
  }
}