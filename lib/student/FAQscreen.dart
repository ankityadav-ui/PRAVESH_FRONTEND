import 'package:flutter/material.dart';
import 'package:pravesh_screen/app_colors_provider.dart';

class HelpCenterScreen extends StatelessWidget {
  const HelpCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: colors.background,
        appBar: AppBar(
          backgroundColor: colors.background,
          elevation: 0,
          title: Text(
            'Help Center',
            style: TextStyle(
              color: colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          bottom: TabBar(
            indicatorColor: colors.green,
            labelColor: colors.green,
            unselectedLabelColor: colors.white,
            tabs: const [
              Tab(text: 'FAQ'),
              Tab(text: 'Contact Us'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            FAQContent(),
            ContactUsContent(),
          ],
        ),
      ),
    );
  }
}

class FAQContent extends StatelessWidget {
  const FAQContent({super.key});

  final List<Map<String, String>> _faqs = const [
    {
      'question': 'How does the Smart Entry/Exit system work?',
      'answer':
          'The system generates a QR code for entry/exit. The scanner verifies the QR code, granting or denying access based on system rules.',
    },
    {
      'question': 'How long is a generated QR code valid?',
      'answer':
          'The QR code is valid for 10 minutes from the time of generation. If it expires, you need to generate a new one.',
    },
    {
      'question': 'Can I generate a QR code from anywhere?',
      'answer':
          'No, you can only generate a QR code within a 10 km radius of the scanner location to prevent misuse.',
    },
    {
      'question': 'Is my data safe while using the QR system?',
      'answer':
          'Yes, the QR codes are encrypted, ensuring that your personal data is not exposed or misused.',
    },
    {
      'question': 'Can I use a screenshot of my QR code for entry?',
      'answer':
          'No, screenshots are not allowed. The system detects and rejects static images of QR codes. You must generate a new code each time.',
    },
    {
      'question': 'Can I enter multiple times without exiting?',
      'answer':
          'No, you must exit before generating a new entry QR code. The system ensures only one active QR code at a time.',
    },
    {
      'question': 'What should I do if I need to exit for multiple days?',
      'answer':
          'You must fill out a leave form in the app, providing details like your location, duration, return date, and an additional contact number.',
    },
    {
      'question': 'Can I re-enter if I forget to scan my exit QR code?',
      'answer':
          'No, you must exit properly before you can generate a new entry QR code. If an issue occurs, contact support.',
    },
    {
      'question': 'What happens if I generate a QR code but do not use it?',
      'answer':
          'The QR code expires in 10 minutes, and you\'ll need to generate a new one when you\'re ready to enter or exit.',
    },
    {
      'question': 'Can I exit multiple times in a single day?',
      'answer':
          'Yes, but you must scan the exit QR each time and generate a new one for re-entry.',
    },
    {
      'question': 'Why do I need to be within 10 km to generate a QR code?',
      'answer':
          'This ensures that only users physically near the premises can request a QR code, preventing unauthorized access.',
    },
    {
      'question': 'What if someone else tries to use my QR code?',
      'answer':
          'QR codes are encrypted and linked to your account. They cannot be reused or transferred.',
    },
    {
      'question': 'Can I give my QR code to a friend to enter on my behalf?',
      'answer':
          'No, QR codes are non-transferable, and unauthorized use may result in disciplinary action.',
    },
    {
      'question':
          'What if my phone is lost or stolen before scanning the QR code?',
      'answer':
          'Log in from another device and generate a new QR code. The old QR code will be invalid.',
    },
    {
      'question': 'Can I generate a QR code for someone else?',
      'answer':
          'No, each QR code is uniquely generated for individual users and cannot be shared.',
    },
    // ... (include all other FAQ items)
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _faqs.length,
      itemBuilder: (context, index) {
        return _buildFAQItem(
          context,
          _faqs[index]['question']!,
          _faqs[index]['answer']!,
        );
      },
    );
  }

  Widget _buildFAQItem(BuildContext context, String question, String answer) {
    final colors = appColors(context);

    return Card(
      color: colors.box,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          leading: Icon(Icons.help_outline, color: colors.green),
          title: Text(
            question,
            style: TextStyle(
              color: colors.white,
              fontSize: 15.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          iconColor: colors.green,
          collapsedIconColor: colors.green,
          children: [
            Text(
              answer,
              style: TextStyle(
                color: colors.white,
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContactUsContent extends StatefulWidget {
  const ContactUsContent({super.key});

  @override
  State<ContactUsContent> createState() => _ContactUsContentState();
}

class _ContactUsContentState extends State<ContactUsContent> {
  final Map<String, Map<String, dynamic>> _contactOptions = {
    'WhatsApp': {
      'icon': Icons.message,
      'info': '7878356069',
    },
    'Website': {
      'icon': Icons.language,
      'info': 'ankityadav787835@gmail.com',
    },
    'Facebook': {
      'icon': Icons.facebook,
      'info': '@example_facebook',
    },
    'Twitter': {
      'icon': Icons.comment,
      'info': '@example_twitter',
    },
    'Instagram': {
      'icon': Icons.camera_alt,
      'info': 'ankit_yadavv007',
    },
    'Email': {
      'icon': Icons.email,
      'info': 'support@example.com',
    },
  };

  String? _expandedItem;

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: _contactOptions.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: () {
                setState(() {
                  _expandedItem = _expandedItem == entry.key ? null : entry.key;
                });
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: colors.box,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(entry.value['icon'], color: colors.green),
                        const SizedBox(width: 12),
                        Text(
                          entry.key,
                          style: TextStyle(
                            color: colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    if (_expandedItem == entry.key)
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Text(
                          '${entry.key}: ${entry.value['info']}',
                          style: TextStyle(
                            color: colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
