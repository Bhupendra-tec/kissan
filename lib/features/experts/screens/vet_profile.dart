// Path: lib/features/experts/screens/vet_profile.dart

import 'package:flutter/material.dart';
import '../../../shared/widgets/dark_profile_components.dart' as dark;

class VetProfilePage extends StatelessWidget {
  const VetProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dark.DarkProfileTheme.bgDark,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            dark.DarkBannerCard(
              name: 'Dr. Sameer Wagle',
              role: 'वरिष्ठ पशु चिकित्सक तथा बाली विज्ञ',
              location: 'भरतपुर-१० चितवन र ललितपुर सेवा केन्द्र (पुलचोक)',
              isVerified: true,
              onEditPressed: () {},
              stats: [
                dark.StatItem(icon: Icons.workspace_premium, value: '12+ वर्ष', label: 'अनुभव'),
                dark.StatItem(icon: Icons.forum_outlined, value: '१,८४०+', label: 'परामर्श'),
              ],
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.verified_user_outlined, title: 'योग्यता र अनुमतिपत्र (License)'),
            dark.DarkProfileCard(
              child: Column(
                children: [
                  _licenseRow(Icons.verified_user_outlined, 'License नविकृत: २०२८', () {}),
                  const Divider(color: dark.DarkProfileTheme.dividerDark, height: 1),
                  _eduTile('BVSc & AH', 'Bachelor of Vet Science & Animal Husbandry\nIAAS रामपुर क्याम्पस, त्रिभुवन विश्वविद्यालय (TU)', 'स्वर्ण पदक • पशु शल्यचिकित्सा तथा प्रसूति विशेषज्ञता'),
                  _eduTile('MSc Agronomy (Plant Pathology & IPM)', 'कृषि तथा वन विज्ञान विश्वविद्यालय (AFU), चितवन', 'एकीकृत शत्रुजीव व्यवस्थापन (IPM) तथा जैविक मल अनुसन्धान'),
                  _eduTile('नेपाल पशु चिकित्सा परिषद् दर्ता: NVC #4128', 'बागमती प्रदेश कृषि मन्त्रालय मान्यता प्राप्त भेटेरिनरी इन्स्पेक्टर', null),
                ],
              ),
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.pets, title: 'विशेषज्ञता क्षेत्र (Scope of Practice)'),
            dark.DarkProfileCard(
              child: Column(children: [
                _scopeRow(Icons.pets, 'गाईभैंसी चिकित्सा (Ruminant)', 'अपच, पेट फुल्ने (Bloat), बाछो स्याहार'),
                _scopeRow(Icons.water_drop_outlined, 'थुनेलो नियन्त्रण (Mastitis Control)', 'दूध गुणस्तर सुधार र एन्टिबायोटिक तालिका'),
                _scopeRow(Icons.egg_outlined, 'पोल्ट्री तथा जैविक सुरक्षा (Biosecurity)', 'रानीखेत, गम्बोरो, भ्याक्सिन प्रोटोकल'),
                _scopeRow(Icons.local_florist_outlined, 'बाली डढुवा र कीरा निदान (Plant IPM)', 'गोलभेंडा टनेल, फलफूल ढुसी रोग उपचार'),
                _scopeRow(Icons.grass, 'माटो सुधार र जैविक पोषण (Soil Health)', 'pH परीक्षण अनुसार चुन र कम्पोस्ट सल्लाह'),
              ]),
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.videocam_outlined, title: 'परामर्श शुल्क दर (Consult Fees)'),
            dark.DarkProfileCard(
              child: Column(children: [
                _feeRow(Icons.videocam_outlined, 'तत्काल भिडियो कल (Video)', '१० मिनेट • प्रत्यक्ष निरीक्षण + ई-प्रेस्क्रिप्सन', 'रु ४५०', 'प्रति सत्र'),
                _feeRow(Icons.photo_camera_outlined, 'अडियो तथा फोटो विश्लेषण', 'लक्षण तस्वीर र भ्वाइस नोट मार्फत औषधि सिफारिस', 'रु २५०', 'प्रति केस'),
                _feeRow(Icons.home_work_outlined, 'प्रत्यक्ष गोठ तथा फार्म भ्रमण', '२५ कि.मि. • खोप, शल्यक्रिया, माटो नमुना (चितवन/ललितपुर)', 'रु १,५००', 'भ्रमण शुल्क'),
              ]),
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.schedule, title: 'कार्यतालिका र क्लिनिक ठेगाना'),
            dark.DarkProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dark.DarkInfoRow(icon: Icons.location_on_outlined, label: 'किसान क्षेत्रीय एग्रो-भेट अनुसन्धान केन्द्र', value: 'भरतपुर-१० चितवन र ललितपुर सेवा केन्द्र (पुलचोक)'),
                  dark.DarkInfoRow(icon: Icons.schedule, label: 'सोमबार – शनिबार (Teleconsult)', value: 'बिहान ७:०० – साँझ ८:००'),
                  dark.DarkInfoRow(icon: Icons.agriculture_outlined, label: 'फार्म भ्रमण (Barn Field Visits)', value: 'आइतबार र बुधबार बिहान'),
                  dark.DarkInfoRow(icon: Icons.emergency_outlined, label: 'आपतकालीन कल (Emergency)', value: '२४/७ खुला'),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_calendar_outlined),
                      label: const Text('समय मिलाउनुहोस्'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _settingsSection(),
          ],
        ),
      ),
    );
  }

  Widget _licenseRow(IconData icon, String text, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(children: [
          Icon(icon, color: dark.DarkProfileTheme.textMuted, size: 20),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white))),
          TextButton(onPressed: onTap, child: const Text('Digital Seal')),
        ]),
      ),
    );
  }

  Widget _eduTile(String title, String sub, String? note) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Icon(Icons.school_outlined, color: dark.DarkProfileTheme.primaryGreen, size: 20),
        const SizedBox(width: 10),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.white)),
            Text(sub, style: const TextStyle(color: dark.DarkProfileTheme.textMuted, fontSize: 12)),
            if (note != null) Text(note, style: TextStyle(color: dark.DarkProfileTheme.primaryGreen, fontSize: 12)),
          ]),
        ),
      ]),
    );
  }

  Widget _scopeRow(IconData icon, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(backgroundColor: dark.DarkProfileTheme.cardDark, child: Icon(icon, color: dark.DarkProfileTheme.primaryGreen)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
            Text(sub, style: const TextStyle(color: dark.DarkProfileTheme.textMuted, fontSize: 12)),
          ]),
        ),
      ]),
    );
  }

  Widget _feeRow(IconData icon, String title, String sub, String price, String unit) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        CircleAvatar(backgroundColor: dark.DarkProfileTheme.cardDark, child: Icon(icon, color: dark.DarkProfileTheme.primaryGreen)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white)),
            Text(sub, style: const TextStyle(color: dark.DarkProfileTheme.textMuted, fontSize: 12)),
          ]),
        ),
        const SizedBox(width: 8),
        Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
          Text(unit, style: const TextStyle(fontSize: 11, color: dark.DarkProfileTheme.textMuted)),
        ]),
      ]),
    );
  }

  Widget _settingsSection() {
    return dark.DarkProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('खाता व्यवस्थापन तथा सेटिङहरू', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
          const SizedBox(height: 10),
          ListTile(
            leading: const Icon(Icons.draw_outlined, color: dark.DarkProfileTheme.primaryGreen),
            title: const Text('डिजिटल हस्ताक्षर र आधिकारिक छाप', style: TextStyle(color: Colors.white)),
            subtitle: const Text('सक्रिय छ (Verified NVC Stamp Attached)', style: TextStyle(color: dark.DarkProfileTheme.textMuted)),
            trailing: TextButton(onPressed: () {}, child: const Text('बदल्नुहोस्')),
          ),
          const Divider(color: dark.DarkProfileTheme.dividerDark, height: 1),
          SwitchListTile(
            secondary: const Icon(Icons.notifications_active_outlined, color: Colors.redAccent),
            title: const Text('आपतकालीन केस अलार्म र SMS', style: TextStyle(color: Colors.white)),
            subtitle: const Text('गोठ कल अलर्ट २ मिनेट भित्र साइरन बज्ने', style: TextStyle(color: dark.DarkProfileTheme.textMuted)),
            value: true,
            onChanged: (v) {},
          ),
          const Divider(color: dark.DarkProfileTheme.dividerDark, height: 1),
          ListTile(
            leading: const Icon(Icons.language, color: dark.DarkProfileTheme.primaryGreen),
            title: const Text('एपको भाषा (App Language)', style: TextStyle(color: Colors.white)),
            subtitle: const Text('नेपाली / English (द्विभाषी सक्रिय)', style: TextStyle(color: dark.DarkProfileTheme.textMuted)),
            trailing: SegmentedButton<bool>(
              showSelectedIcon: false,
              segments: const [
                ButtonSegment(value: true, label: Text('नेपाली')),
                ButtonSegment(value: false, label: Text('EN')),
              ],
              selected: {true},
              onSelectionChanged: (s) {},
            ),
          ),
          const Divider(color: dark.DarkProfileTheme.dividerDark, height: 1),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('खाताबाट बाहिरिनुहोस् (Log Out)', style: TextStyle(color: Colors.red)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
