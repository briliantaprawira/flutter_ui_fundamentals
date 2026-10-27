import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseFormScreen extends StatefulWidget {
  // Variabel untuk menampung data jika form digunakan untuk Edit
  final Course? course;

  const CourseFormScreen({super.key, this.course});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  // Controller untuk membaca ketikan pengguna di layar
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _creditsController = TextEditingController();
  String _selectedStatus = 'planned';

  @override
  void initState() {
    super.initState();
    // Jika ada data (Mode Edit), isi kolom teks dengan data lama
    if (widget.course != null) {
      _codeController.text = widget.course!.code;
      _titleController.text = widget.course!.title;
      _creditsController.text = widget.course!.credits.toString();
      _selectedStatus = widget.course!.status;
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course == null ? 'Tambah Course' : 'Edit Course'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(labelText: 'Kode Mata Kuliah (Misal: MB801)'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Nama Mata Kuliah'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _creditsController,
              decoration: const InputDecoration(labelText: 'SKS'),
              keyboardType: TextInputType.number, // Munculkan keyboard angka
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(labelText: 'Status'),
              items: const [
                DropdownMenuItem(value: 'planned', child: Text('Planned')),
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'done', child: Text('Done')),
              ],
              onChanged: (value) {
                if (value != null) {
                  setState(() {
                    _selectedStatus = value;
                  });
                }
              },
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue.shade700,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              // DI SINILAH LOGIKA TAHAP 9 DITEMPATKAN
              onPressed: () async {
                final newCourse = Course(
                  id: widget.course?.id,
                  code: _codeController.text,
                  title: _titleController.text,
                  credits: int.tryParse(_creditsController.text) ?? 0,
                  status: _selectedStatus,
                );

                final provider = context.read<CourseProvider>();

                // Panggil provider untuk Update (PUT) atau Add (POST)
                if (newCourse.id != null) {
                  await provider.updateCourse(newCourse);
                } else {
                  await provider.addCourse(newCourse);
                }

                // Tutup form kembali ke halaman depan
                if (mounted) Navigator.pop(context);
              },
              child: const Text('Simpan', style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}