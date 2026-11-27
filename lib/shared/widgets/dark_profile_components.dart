import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Dark Theme Colors matching the exact UI theme
class DarkProfileTheme {
  static const Color bgDark = Color(0xFF101612);
  static const Color cardDark = Color(0xFF1B221C);
  static const Color cardBorder = Color(0xFF28342B);
  static const Color primaryGreen = Color(0xFF22C55E);
  static const Color darkGreenBannerStart = Color(0xFF0A3018);
  static const Color darkGreenBannerEnd = Color(0xFF144525);
  static const Color tagGreenBg = Color(0xFF15803D);
  static const Color textWhite = Colors.white;
  static const Color textMuted = Color(0xFF94A3B8);
  static const Color dividerDark = Color(0xFF263229);
}

/// Reusable & Reactive Profile Avatar Component with Integrated ImagePicker.
/// Supports Device Storage / Camera picking, Local File Preview, Network URL, and Initials Fallback.
class DarkProfileAvatar extends StatelessWidget {
  final String? avatarPath;
  final String? avatarUrl;
  final String? initials;
  final double size;
  final bool isEditable;
  final Function(String path)? onImagePicked;

  const DarkProfileAvatar({
    super.key,
    this.avatarPath,
    this.avatarUrl,
    this.initials,
    this.size = 76,
    this.isEditable = true,
    this.onImagePicked,
  });

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 85,
        maxWidth: 800,
      );

      if (pickedFile != null && onImagePicked != null) {
        onImagePicked!(pickedFile.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to pick image: $e')),
        );
      }
    }
  }

  void _showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: DarkProfileTheme.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Change Profile Picture',
                  style: TextStyle(
                    color: DarkProfileTheme.textWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  leading: const ContainerBoxIcon(icon: Icons.photo_library_outlined),
                  title: const Text(
                    'Choose from Gallery',
                    style: TextStyle(color: DarkProfileTheme.textWhite),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.gallery);
                  },
                ),
                ListTile(
                  leading: const ContainerBoxIcon(icon: Icons.camera_alt_outlined),
                  title: const Text(
                    'Take a Photo (Camera)',
                    style: TextStyle(color: DarkProfileTheme.textWhite),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(context, ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (avatarPath != null && avatarPath!.isNotEmpty && File(avatarPath!).existsSync()) {
      imageWidget = Image.file(
        File(avatarPath!),
        fit: BoxFit.cover,
        width: size,
        height: size,
      );
    } else if (avatarUrl != null && avatarUrl!.isNotEmpty) {
      imageWidget = Image.network(
        avatarUrl!,
        fit: BoxFit.cover,
        width: size,
        height: size,
        errorBuilder: (context, error, stackTrace) => _buildFallbackAvatar(),
      );
    } else {
      imageWidget = _buildFallbackAvatar();
    }

    return GestureDetector(
      onTap: isEditable ? () => _showImagePickerModal(context) : null,
      child: Stack(
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: DarkProfileTheme.primaryGreen,
                width: 2,
              ),
            ),
            child: ClipOval(child: imageWidget),
          ),
          if (isEditable)
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: DarkProfileTheme.bgDark,
                  shape: BoxShape.circle,
                ),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 13,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFallbackAvatar() {
    return Container(
      width: size,
      height: size,
      color: DarkProfileTheme.darkGreenBannerEnd,
      child: Center(
        child: Text(
          initials ?? 'KA',
          style: TextStyle(
            color: DarkProfileTheme.primaryGreen,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.35,
          ),
        ),
      ),
    );
  }
}

/// Helper Icon Box Container
class ContainerBoxIcon extends StatelessWidget {
  final IconData icon;

  const ContainerBoxIcon({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: DarkProfileTheme.primaryGreen.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(icon, color: DarkProfileTheme.primaryGreen, size: 20),
    );
  }
}

/// Reusable Standard Dark Container Card
class DarkProfileCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;

  const DarkProfileCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: DarkProfileTheme.cardDark,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: DarkProfileTheme.cardBorder),
      ),
      child: child,
    );
  }
}

/// Reusable Top Banner Profile Summary Card (Matching screenshot)
class DarkBannerCard extends StatelessWidget {
  final String? avatarPath;
  final String? avatarUrl;
  final String? initials;
  final String name;
  final String role;
  final String location;
  final bool isVerified;
  final VoidCallback onEditPressed;
  final Function(String path)? onImagePicked;
  final List<StatItem> stats;

  const DarkBannerCard({
    super.key,
    this.avatarPath,
    this.avatarUrl,
    this.initials,
    required this.name,
    required this.role,
    required this.location,
    this.isVerified = true,
    required this.onEditPressed,
    this.onImagePicked,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            DarkProfileTheme.darkGreenBannerStart,
            DarkProfileTheme.darkGreenBannerEnd,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Decorative Right Leaves Graphic Accent
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.25,
              child: Icon(
                Icons.eco,
                size: 130,
                color: DarkProfileTheme.primaryGreen,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with Camera Badge
                    DarkProfileAvatar(
                      avatarPath: avatarPath,
                      avatarUrl: avatarUrl,
                      initials: initials,
                      onImagePicked: onImagePicked,
                      size: 78,
                    ),
                    const SizedBox(width: 14),
// Name & Details
                      Flexible(
                        fit: FlexFit.loose,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    name.isEmpty ? 'Set Your Name' : name,
                                    style: const TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold,
                                      color: DarkProfileTheme.textWhite,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                if (isVerified) ...[
                                  const SizedBox(width: 6),
                                  const Icon(
                                    Icons.verified,
                                    color: DarkProfileTheme.primaryGreen,
                                    size: 18,
                                  ),
                                ],
                              ],
                            ),
                            const SizedBox(height: 6),
                            // Role Pill Tag
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: DarkProfileTheme.tagGreenBg,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(
                                    Icons.eco,
                                    size: 12,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    role,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  size: 14,
                                  color: DarkProfileTheme.textMuted,
                                ),
                                const SizedBox(width: 4),
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: Text(
                                    location.isEmpty ? 'Set Location' : location,
                                    style: const TextStyle(
                                      color: DarkProfileTheme.textMuted,
                                      fontSize: 13,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                      // Edit Profile Button
                      Flexible(
                        fit: FlexFit.loose,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 130),
                          child: OutlinedButton.icon(
                            onPressed: onEditPressed,
                            icon: const Icon(Icons.edit, size: 14, color: Colors.white),
                            label: const Text(
                              'Edit Profile',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              side: const BorderSide(color: Colors.white38),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                ),
                const SizedBox(height: 18),
                const Divider(color: Colors.white12, height: 1),
                const SizedBox(height: 14),
                // 3 Stats Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: _buildStatsList(stats),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildStatsList(List<StatItem> statsList) {
    List<Widget> list = [];
    for (int i = 0; i < statsList.length; i++) {
      list.add(
        Row(
          children: [
            Icon(
              statsList[i].icon,
              color: DarkProfileTheme.primaryGreen,
              size: 20,
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  statsList[i].value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  statsList[i].label,
                  style: const TextStyle(
                    color: DarkProfileTheme.textMuted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      if (i < statsList.length - 1) {
        list.add(
          Container(
            height: 24,
            width: 1,
            color: Colors.white12,
            margin: const EdgeInsets.symmetric(horizontal: 12),
          ),
        );
      }
    }
    return list;
  }
}

class StatItem {
  final IconData icon;
  final String value;
  final String label;

  const StatItem({
    required this.icon,
    required this.value,
    required this.label,
  });
}

/// Section Header with Bright Green Icon & Title
class DarkSectionHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const DarkSectionHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: DarkProfileTheme.primaryGreen, size: 22),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            color: DarkProfileTheme.textWhite,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

/// Reusable Key-Value Detail Row Item
class DarkInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String? value;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final bool hasDivider;

  const DarkInfoRow({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.trailingWidget,
    this.onTap,
    this.hasDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: DarkProfileTheme.primaryGreen.withValues(alpha: 0.1),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Row(
              children: [
                Icon(icon, color: DarkProfileTheme.textMuted, size: 20),
                const SizedBox(width: 14),
                Expanded(
                  child: Text(
                    label,
                    style: const TextStyle(
                      color: DarkProfileTheme.textMuted,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (value != null)
                  Text(
                    value!.isEmpty ? '--' : value!,
                    style: const TextStyle(
                      color: DarkProfileTheme.textWhite,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ? trailingWidget,
              ],
            ),
          ),
          if (hasDivider)
            const Divider(
              color: DarkProfileTheme.dividerDark,
              height: 1,
            ),
        ],
      ),
    );
  }
}

/// Reusable Verification Status Banner Card
class DarkVerificationBanner extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  const DarkVerificationBanner({
    super.key,
    this.title = 'Your account is verified',
    this.subtitle = 'You can now access all features of Kissan Aap',
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DarkProfileCard(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: DarkProfileTheme.primaryGreen,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.verified_user,
                color: Colors.white,
                size: 24,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: DarkProfileTheme.textWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: DarkProfileTheme.textMuted,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: DarkProfileTheme.textMuted,
            ),
          ],
        ),
      ),
    );
  }
}
