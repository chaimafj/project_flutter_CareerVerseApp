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
    final url = profile.photoUrl;
    final ImageProvider? image = file != null && file.existsSync()
        ? FileImage(file)
        : url != null && url.isNotEmpty
        ? NetworkImage(url)
        : null;
    final hasPhoto = image != null;
    return CircleAvatar(
      radius: radius,
      backgroundColor: const Color(0xFFDCE7FF),
      backgroundImage: image,
      onBackgroundImageError: hasPhoto ? (_, _) {} : null,
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
