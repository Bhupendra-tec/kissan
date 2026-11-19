// Path: lib/features/profile/profile_template.dart
//
// One reusable profile screen. Each role (vet, driver, farmer ...) only
// provides a ProfileConfig (data + colors). The layout is written once here.

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// ============================================================ config models

/// One tile in the stats grid.
class StatItem {
  final IconData icon;
  final String value, label;
  final Color color;
  const StatItem(this.icon, this.value, this.label, this.color);
}

/// One block below the stats grid.
/// - With a [title]: shows a heading (and optional [trailing]) above [child].
/// - Without a title: just shows [child] (e.g. earnings card, active trip card).
class ProfileSection {
  final String? title;
  final Widget? trailing;
  final Widget child;
  const ProfileSection({this.title, this.trailing, required this.child});
}

/// Everything that differs between roles.
class ProfileConfig {
  /// Unique key per role. Used to remember the chosen photo.
  final String id;

  // Theme
  final Color primary, dark, tint, background, verifiedColor;

  // Header
  final String initials, name, nameLocal, title, titleLocal;
  final List<(IconData, String)> badges;
  final String onLabel, offLabel; // e.g. On-Duty / Off-Duty

  // Body
  final List<StatItem> stats;
  final List<ProfileSection> sections;

  // Settings
  final IconData alertIcon;
  final String alertTitle, alertSubtitle;
  final List<Widget> settingsBefore; // extra tiles above the alert switch
  final List<Widget> settingsAfter; // extra tiles below the alert switch

  const ProfileConfig({
    required this.id,
    required this.primary,
    required this.dark,
    required this.tint,
    required this.background,
    required this.verifiedColor,
    required this.initials,
    required this.name,
    required this.nameLocal,
    required this.title,
    required this.titleLocal,
    required this.badges,
    required this.onLabel,
    required this.offLabel,
    required this.stats,
    required this.sections,
    required this.alertTitle,
    required this.alertSubtitle,
    this.alertIcon = Icons.notifications_active_outlined,
    this.settingsBefore = const [],
    this.settingsAfter = const [],
  });
}

// ===================================================== colors for child widgets

/// Lets the shared tiles read the role's colors without passing them around.
class ProfileColors extends InheritedWidget {
  final Color primary, dark, tint;

  const ProfileColors({
    super.key,
    required this.primary,
    required this.dark,
    required this.tint,
    required super.child,
  });

  static ProfileColors of(BuildContext context) {
    final c = context.dependOnInheritedWidgetOfExactType<ProfileColors>();
    assert(c != null, 'Use these widgets inside ProfileTemplate.');
    return c!;
  }

  @override
  bool updateShouldNotify(ProfileColors old) =>
      primary != old.primary || dark != old.dark || tint != old.tint;
}

// ================================================================== template

class ProfileTemplate extends StatefulWidget {
  final ProfileConfig config;
  const ProfileTemplate({super.key, required this.config});

  @override
  State<ProfileTemplate> createState() => _ProfileTemplateState();
}

class _ProfileTemplateState extends State<ProfileTemplate> {
  // Keeps each role's photo while the app runs (tab switches rebuild the page)
  static final Map<String, Uint8List> _photoCache = {};

  bool _active = true;
  bool _alert = true;
  bool _nepali = true;
  Uint8List? _photo;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _photo = _photoCache[widget.config.id];
  }

  Future<void> _pickPhoto() async {
    try {
      final file = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        imageQuality: 85,
      );
      if (file == null) return; // user cancelled
      final bytes = await file.readAsBytes();
      if (!mounted) return;
      setState(() {
        _photo = bytes;
        _photoCache[widget.config.id] = bytes;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the gallery.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = widget.config;
    return ProfileColors(
      primary: c.primary,
      dark: c.dark,
      tint: c.tint,
      child: Scaffold(
        backgroundColor: c.background,
        body: SafeArea(
          bottom: false,
          child: ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: [
              _header(c),
              const SizedBox(height: 12),
              _stats(c),
              for (final s in c.sections) _buildSection(s),
              _settingsSection(c),
            ],
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------- header
  Widget _header(ProfileConfig c) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [c.dark, c.primary], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Profile', style: TextStyle(color: Colors.white70, fontSize: 16)),
              InkWell(
                onTap: () => setState(() => _active = !_active),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(color: Colors.white.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(20)),
                  child: Row(children: [
                    Icon(Icons.circle, size: 10, color: _active ? Colors.lightGreenAccent : Colors.grey),
                    const SizedBox(width: 6),
                    Text(_active ? c.onLabel : c.offLabel, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                  ]),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _avatar(c),
          const SizedBox(height: 12),
          Text(c.name, style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          Text(c.nameLocal, style: const TextStyle(color: Colors.white70, fontSize: 15)),
          const SizedBox(height: 6),
          Text(c.titleLocal, style: const TextStyle(color: Colors.white, fontSize: 14)),
          Text(c.title, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: [for (final b in c.badges) _HeaderBadge(b.$1, b.$2)],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _action(c, Icons.edit_outlined, 'सम्पादन'),
              _action(c, Icons.qr_code_2, 'शेयर QR'),
              _action(c, Icons.support_agent, 'हेल्पलाइन'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _avatar(ProfileConfig c) {
    return GestureDetector(
      onTap: _pickPhoto,
      child: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 48,
            backgroundColor: Colors.white,
            child: CircleAvatar(
              radius: 44,
              backgroundColor: c.tint,
              backgroundImage: _photo != null ? MemoryImage(_photo!) : null,
              child: _photo == null
                  ? Text(c.initials, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: c.dark))
                  : null,
            ),
          ),
          // camera badge: tap the photo to change it
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: c.primary,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(3),
            decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.verified, color: c.verifiedColor, size: 22),
          ),
        ],
      ),
    );
  }

  Widget _action(ProfileConfig c, IconData icon, String label) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: FilledButton.icon(
          onPressed: () {},
          icon: Icon(icon, size: 18),
          label: Text(label, style: const TextStyle(fontSize: 12)),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: c.dark,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------------- stats
  Widget _stats(ProfileConfig c) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: LayoutBuilder(builder: (context, box) {
        final w = (box.maxWidth - 12) / 2;
        return Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [for (final s in c.stats) SizedBox(width: w, child: _StatTile(s))],
        );
      }),
    );
  }

  // -------------------------------------------------------------- sections
  Widget _buildSection(ProfileSection s) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: s.title == null
          ? s.child
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(s.title!, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
              if (s.trailing != null) s.trailing!,
            ],
          ),
          const SizedBox(height: 10),
          s.child,
        ],
      ),
    );
  }

  // -------------------------------------------------------------- settings
  Widget _settingsSection(ProfileConfig c) {
    final tiles = <Widget>[
      ...c.settingsBefore,
      SwitchListTile(
        secondary: Icon(c.alertIcon, color: Colors.redAccent),
        title: Text(c.alertTitle),
        subtitle: Text(c.alertSubtitle),
        value: _alert,
        onChanged: (v) => setState(() => _alert = v),
      ),
      ...c.settingsAfter,
      ListTile(
        leading: Icon(Icons.language, color: c.primary),
        title: const Text('एपको भाषा (App Language)'),
        subtitle: Text(_nepali ? 'नेपाली / English (द्विभाषी सक्रिय)' : 'English'),
        trailing: SegmentedButton<bool>(
          showSelectedIcon: false,
          segments: const [
            ButtonSegment(value: true, label: Text('नेपाली')),
            ButtonSegment(value: false, label: Text('EN')),
          ],
          selected: {_nepali},
          onSelectionChanged: (s) => setState(() => _nepali = s.first),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.logout, color: Colors.red),
        title: const Text('खाताबाट बाहिरिनुहोस् (Log Out)', style: TextStyle(color: Colors.red)),
        onTap: () {},
      ),
    ];

    return _buildSection(
      ProfileSection(
        title: 'खाता व्यवस्थापन तथा सेटिङहरू',
        child: AppCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < tiles.length; i++) ...[
                if (i > 0) const Divider(height: 1),
                tiles[i],
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ================================================= private template widgets

class _HeaderBadge extends StatelessWidget {
  final IconData icon;
  final String text;
  const _HeaderBadge(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(color: Colors.white, fontSize: 11)),
      ]),
    );
  }
}

class _StatTile extends StatelessWidget {
  final StatItem d;
  const _StatTile(this.d);

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Row(children: [
        Icon(d.icon, color: d.color, size: 28),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(d.value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
            Text(d.label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
          ]),
        ),
      ]),
    );
  }
}

// ====================================================== shared public widgets
// Use these inside ProfileSection.child for any role.

/// White rounded card.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  const AppCard({super.key, required this.child, this.padding = const EdgeInsets.all(14)});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: child,
    );
  }
}

/// Small rounded label, e.g. "KYC Verified".
class Pill extends StatelessWidget {
  final String text;
  const Pill(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = ProfileColors.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: c.tint, borderRadius: BorderRadius.circular(12)),
      child: Text(text, style: TextStyle(color: c.dark, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

/// Icon + title + subtitle row.
class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title, sub;
  final Color? iconColor;
  const InfoRow(this.icon, this.title, this.sub, {super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: iconColor ?? ProfileColors.of(context).primary, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 12)),
          ]),
        ),
      ]),
    );
  }
}

/// Card with a list of (icon, title, subtitle) items. Used for scope, routes, crops...
class IconListCard extends StatelessWidget {
  final List<(IconData, String, String)> items;
  const IconListCard({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final c = ProfileColors.of(context);
    return AppCard(
      child: Column(
        children: [
          for (final e in items)
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: CircleAvatar(backgroundColor: c.tint, child: Icon(e.$1, color: c.primary)),
              title: Text(e.$2, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              subtitle: Text(e.$3),
            ),
        ],
      ),
    );
  }
}

/// Price card: icon, title, subtitle, price and unit.
class FeeTile extends StatelessWidget {
  final IconData icon;
  final String title, sub, price, unit;
  const FeeTile(this.icon, this.title, this.sub, this.price, this.unit, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = ProfileColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Row(children: [
          CircleAvatar(backgroundColor: c.tint, child: Icon(icon, color: c.primary)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            ]),
          ),
          const SizedBox(width: 8),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(price, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: c.dark)),
            Text(unit, style: const TextStyle(fontSize: 11, color: Colors.black54)),
          ]),
        ]),
      ),
    );
  }
}

/// Document row with a colored status chip (Verified / Expiring ...).
class DocTile extends StatelessWidget {
  final String title, sub, status;
  final Color color;
  const DocTile(this.title, this.sub, this.status, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = ProfileColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Row(children: [
          CircleAvatar(backgroundColor: c.tint, child: Icon(Icons.description_outlined, color: c.primary)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
            child: Text(status, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
          ),
        ]),
      ),
    );
  }
}

/// Education / qualification row.
class EduTile extends StatelessWidget {
  final String title, sub;
  final String? note;
  const EduTile({super.key, required this.title, required this.sub, this.note});

  @override
  Widget build(BuildContext context) {
    final c = ProfileColors.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(Icons.school_outlined, color: c.primary, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(sub, style: const TextStyle(color: Colors.black54, fontSize: 12)),
            if (note != null) Text(note!, style: TextStyle(color: c.primary, fontSize: 12)),
          ]),
        ),
      ]),
    );
  }
}

/// Review card with name, organisation, 5-star rating and quote.
class ReviewCard extends StatelessWidget {
  final String name, org, text;
  const ReviewCard(this.name, this.org, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    final c = ProfileColors.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: AppCard(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: c.tint,
              child: Text(name.characters.first, style: TextStyle(color: c.dark, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text(org, style: const TextStyle(fontSize: 12, color: Colors.black54)),
              ]),
            ),
            const Icon(Icons.star_rounded, color: Colors.amber, size: 18),
            const Text(' 5.0', style: TextStyle(fontWeight: FontWeight.bold)),
          ]),
          const SizedBox(height: 10),
          Text('“$text”', style: const TextStyle(height: 1.4)),
        ]),
      ),
    );
  }
}

/// Dark earnings / wallet card.
class EarningsCard extends StatelessWidget {
  final String header, balance, note, bank;
  final List<String> links; // small text buttons, e.g. ['TDS रसिद', 'Logs']
  final VoidCallback? onWithdraw;

  const EarningsCard({
    super.key,
    required this.header,
    required this.balance,
    required this.note,
    required this.bank,
    this.links = const [],
    this.onWithdraw,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [Color(0xFF263238), Color(0xFF37474F)]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.lock_outline, color: Colors.white54, size: 16),
            const SizedBox(width: 6),
            Text(header, style: const TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
          const SizedBox(height: 10),
          const Text('निकासी योग्य ब्यालेन्स (Withdrawable)', style: TextStyle(color: Colors.white70)),
          Text(balance, style: const TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(note, style: const TextStyle(color: Colors.white60, fontSize: 12)),
          const SizedBox(height: 12),
          Row(children: [
            const Icon(Icons.account_balance, color: Colors.white70, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(bank, style: const TextStyle(color: Colors.white, fontSize: 13))),
          ]),
          const SizedBox(height: 14),
          Row(children: [
            Expanded(
              child: FilledButton(
                onPressed: onWithdraw ?? () {},
                style: FilledButton.styleFrom(backgroundColor: Colors.lightGreenAccent, foregroundColor: Colors.black),
                child: const Text('निकाल्नुहोस्'),
              ),
            ),
            for (final l in links) ...[
              const SizedBox(width: 8),
              TextButton(onPressed: () {}, child: Text(l, style: const TextStyle(color: Colors.white))),
            ],
          ]),
        ],
      ),
    );
  }
}