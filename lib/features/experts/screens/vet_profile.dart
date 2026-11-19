
// Path: lib/features/experts/screens/vet_profile.dart

import 'package:flutter/material.dart';
import '../../profile/profile_template.dart';

const _green = Color(0xFF1F7A4D);
const _greenDark = Color(0xFF0F4D31);
const _greenTint = Color(0xFFD7EBDD);

/// Vet profile = ProfileTemplate + vet data.
class VetProfilePage extends StatelessWidget {
  const VetProfilePage({super.key});

  @override
  Widget build(BuildContext context) => ProfileTemplate(config: _vetConfig);
}

final ProfileConfig _vetConfig = ProfileConfig(
  id: 'vet',

  // theme
  primary: _green,
  dark: _greenDark,
  tint: _greenTint,
  background: const Color(0xFFF4F6F3),
  verifiedColor: Colors.blue,

  // header
  initials: 'SW',
  name: 'Dr. Sameer Wagle',
  nameLocal: '(डा. समीर वाग्ले)',
  titleLocal: 'वरिष्ठ पशु चिकित्सक तथा बाली विज्ञ',
  title: 'Senior Veterinary Surgeon & Agronomist',
  onLabel: 'On-Duty',
  offLabel: 'Off-Duty',
  badges: const [
    (Icons.badge_outlined, 'NVC #4128 Certified'),
    (Icons.account_balance_outlined, 'MoALD Accredited'),
    (Icons.fact_check_outlined, 'Bagmati Agro-Vet Inspector'),
  ],

  // stats
  stats: const [
    StatItem(Icons.star_rounded, '4.96 / 5.0', 'शीर्ष विज्ञ', Colors.amber),
    StatItem(Icons.workspace_premium, '12+ वर्ष', 'अनुभव', _green),
    StatItem(Icons.forum_outlined, '१,८४०+', 'परामर्श (Consults)', Colors.blue),
    StatItem(Icons.favorite_outline, '98.4%', 'निको दर', Colors.redAccent),
    StatItem(Icons.hub_outlined, '420+', 'फार्म नेटवर्क', Colors.deepPurple),
  ],

  // sections (shown in this order)
  sections: [
    ProfileSection(
      title: 'योग्यता र अनुमतिपत्र (License)',
      child: AppCard(
        child: Column(
          children: [
            Row(children: [
              const Icon(Icons.verified_user_outlined, color: _green),
              const SizedBox(width: 8),
              const Expanded(child: Text('License नविकृत: २०२८', style: TextStyle(fontWeight: FontWeight.w600))),
              TextButton(onPressed: () {}, child: const Text('Digital Seal')),
            ]),
            const Divider(),
            const EduTile(
              title: 'BVSc & AH',
              sub: 'Bachelor of Vet Science & Animal Husbandry\nIAAS रामपुर क्याम्पस, त्रिभुवन विश्वविद्यालय (TU)',
              note: 'स्वर्ण पदक • पशु शल्यचिकित्सा तथा प्रसूति विशेषज्ञता',
            ),
            const EduTile(
              title: 'MSc Agronomy (Plant Pathology & IPM)',
              sub: 'कृषि तथा वन विज्ञान विश्वविद्यालय (AFU), चितवन',
              note: 'एकीकृत शत्रुजीव व्यवस्थापन (IPM) तथा जैविक मल अनुसन्धान',
            ),
            const EduTile(
              title: 'नेपाल पशु चिकित्सा परिषद् दर्ता: NVC #4128',
              sub: 'बागमती प्रदेश कृषि मन्त्रालय मान्यता प्राप्त भेटेरिनरी इन्स्पेक्टर',
            ),
          ],
        ),
      ),
    ),
    const ProfileSection(
      title: 'विशेषज्ञता क्षेत्र (Scope of Practice)',
      child: IconListCard(items: [
        (Icons.pets, 'गाईभैंसी चिकित्सा (Ruminant)', 'अपच, पेट फुल्ने (Bloat), बाछो स्याहार'),
        (Icons.water_drop_outlined, 'थुनेलो नियन्त्रण (Mastitis Control)', 'दूध गुणस्तर सुधार र एन्टिबायोटिक तालिका'),
        (Icons.egg_outlined, 'पोल्ट्री तथा जैविक सुरक्षा (Biosecurity)', 'रानीखेत, गम्बोरो, भ्याक्सिन प्रोटोकल'),
        (Icons.local_florist_outlined, 'बाली डढुवा र कीरा निदान (Plant IPM)', 'गोलभेंडा टनेल, फलफूल ढुसी रोग उपचार'),
        (Icons.grass, 'माटो सुधार र जैविक पोषण (Soil Health)', 'pH परीक्षण अनुसार चुन र कम्पोस्ट सल्लाह'),
      ]),
    ),
    const ProfileSection(
      title: 'परामर्श शुल्क दर (Consult Fees)',
      trailing: Pill('MoALD स्वीकृत'),
      child: Column(children: [
        FeeTile(Icons.videocam_outlined, 'तत्काल भिडियो कल (Video)', '१० मिनेट • प्रत्यक्ष निरीक्षण + ई-प्रेस्क्रिप्सन', 'रु ४५०', 'प्रति सत्र'),
        FeeTile(Icons.photo_camera_outlined, 'अडियो तथा फोटो विश्लेषण', 'लक्षण तस्वीर र भ्वाइस नोट मार्फत औषधि सिफारिस', 'रु २५०', 'प्रति केस'),
        FeeTile(Icons.home_work_outlined, 'प्रत्यक्ष गोठ तथा फार्म भ्रमण', '२५ कि.मि. • खोप, शल्यक्रिया, माटो नमुना (चितवन/ललितपुर)', 'रु १,५००', 'भ्रमण शुल्क'),
      ]),
    ),
    ProfileSection(
      title: 'कार्यतालिका र क्लिनिक ठेगाना',
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InfoRow(Icons.location_on_outlined, 'किसान क्षेत्रीय एग्रो-भेट अनुसन्धान केन्द्र', 'भरतपुर-१० चितवन र ललितपुर सेवा केन्द्र (पुलचोक)'),
            const InfoRow(Icons.schedule, 'सोमबार – शनिबार (Teleconsult)', 'बिहान ७:०० – साँझ ८:००'),
            const InfoRow(Icons.agriculture_outlined, 'फार्म भ्रमण (Barn Field Visits)', 'आइतबार र बुधबार बिहान'),
            const InfoRow(Icons.emergency_outlined, 'आपतकालीन कल (Emergency)', '२४/७ खुला', iconColor: Colors.redAccent),
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
    ),
    const ProfileSection(
      child: EarningsCard(
        header: 'आम्दानी तथा बैंक भुक्तानी (Private)',
        balance: 'रु ४२,८५०.००',
        note: 'शुक्रबार स्वतः बैंक खातामा जम्मा हुनेछ',
        bank: 'Nepal Investment Mega Bank (NIMB)\n•••• •••• 5612 (सत्यापित)',
        links: ['TDS रसिद', 'Logs'],
      ),
    ),
    ProfileSection(
      title: 'किसानहरूको प्रतिक्रिया (Reviews)',
      trailing: TextButton(onPressed: () {}, child: const Text('सबै हेर्नुहोस् (२८०)')),
      child: const Column(children: [
        ReviewCard('राम कुमार श्रेष्ठ', 'धादिङ दुग्ध सहकारी संघ', 'डा. समीरको भिडियो सल्लाहले मेरो जर्सी गाईको जटिल थुनेलो ३ दिनमै निको भयो। औषधि र सरसफाइको तालिका एकदमै प्रभावकारी छ।'),
        ReviewCard('मीना कुमारी थापा', 'काभ्रे गोलभेंडा टनेल सञ्जाल', 'पात डढुवा रोगले टनेल सखाप हुन लागेको थियो। अडियो कलमै फोटो हेरेर सही जैविक ढुसीनाशक औषधि लेखिदिनुभयो।'),
      ]),
    ),
  ],

  // settings
  alertTitle: 'आपतकालीन केस अलार्म र SMS',
  alertSubtitle: 'गोठ कल अलर्ट २ मिनेट भित्र साइरन बज्ने',
  settingsBefore: [
    ListTile(
      leading: const Icon(Icons.draw_outlined, color: _green),
      title: const Text('डिजिटल हस्ताक्षर र आधिकारिक छाप'),
      subtitle: const Text('सक्रिय छ (Verified NVC Stamp Attached)'),
      trailing: TextButton(onPressed: () {}, child: const Text('बदल्नुहोस्')),
    ),
  ],
);