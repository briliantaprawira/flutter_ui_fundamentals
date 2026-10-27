import '../models/course.dart';
import '../services/course_api_service.dart';

class CourseRepository {
  CourseRepository(this.service);

  final CourseApiService service;

  Future<List<Course>> getCourses() => service.getCourses();

  // TAHAP 6: Menghubungkan fungsi POST
  Future<Course> addCourse(Course course) => service.addCourse(course);

  // TAHAP 7: Menghubungkan fungsi DELETE
  Future<void> deleteCourse(int id) => service.deleteCourse(id);

  // TAHAP 8: Menghubungkan fungsi PUT
  Future<Course> updateCourse(Course course) => service.updateCourse(course);
}