
// Path: lib/features/experts/screens/driver_profile.dart

import 'package:flutter/material.dart';
import '../../profile/profile_template.dart';

const _blue = Color(0xFF1B5E9E);
const _blueDark = Color(0xFF0D3B6B);
const _blueTint = Color(0xFFDCEAF7);

/// Driver profile = ProfileTemplate + driver data.
class DriverProfilePage extends StatelessWidget {
  const DriverProfilePage({super.key});

  @override
  Widget build(BuildContext context) => ProfileTemplate(config: _driverConfig);
}

final ProfileConfig _driverConfig = ProfileConfig(
  id: 'driver',

  // theme
  primary: _blue,
  dark: _blueDark,
  tint: _blueTint,
  background: const Color(0xFFF3F6FA),
  verifiedColor: Colors.green,

  // header
  initials: 'BT',
  name: 'Bikash Tamang',
  nameLocal: '(विकास तामाङ)',
  titleLocal: 'कोल्ड-चेन ट्रक चालक तथा ढुवानी साझेदार',
  title: 'Cold-chain Truck Driver & Logistics Partner',
  onLabel: 'Available',
  offLabel: 'Offline',
  badges: const [
    (Icons.badge_outlined, 'License Verified'),
    (Icons.description_outlined, 'Bluebook Verified'),
    (Icons.shield_outlined, 'Insured Vehicle'),
  ],

  // stats
  stats: const [
    StatItem(Icons.star_rounded, '4.88 / 5.0', 'शीर्ष चालक', Colors.amber),
    StatItem(Icons.workspace_premium, '6+ वर्ष', 'अनुभव', _blue),
    StatItem(Icons.local_shipping_outlined, '२,३१०+', 'ढुवानी (Deliveries)', Colors.teal),
    StatItem(Icons.timer_outlined, '99.1%', 'समयमै पुर्‍याएको', Colors.green),
    StatItem(Icons.route_outlined, '38,000+ कि.मि.', 'कुल यात्रा', Colors.deepPurple),
  ],

  // sections (shown in this order)
  sections: [
    const ProfileSection(child: _ActiveTripCard()),
    const ProfileSection(
      title: 'सवारी विवरण (Vehicle)',
      child: AppCard(
        child: Column(children: [
          InfoRow(Icons.local_shipping_outlined, 'मिनी ट्रक (Refrigerated)', 'क्षमता: १.५ टन • कोल्ड बक्स जडित'),
          InfoRow(Icons.pin_outlined, 'नम्बर प्लेट', 'बा २ ख ४५६७ (नमुना)'),
          InfoRow(Icons.thermostat_outlined, 'तापक्रम नियन्त्रण', '२°C – ८°C (दूध तथा तरकारी)'),
          InfoRow(Icons.gps_fixed, 'GPS ट्र्याकिङ', 'सक्रिय छ'),
        ]),
      ),
    ),
    const ProfileSection(
      title: 'कागजात तथा इजाजतपत्र (Documents)',
      trailing: Pill('KYC Verified'),
      child: Column(children: [
        DocTile('सवारी चालक अनुमतिपत्र (Driving License)', 'नविकृत: २०२९', 'Verified', Colors.green),
        DocTile('सवारी दर्ता किताब (Bluebook)', 'नविकृत: २०२७', 'Verified', Colors.green),
        DocTile('बीमा (Vehicle Insurance)', 'म्याद सकिँदै: ६० दिन', 'Expiring', Colors.orange),
      ]),
    ),
    const ProfileSection(
      title: 'सेवा क्षेत्र (Service Routes)',
      child: IconListCard(items: [
        (Icons.alt_route, 'चितवन ⇄ काठमाडौं', 'दैनिक • कोल्ड-चेन तथा सुख्खा सामान'),
        (Icons.alt_route, 'धादिङ ⇄ काठमाडौं', 'दूध तथा तरकारी संकलन मार्ग'),
        (Icons.alt_route, 'काभ्रे ⇄ ललितपुर', 'गोलभेंडा तथा फलफूल ढुवानी'),
      ]),
    ),
    const ProfileSection(
      title: 'ढुवानी शुल्क दर (Freight Rates)',
      child: Column(children: [
        FeeTile(Icons.route_outlined, 'प्रति किलोमिटर दर', 'लोड अनुसार परिवर्तन हुन सक्छ', 'रु ६५', 'प्रति कि.मि.'),
        FeeTile(Icons.local_shipping_outlined, 'न्यूनतम ढुवानी शुल्क', '२५ कि.मि. भित्रको छोटो यात्रा', 'रु २,५००', 'प्रति ट्रिप'),
        FeeTile(Icons.hourglass_bottom, 'प्रतीक्षा शुल्क', 'लोडिङ/अनलोडिङमा ३० मिनेटपछि', 'रु २००', 'प्रति घण्टा'),
        FeeTile(Icons.ac_unit, 'कोल्ड-चेन थप शुल्क', 'तापक्रम नियन्त्रित ढुवानी', 'रु ५००', 'थप शुल्क'),
      ]),
    ),
    ProfileSection(
      title: 'कार्यतालिका (Availability)',
      child: AppCard(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const InfoRow(Icons.location_on_outlined, 'आधार केन्द्र (Base)', 'भरतपुर-१०, चितवन'),
            const InfoRow(Icons.schedule, 'सोमबार – शनिबार', 'बिहान ५:०० – राति ९:००'),
            const InfoRow(Icons.nightlight_outlined, 'आइतबार', 'पूर्व-बुकिङमा मात्र'),
            const InfoRow(Icons.emergency_outlined, 'आपतकालीन ढुवानी', 'सम्पर्क गरेमा उपलब्ध', iconColor: Colors.redAccent),
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
        header: 'आम्दानी तथा भुक्तानी (Private)',
        balance: 'रु ३८,४२०.००',
        note: 'यस हप्ताको कमाई: रु १४,६५०  •  सोमबार स्वतः जम्मा हुनेछ',
        bank: 'Global IME Bank\n•••• •••• 3278 (सत्यापित)',
        links: ['Trip Logs', 'रसिद'],
      ),
    ),
    ProfileSection(
      title: 'किसान तथा व्यापारी प्रतिक्रिया (Reviews)',
      trailing: TextButton(onPressed: () {}, child: const Text('सबै हेर्नुहोस् (१९६)')),
      child: const Column(children: [
        ReviewCard('राम कुमार श्रेष्ठ', 'धादिङ दुग्ध सहकारी संघ', 'विकासजीले दूध समयमै र चिसो अवस्थामै काठमाडौं पुर्‍याइदिनुभयो। एक थोपा पनि खेर गएन।'),
        ReviewCard('मीना कुमारी थापा', 'काभ्रे गोलभेंडा टनेल सञ्जाल', 'गोलभेंडा क्रेटमा राम्रोसँग मिलाएर लैजानुभयो। ढुवानीमा विश्वासिलो चालक हुनुहुन्छ।'),
      ]),
    ),
  ],

  // settings
  alertTitle: 'नयाँ ढुवानी अलर्ट',
  alertSubtitle: 'नजिकको कामको सूचना तुरुन्तै पाउने',
  settingsAfter: [
    ListTile(
      leading: const Icon(Icons.lock_outline, color: _blue),
      title: const Text('सुरक्षा तथा पिन (Security & PIN)'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    ),
  ],
);

// ---------------------------------------------------------------------------
// Driver-only section: the active trip card
// ---------------------------------------------------------------------------
class _ActiveTripCard extends StatelessWidget {
  const _ActiveTripCard();

  @override
  Widget build(BuildContext context) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.local_shipping, color: _blue),
            SizedBox(width: 8),
            Expanded(child: Text('हालको ढुवानी (Active Trip)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            Pill('यात्रामा'),
          ]),
          const SizedBox(height: 12),
          const Row(children: [
            Expanded(child: Text('भरतपुर, चितवन', style: TextStyle(fontWeight: FontWeight.w600))),
            Icon(Icons.arrow_forward, size: 18, color: Colors.black45),
            Expanded(child: Text('कलंकी, काठमाडौं', textAlign: TextAlign.end, style: TextStyle(fontWeight: FontWeight.w600))),
          ]),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const LinearProgressIndicator(value: 0.62, minHeight: 8, color: _blue, backgroundColor: _blueTint),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('६२% पूरा', style: TextStyle(fontSize: 12, color: Colors.black54)),
              Text('अनुमानित आगमन: १ घण्टा ४० मिनेट', style: TextStyle(fontSize: 12, color: Colors.black54)),
            ],
          ),
          const Divider(height: 22),
          const InfoRow(Icons.inventory_2_outlined, 'दूध ४०० लि. (Cold chain)', 'धादिङ दुग्ध सहकारी संघ → काठमाडौं डेरी'),
          const SizedBox(height: 4),
          Row(children: [
            Expanded(child: OutlinedButton.icon(onPressed: () {}, icon: const Icon(Icons.call_outlined), label: const Text('सम्पर्क'))),
            const SizedBox(width: 8),
            Expanded(child: FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.navigation_outlined), label: const Text('नक्सा'))),
          ]),
        ],
      ),
    );
  }
}
