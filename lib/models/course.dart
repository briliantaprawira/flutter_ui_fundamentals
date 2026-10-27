class Course {
  final int? id; // id dari database (bisa null kalau baru dibuat)
  final String code;
  final String title;
  final int credits;
  final String status;

  const Course({
    this.id,
    required this.code,
    required this.title,
    required this.credits,
    this.status = 'planned',
  });

  // Fungsi untuk mengubah JSON dari API menjadi objek Course Dart
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int?,
      code: json['code'] as String,
      title: json['title'] as String,
      credits: json['credits'] as int,
      status: (json['status'] as String?) ?? 'planned',
    );
  }

  // Fungsi untuk mengubah objek Course Dart menjadi JSON untuk dikirim ke API
  Map<String, dynamic> toJson() => {
    'code': code,
    'title': title,
    'credits': credits,
    'status': status,
  };
}