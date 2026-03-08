class Admin {
  final int id;
  final String username;
  final String email;
  final String role;
  final DateTime? createdAt;

  Admin({
    required this.id,
    required this.username,
    required this.email,
    required this.role,
    this.createdAt,
  });

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'role': role,
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
