import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../data/catalog.dart';
import '../l10n/l10n.dart';
import '../models/user_profile.dart';
import '../providers/app_state.dart';
import '../utils/validators.dart';
import '../widgets/career_ui.dart';
import '../widgets/form_fields.dart';
import '../widgets/user_avatar.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _university;
  late final TextEditingController _specialty;
  late final TextEditingController _bio;
  late String _studyLevel;
  late Set<String> _interests;
  String? _photoPath;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final profile = context.read<AppState>().profile;
    _name = TextEditingController(text: profile.name);
    _university = TextEditingController(text: profile.university);
    _specialty = TextEditingController(text: profile.specialty);
    _bio = TextEditingController(text: profile.bio);
    _studyLevel = profile.studyLevel;
    _interests = profile.interests.toSet();
    _photoPath = profile.photoPath;
  }

  @override
  void dispose() {
    _name.dispose();
    _university.dispose();
    _specialty.dispose();
    _bio.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto(ImageSource source) async {
    try {
      final picked = await ImagePicker().pickImage(
        source: source,
        maxWidth: 600,
        imageQuality: 85,
      );
      if (picked == null) return;
      final directory = await getApplicationDocumentsDirectory();
      final target =
          '${directory.path}/avatar_${DateTime.now().millisecondsSinceEpoch}.jpg';
      await File(picked.path).copy(target);
      if (!mounted) return;
      setState(() => _photoPath = target);
    } catch (error) {
      if (!mounted) return;
      showError(context, context.l10n.photoLoadError('$error'));
    }
  }

  void _showPhotoOptions() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(context.l10n.chooseFromGallery),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickPhoto(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined),
              title: Text(context.l10n.takePhoto),
              onTap: () {
                Navigator.of(sheetContext).pop();
                _pickPhoto(ImageSource.camera);
              },
            ),
            if (_photoPath != null)
              ListTile(
                leading: const Icon(Icons.delete_outline, color: Colors.red),
                title: Text(context.l10n.removePhoto),
                onTap: () {
                  Navigator.of(sheetContext).pop();
                  setState(() => _photoPath = null);
                },
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final state = context.read<AppState>();
    final updated = state.profile.copyWith(
      name: _name.text.trim(),
      university: _university.text.trim(),
      specialty: _specialty.text.trim(),
      bio: _bio.text.trim(),
      studyLevel: _studyLevel,
      interests: allInterests.where(_interests.contains).toList(),
      photoPath: _photoPath,
      clearPhoto: _photoPath == null,
    );
    await state.updateProfile(updated);
    if (!mounted) return;
    showInfo(context, context.l10n.profileUpdated);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final profile = context.watch<AppState>().profile;
    final loc = context.l10n;
    final preview = UserProfile(
      name: _name.text.isEmpty ? profile.name : _name.text,
      email: profile.email,
      photoPath: _photoPath,
      createdAt: profile.createdAt,
    );

    return Scaffold(
      backgroundColor: canvas,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Text(
          loc.editProfileTitle,
          style: const TextStyle(color: ink, fontWeight: FontWeight.w800),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(18),
          children: [
            Center(
              child: GestureDetector(
                onTap: _showPhotoOptions,
                child: Stack(
                  children: [
                    UserAvatar(profile: preview, radius: 46),
                    const Positioned(
                      right: 0,
                      bottom: 0,
                      child: CircleAvatar(
                        radius: 15,
                        backgroundColor: purple,
                        child: Icon(
                          Icons.camera_alt,
                          size: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              key: const Key('edit-name'),
              controller: _name,
              textCapitalization: TextCapitalization.words,
              onChanged: (_) => setState(() {}),
              decoration: careerInputDecoration(
                label: loc.fullName,
                icon: Icons.person_outline,
              ),
              validator: AppValidators.name(loc),
            ),
            const SizedBox(height: 12),
            TextFormField(
              initialValue: profile.email,
              enabled: false,
              decoration: careerInputDecoration(
                label: loc.email,
                icon: Icons.mail_outline,
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              isExpanded: true,
              initialValue: studyLevels.contains(_studyLevel)
                  ? _studyLevel
                  : null,
              decoration: careerInputDecoration(
                label: loc.studyLevel,
                icon: Icons.school_outlined,
              ),
              items: studyLevels
                  .map(
                    (level) => DropdownMenuItem(
                      value: level,
                      child: Text(tc(level), overflow: TextOverflow.ellipsis),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _studyLevel = value ?? ''),
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('edit-university'),
              controller: _university,
              decoration: careerInputDecoration(
                label: loc.universitySchool,
                icon: Icons.account_balance_outlined,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('edit-specialty'),
              controller: _specialty,
              decoration: careerInputDecoration(
                label: loc.specialty,
                hint: loc.specialtyHint,
                icon: Icons.workspace_premium_outlined,
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              key: const Key('edit-bio'),
              controller: _bio,
              maxLines: 3,
              maxLength: 200,
              decoration: careerInputDecoration(
                label: loc.bio,
                hint: loc.bioHint,
              ),
            ),
            const SizedBox(height: 8),
            SectionTitle(loc.interests),
            Text(
              loc.interestsHint,
              style: const TextStyle(color: mutedInk, fontSize: 12),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: allInterests
                  .map(
                    (interest) => FilterChip(
                      key: Key('interest-$interest'),
                      label: Text(tc(interest)),
                      selected: _interests.contains(interest),
                      selectedColor: const Color(0xFFEDE8FF),
                      checkmarkColor: purple,
                      onSelected: (selected) => setState(
                        () => selected
                            ? _interests.add(interest)
                            : _interests.remove(interest),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
            _saving
                ? const Center(child: CircularProgressIndicator())
                : GradientActionButton(
                    key: const Key('save-profile'),
                    label: loc.saveChanges,
                    icon: Icons.check_rounded,
                    onPressed: _save,
                  ),
          ],
        ),
      ),
    );
  }
}
