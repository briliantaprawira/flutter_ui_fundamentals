import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../providers/course_provider.dart';

class CourseFormScreen extends StatefulWidget {
  // Variabel penampung data jika form dibuka untuk mode Edit
  final Course? course;

  const CourseFormScreen({super.key, this.course});

  @override
  State<CourseFormScreen> createState() => _CourseFormScreenState();
}

class _CourseFormScreenState extends State<CourseFormScreen> {
  // Controller untuk menangkap teks yang diketik pengguna
  final _codeController = TextEditingController();
  final _titleController = TextEditingController();
  final _creditsController = TextEditingController();
  String _selectedStatus = 'planned'; // Default value dropdown

  @override
  void initState() {
    super.initState();
    // Jika widget.course ada isinya (Mode Edit), isi form dengan data lama
    if (widget.course != null) {
      _codeController.text = widget.course!.code;
      _titleController.text = widget.course!.title;
      _creditsController.text = widget.course!.credits.toString();
      _selectedStatus = widget.course!.status;
    }
  }

  @override
  void dispose() {
    // Selalu bersihkan controller saat layar ditutup untuk mencegah memory leak
    _codeController.dispose();
    _titleController.dispose();
    _creditsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mengecek apakah ini mode edit atau tambah baru
    final isEditMode = widget.course != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditMode ? 'Edit Course' : 'Tambah Course'),
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextField(
              controller: _codeController,
              decoration: const InputDecoration(
                labelText: 'Kode Mata Kuliah',
                hintText: 'Misal: MB801',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Nama Mata Kuliah',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: _creditsController,
              decoration: const InputDecoration(
                labelText: 'SKS',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number, // Menampilkan keyboard angka
            ),
            const SizedBox(height: 16),

            DropdownButtonFormField<String>(
              value: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status',
                border: OutlineInputBorder(),
              ),
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
              onPressed: () async {
                // 1. Kumpulkan data dari form input
                final newCourse = Course(
                  id: widget.course?.id, // Tetap gunakan ID lama jika sedang diedit
                  code: _codeController.text,
                  title: _titleController.text,
                  credits: int.tryParse(_creditsController.text) ?? 0,
                  status: _selectedStatus,
                );

                final provider = context.read<CourseProvider>();

                // 2. Panggil fungsi yang sesuai (Update atau Add)
                if (isEditMode) {
                  await provider.updateCourse(newCourse);
                } else {
                  await provider.addCourse(newCourse);
                }

                // 3. Munculkan notifikasi (SnackBar) dan kembali ke layar utama
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isEditMode ? 'Course berhasil diperbarui!' : 'Course berhasil ditambahkan!'),
                      backgroundColor: Colors.green,
                      duration: const Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Simpan', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}