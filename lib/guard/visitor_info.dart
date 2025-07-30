import 'package:flutter/material.dart';
import 'package:pravesh_screen/guard/request2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Visitor Information',
      theme: ThemeData(
        brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color.fromARGB(255, 52, 59, 72),
        fontFamily: 'Inter',
      ),
      home: const VisitorInformationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class VisitorInformationScreen extends StatefulWidget {
  const VisitorInformationScreen({super.key});

  @override
  State<VisitorInformationScreen> createState() =>
      _VisitorInformationScreenState();
}

class _VisitorInformationScreenState extends State<VisitorInformationScreen> {
  String? _selectedTeacher;
  final List<String> _teachers = ['Prof. Johnson', 'Prof. Brown', 'Dr. Smith'];

  @override
  Widget build(BuildContext context) {
    const secondaryTextColor = Color(0xFF9E9E9E);
    const accentGreen = Color(0xFF34D17B);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // ✅ Back works now
          },
        ),
        title: const Text(
          'Visitor Information',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 4.0, bottom: 24.0),
            child: Text(
              'Fill in visitor details and select teacher',
              style: TextStyle(color: secondaryTextColor, fontSize: 15),
            ),
          ),

          // Photo card
          _buildPhotoCapturedCard(),
          const SizedBox(height: 24),

          // Visitor Name
          _buildLabel('Visitor Name'),
          const SizedBox(height: 12),
          TextFormField(
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: _buildInputDecoration("Enter visitor's full name"),
          ),
          const SizedBox(height: 20),

          // Reason
          _buildLabel('Reason for Visit'),
          const SizedBox(height: 12),
          TextFormField(
            maxLines: 4,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            decoration: _buildInputDecoration("Enter the purpose of visit"),
          ),
          const SizedBox(height: 20),

          // Teacher Selection
          _buildLabel('Select Teacher to Meet'),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: _selectedTeacher,
            items: _teachers.map((String teacher) {
              return DropdownMenuItem<String>(
                value: teacher,
                child: Text(teacher),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                _selectedTeacher = newValue;
              });
            },
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontFamily: 'Inter'),
            icon: const Icon(Icons.keyboard_arrow_down_rounded,
                color: Colors.white70, size: 28),
            decoration: _buildInputDecoration("Choose a teacher"),
            dropdownColor: const Color(0xFF273348),
          ),
          const SizedBox(height: 40),

          // Send Button
          _buildSendRequestButton(accentGreen),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
          fontFamily: 'Inter',
        ),
        children: const [
          TextSpan(
            text: ' *',
            style: TextStyle(
              color: Color(0xFFF44336),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoCapturedCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF273348),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.3),
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Photo Captured',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Visitor identification photo',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSendRequestButton(Color accentGreen) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.send_rounded, size: 20),
      label: const Text('Send Request to Teacher'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const RequestStatusScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: accentGreen,
        minimumSize: const Size(double.infinity, 54),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'Inter',
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF273348),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.15),
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide(
          color: Colors.white.withOpacity(0.15),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(
          color: Color(0xFF34D17B),
          width: 1.5,
        ),
      ),
    );
  }
}
