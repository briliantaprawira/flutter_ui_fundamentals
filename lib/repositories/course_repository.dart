import '../models/course.dart';
import '../services/course_service.dart';

// TAHAP 10: Membuat Repository sebagai abstraksi sumber data
class CourseRepository {
  // Repository membutuhkan Service untuk melakukan tugas kasarnya
  final CourseService service;

  // Constructor menerima service yang disuntikkan (Dependency Injection)
  CourseRepository(this.service);

  // Method yang akan dipanggil oleh Provider/UI nantinya
  Future<List<Course>> getCourses() {
    return service.loadCourses();
  }
}