class Student {
  final int id;
  final String name;
  final String studentId;
  final String email;

  const Student({
    required this.id,
    required this.name,
    required this.studentId,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      studentId: json['student_id'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'student_id': studentId,
      'email': email,
    };
  }
}
