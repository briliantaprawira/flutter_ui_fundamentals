import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;
  const CourseCard({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: ListTile(
        leading: const Icon(Icons.school, color: Colors.blueAccent),
        title: Text(course.title),
        subtitle: Text('Kode: ${course.code} | ${course.credits} SKS'),
        trailing: Text(course.status, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)),
      ),
    );
  }
}