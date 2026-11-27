class Admin {
  final int id;
  final String name;
  final String email;
  final String department;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      // Karena menggunakan mock API umum (JSONPlaceholder), kita petakan company name atau beri default
      department: json['company']?['name'] ?? json['department'] ?? 'IT Department',
    );
  }
}