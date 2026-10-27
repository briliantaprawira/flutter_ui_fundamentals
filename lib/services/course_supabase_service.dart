import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course.dart';
import 'course_data_source.dart';

class CourseSupabaseService implements CourseDataSource {
  final supabase = Supabase.instance.client;

  // TAHAP 12: Membaca data (SELECT)
  @override
  Future<List<Course>> getCourses() async {
    final data = await supabase
        .from('courses')
        .select()
        .order('id');
    return (data as List)
        .map((e) => Course.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // TAHAP 13: Menambah data (INSERT)
  @override
  Future<Course> createCourse(Course course) async {
    final row = await supabase
        .from('courses')
        .insert(course.toJson())
        .select()
        .single();
    return Course.fromJson(row);
  }

  // TAHAP 14: Mengubah data (UPDATE)
  @override
  Future<void> updateCourse(int id, Course course) async {
    await supabase
        .from('courses')
        .update(course.toJson())
        .eq('id', id);
  }

  // TAHAP 15: Menghapus data (DELETE)
  @override
  Future<void> deleteCourse(int id) async {
    await supabase
        .from('courses')
        .delete()
        .eq('id', id);
  }
}