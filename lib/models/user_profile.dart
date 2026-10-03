class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    this.university = '',
    this.studyLevel = '',
    this.specialty = '',
    this.bio = '',
    this.interests = const [],
    this.photoPath,
    this.photoUrl,
    required this.createdAt,
    this.updatedAt,
  });

  final String name;
  final String email;
  final String university;
  final String studyLevel;
  final String specialty;
  final String bio;
  final List<String> interests;
  final String? photoPath;

  /// Remote photo (Google account), used when there is no local photo.
  final String? photoUrl;
  final DateTime createdAt;
  final DateTime? updatedAt;

  String get firstName {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '';
    return trimmed.split(RegExp(r'\s+')).first;
  }

  String get initials {
    final parts = name
        .trim()
        .split(RegExp(r'\s+'))
        .where((part) => part.isNotEmpty)
        .toList();
    if (parts.isEmpty) return '?';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  /// Share of optional profile fields that are filled (0-100).
  int get completeness {
    final fields = [
      name.isNotEmpty,
      university.isNotEmpty,
      studyLevel.isNotEmpty,
      specialty.isNotEmpty,
      bio.isNotEmpty,
      interests.isNotEmpty,
      photoPath != null || photoUrl != null,
    ];
    return (fields.where((filled) => filled).length * 100 / fields.length)
        .round();
  }

  UserProfile copyWith({
    String? name,
    String? university,
    String? studyLevel,
    String? specialty,
    String? bio,
    List<String>? interests,
    String? photoPath,
    String? photoUrl,
    bool clearPhoto = false,
    DateTime? updatedAt,
  }) => UserProfile(
    name: name ?? this.name,
    email: email,
    university: university ?? this.university,
    studyLevel: studyLevel ?? this.studyLevel,
    specialty: specialty ?? this.specialty,
    bio: bio ?? this.bio,
    interests: interests ?? this.interests,
    photoPath: clearPhoto ? null : photoPath ?? this.photoPath,
    photoUrl: clearPhoto ? null : photoUrl ?? this.photoUrl,
    createdAt: createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'university': university,
    'studyLevel': studyLevel,
    'specialty': specialty,
    'bio': bio,
    'interests': interests,
    'photoPath': photoPath,
    'photoUrl': photoUrl,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt?.toIso8601String(),
  };

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    name: json['name'] as String? ?? '',
    email: json['email'] as String,
    university: json['university'] as String? ?? '',
    studyLevel: json['studyLevel'] as String? ?? '',
    specialty: json['specialty'] as String? ?? '',
    bio: json['bio'] as String? ?? '',
    interests: List<String>.from(json['interests'] as List? ?? const []),
    photoPath: json['photoPath'] as String?,
    photoUrl: json['photoUrl'] as String?,
    createdAt:
        DateTime.tryParse(json['createdAt'] as String? ?? '') ?? DateTime.now(),
    updatedAt: DateTime.tryParse(json['updatedAt'] as String? ?? ''),
  );
}
