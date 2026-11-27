// Path: lib/features/logistics/screens/driver_profile.dart

import 'package:flutter/material.dart';
import '../models/logistics_session.dart';
import '../../../shared/widgets/dark_profile_components.dart' as dark;

class DriverProfilePage extends StatefulWidget {
  const DriverProfilePage({super.key});

  @override
  State<DriverProfilePage> createState() => _DriverProfilePageState();
}

class _DriverProfilePageState extends State<DriverProfilePage> {
  @override
  void initState() {
    super.initState();
    LogisticsSession.instance.addListener(_onChange);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (LogisticsSession.instance.isKycFilled) {
        Future.delayed(const Duration(milliseconds: 400), () {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Text('KYC filled. Your profile is now verified!'),
              ),
            );
          }
        });
      }
    });
  }

  @override
  void dispose() {
    LogisticsSession.instance.removeListener(_onChange);
    super.dispose();
  }

  void _onChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final verified = LogisticsSession.instance.isKycFilled;
    final user = LogisticsSession.instance.user;
    final name = (user?.name.isNotEmpty ?? false) ? user!.name : 'Bikash Tamang';
    final role = verified
        ? (user?.vehicleType.isNotEmpty == true ? user!.vehicleType : 'कोल्ड-चेन ट्रक चालक तथा ढुवानी साझेदार')
        : 'KYC Pending';
    final address = (user?.address.isNotEmpty ?? false) ? user!.address : 'भरतपुर-१०, चितवन';

    return Scaffold(
      backgroundColor: dark.DarkProfileTheme.bgDark,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
          children: [
            dark.DarkBannerCard(
              name: name,
              role: role,
              location: address,
              isVerified: verified,
              onEditPressed: () {},
              stats: verified ? [
                dark.StatItem(icon: Icons.workspace_premium, value: '6+ वर्ष', label: 'अनुभव'),
                dark.StatItem(icon: Icons.local_shipping_outlined, value: '२,३१०+', label: 'ढुवानी'),
              ] : [
                dark.StatItem(icon: Icons.workspace_premium, value: '—', label: 'अनुभव'),
                dark.StatItem(icon: Icons.local_shipping_outlined, value: '0', label: 'ढुवानी'),
              ],
            ),
            const SizedBox(height: 16),
            if (!verified) ...[
              dark.DarkVerificationBanner(
                title: 'KYC Pending',
                subtitle: 'Complete KYC to unlock your full profile, earnings, vehicle details and verification status.',
              ),
              const SizedBox(height: 16),
            ],
            if (verified) ...[
              _activeTripCard(),
              const SizedBox(height: 16),
            ],
            dark.DarkSectionHeader(icon: Icons.local_shipping_outlined, title: 'सवारी विवरण (Vehicle)'),
            dark.DarkProfileCard(
              child: Column(children: [
                dark.DarkInfoRow(icon: Icons.local_shipping_outlined, label: 'मिनी ट्रक (Refrigerated)', value: 'क्षमता: १.५ टन • कोल्ड बक्स जडित'),
                dark.DarkInfoRow(icon: Icons.pin_outlined, label: 'नम्बर प्लेट', value: 'बा २ ख ४५६७ (नमुना)'),
                dark.DarkInfoRow(icon: Icons.thermostat_outlined, label: 'तापक्रम नियन्त्रण', value: '२°C – ८°C (दूध तथा तरकारी)'),
                dark.DarkInfoRow(icon: Icons.gps_fixed, label: 'GPS ट्र्याकिङ', value: 'सक्रिय छ'),
              ]),
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.description_outlined, title: 'कागजात तथा इजाजतपत्र (Documents)'),
            dark.DarkProfileCard(
              child: Column(children: [
                dark.DarkInfoRow(icon: Icons.description_outlined, label: 'सवारी चालक अनुमतिपत्र (Driving License)', value: 'नविकृत: २०२९'),
                dark.DarkInfoRow(icon: Icons.description_outlined, label: 'सवारी दर्ता किताब (Bluebook)', value: 'नविकृत: २०२७'),
                dark.DarkInfoRow(icon: Icons.description_outlined, label: 'बीमा (Vehicle Insurance)', value: 'म्याद सकिँदै: ६० दिन'),
              ]),
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.alt_route, title: 'सेवा क्षेत्र (Service Routes)'),
            dark.DarkProfileCard(
              child: Column(children: [
                _routeRow(Icons.alt_route, 'चितवन ⇄ काठमाडौं', 'दैनिक • कोल्ड-चेन तथा सुख्खा सामान'),
                _routeRow(Icons.alt_route, 'धादिङ ⇄ काठमाडौं', 'दूध तथा तरकारी संकलन मार्ग'),
                _routeRow(Icons.alt_route, 'काभ्रे ⇄ ललितपुर', 'गोलभेंडा तथा फलफूल ढुवानी'),
              ]),
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.route_outlined, title: 'ढुवानी शुल्क दर (Freight Rates)'),
            dark.DarkProfileCard(
              child: Column(children: [
                _feeRow(Icons.route_outlined, 'प्रति किलोमिटर दर', 'लोड अनुसार परिवर्तन हुन सक्छ', 'रु ६५', 'प्रति कि.मि.'),
                _feeRow(Icons.local_shipping_outlined, 'न्यूनतम ढुवानी शुल्क', '२५ कि.मि. भित्रको छोटो यात्रा', 'रु २,५००', 'प्रति ट्रिप'),
                _feeRow(Icons.hourglass_bottom, 'प्रतीक्षा शुल्क', 'लोडिङ/अनलोडिङमा ३० मिनेटपछि', 'रु २००', 'प्रति घण्टा'),
                _feeRow(Icons.ac_unit, 'कोल्ड-चेन थप शुल्क', 'तापक्रम नियन्त्रित ढुवानी', 'रु ५००', 'थप शुल्क'),
              ]),
            ),
            const SizedBox(height: 16),
            dark.DarkSectionHeader(icon: Icons.schedule, title: 'कार्यतालिका (Availability)'),
            dark.DarkProfileCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  dark.DarkInfoRow(icon: Icons.location_on_outlined, label: 'आधार केन्द्र (Base)', value: 'भरतपुर-१०, चितवन'),
                  dark.DarkInfoRow(icon: Icons.schedule, label: 'सोमबार – शनिबार', value: 'बिहान ५:०० – राति ९:००'),
                  dark.DarkInfoRow(icon: Icons.nightlight_outlined, label: 'आइतबार', value: 'पूर्व-बुकिङमा मात्र'),
                  dark.DarkInfoRow(icon: Icons.emergency_outlined, label: 'आपतकालीन ढुवानी', value: 'सम्पर्क गरेमा उपलब्ध'),
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

  Widget _activeTripCard() {
    return dark.DarkProfileCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(children: [
            Icon(Icons.local_shipping, color: dark.DarkProfileTheme.primaryGreen),
            SizedBox(width: 8),
            Expanded(child: Text('हालको ढुवानी (Active Trip)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
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
            child: const LinearProgressIndicator(value: 0.62, minHeight: 8),
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
          dark.DarkInfoRow(icon: Icons.inventory_2_outlined, label: 'दूध ४०० लि. (Cold chain)', value: 'धादिङ दुग्ध सहकारी संघ → काठमाडौं डेरी'),
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

  Widget _routeRow(IconData icon, String title, String sub) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Icon(icon, color: dark.DarkProfileTheme.textMuted, size: 20),
        const SizedBox(width: 14),
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
            leading: const Icon(Icons.lock_outline, color: dark.DarkProfileTheme.primaryGreen),
            title: const Text('सुरक्षा तथा पिन (Security & PIN)', style: TextStyle(color: Colors.white)),
            trailing: const Icon(Icons.chevron_right, color: dark.DarkProfileTheme.textMuted),
            onTap: () {},
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
