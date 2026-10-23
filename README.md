# flutter_ui_fundamentals

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Dokumentasi REST API (Tahap 1)

Aplikasi ini terhubung dengan REST API untuk mengelola data mata kuliah (Course).
- **Endpoint URL:** `https://course-api-pearl.vercel.app/courses` *(Catatan: sesuaikan URL ini dengan link yang diberikan dosenmu jika ada)*
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