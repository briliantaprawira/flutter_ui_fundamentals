# Course Explorer v2

Aplikasi manajemen mata kuliah berbasis Flutter dengan implementasi:
- Arsitektur Provider dan Repository Pattern
- Operasi CRUD via REST API
- Tampilan UI yang responsif

## Cara Menjalankan
1. Clone repositori ini.
2. Jalankan `flutter pub get`.
3. Jalankan `flutter run`.

## Dokumentasi REST API (Tahap 1)

Aplikasi ini terhubung dengan REST API untuk mengelola data mata kuliah (Course).
- **Endpoint URL:** `https://course-api-pearl.vercel.app/courses`
- **HTTP Method:** GET
- **Status Code Sukses:** 200 OK
- **Struktur JSON yang Diterima:**
  ```json
  {
    "id": 1,
    "code": "MOB01",
    "title": "Git & GitHub",
    "credits": 2,
    "status": "active"
  }
  ```