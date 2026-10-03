import 'dart:io';

import 'package:flutter/material.dart';

import '../models/user_profile.dart';
import 'career_ui.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.profile, this.radius = 18});

  final UserProfile profile;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final path = profile.photoPath;
    final file = path == null ? null : File(path);
    final hasPhoto = file != null && file.existsSync();
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFDCE7FF),
      backgroundImage: hasPhoto ? FileImage(file) : null,
      child: hasPhoto
          ? null
          : Text(
              profile.initials,
              style: TextStyle(
                color: navy,
                fontWeight: FontWeight.w800,
                fontSize: radius * 0.75,
              ),
            ),
    );
  }
}
