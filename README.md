# Course Data Manager (Course Explorer v2)

Aplikasi manajemen data mata kuliah berbasis Flutter yang mengintegrasikan operasi CRUD penuh dengan backend Database PostgreSQL.

## Fitur Utama
- Menampilkan daftar mata kuliah secara real-time.
- Menambah (Create), Mengubah (Update), dan Menghapus (Delete) data mata kuliah.
- Fitur "Favorites" yang tersinkronisasi.
- Penanganan state yang komprehensif (Loading, Empty, Error, Success).

## Arsitektur & Teknologi
- **UI Framework:** Flutter (Responsive Navigation)
- **State Management:** Provider
- **Design Pattern:** Repository Pattern (Pemisahan antara UI, Provider, Repository, dan Service/Data Source).
- **Backend & Database:** Supabase (PostgreSQL via `supabase_flutter`).

## Cara Menjalankan Aplikasi
1. Clone repositori ini ke mesin lokal.
2. Jalankan `flutter pub get` di terminal untuk mengunduh semua dependencies.
3. Jalankan `flutter run` untuk memulai aplikasi (disarankan menggunakan platform Web/Chrome untuk menghindari isu cache).