import '../models/course.dart';
import '../services/course_supabase_service.dart';

class CourseRepository {
  final CourseSupabaseService api;

  CourseRepository(this.api);

  Future<List<Course>> getCourses() async {
    return await api.getCourses();
  }

  Future<Course> createCourse(Course course) async {
    return await api.createCourse(course);
  }

  Future<void> updateCourse(int id, Course course) async {
    await api.updateCourse(id, course);
  }

  Future<void> deleteCourse(int id) async {
    await api.deleteCourse(id);
  }
}