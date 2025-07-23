import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pravesh_screen/QRGenerator.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/cryptoUtils.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class LeaveFormHomePage extends StatefulWidget {
  const LeaveFormHomePage({super.key, required this.title});
  final String title;

  @override
  State<LeaveFormHomePage> createState() => _LeaveFormHomePageState();
}

class _LeaveFormHomePageState extends State<LeaveFormHomePage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, dynamic> qrData = {
    "name": "abc",
    "username": "ese",
    "user_id": "bt24cseXXX",
    "phone_numebr": 123456789,
    "type": "exit"
  };

  final double targetLatitude = 20.95007;
  final double targetLongitude = 79.02626;
  final double allowedRadius = 10000;

  final _reasonController = TextEditingController();
  final _destinationController = TextEditingController();
  final _returnDateController = TextEditingController();
  final _emergencyContactController = TextEditingController();

  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    isWithinRadius();
  }

  Future<bool> isWithinRadius() async {
    if (!await Geolocator.isLocationServiceEnabled()) return false;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return false;
    }
    if (permission == LocationPermission.deniedForever) return false;

    Position position = await Geolocator.getCurrentPosition();
    return Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          targetLatitude,
          targetLongitude,
        ) <=
        allowedRadius;
  }

  Future<void> _selectDate(BuildContext context) async {
    final colors = appColors(context);
    final DateTime now = DateTime.now();
    final DateTime initialDate = _selectedDate ?? now;

    final DateTime firstDate = now;
    final DateTime lastDate = DateTime(now.year + 1);

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.dark(
              primary: colors.green,
              onPrimary: colors.white,
              onSurface: colors.white,
            ),
            dialogTheme: DialogThemeData(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(
              alwaysUse24HourFormat: true, textScaler: TextScaler.linear(1.0),
            ),
            child: child ?? const SizedBox(),
          ),
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      if (!mounted) return;
      setState(() {
        _selectedDate = picked;
        _returnDateController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _destinationController.dispose();
    _returnDateController.dispose();
    _emergencyContactController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        backgroundColor: colors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colors.white, size: 30),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "LEAVE FORM",
          style: TextStyle(
            color: colors.white,
            fontSize: screenWidth * 0.055,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(screenWidth * 0.03),
                ),
                child: Text(
                  'Fill the form to request leave',
                  style: TextStyle(
                    color: colors.green,
                    fontSize: screenWidth * 0.04,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.04),
              _buildTextField(
                context,
                label: 'Reason for Leave',
                hint: 'Enter your reason...',
                icon: Icons.question_answer,
                controller: _reasonController,
                maxLines: 3,
              ),
              SizedBox(height: screenHeight * 0.03),
              _buildTextField(
                context,
                label: 'Destination',
                hint: 'Where are you going?',
                icon: Icons.place_outlined,
                controller: _destinationController,
              ),
              SizedBox(height: screenHeight * 0.03),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: _buildTextField(
                          context,
                          label: 'Return Date',
                          hint: 'Select date',
                          icon: Icons.calendar_today,
                          controller: _returnDateController,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.03),
                  Expanded(
                    child: _buildTextField(
                      context,
                      label: 'Emergency Contact',
                      hint: 'Additional number',
                      icon: Icons.phone,
                      controller: _emergencyContactController,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.06),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.box,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                        side: BorderSide(color: colors.green),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.close,
                            size: screenWidth * 0.06, color: colors.green),
                        SizedBox(width: screenHeight * 0.01),
                        Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.green,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06,
                        vertical: screenHeight * 0.02,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(screenWidth * 0.03),
                      ),
                      elevation: 5,
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.check,
                            size: screenWidth * 0.06, color: colors.white),
                        SizedBox(width: screenHeight * 0.01),
                        Text(
                          'Submit',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045,
                            color: colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    int maxLines = 1,
  }) {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: colors.white,
            fontSize: screenWidth * 0.04,
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        TextFormField(
          controller: controller,
          validator: (value) => value?.isEmpty ?? true ? 'Required' : null,
          style: TextStyle(color: colors.white),
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: colors.hintText),
            prefixIcon: Icon(icon, color: colors.green),
            filled: true,
            fillColor: colors.box,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(screenWidth * 0.03),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.all(screenWidth * 0.04),
          ),
        ),
      ],
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      if (!await isWithinRadius()) {
        _showErrorDialog('You must be within campus boundaries');
        return;
      }

      final encryptedData = CryptoUtils.encryptData({
        ...qrData,
        "UniqueID": const Uuid().v4(),
        "Reason": _reasonController.text,
        "Destination": _destinationController.text,
        "ReturnDate": _returnDateController.text,
        "EmergencyContact": _emergencyContactController.text,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeGenerator(encryptedData: encryptedData),
        ),
      );
    } catch (e) {
      _showErrorDialog('Error: $e');
    }
  }

  void _showErrorDialog(String message) {
    final colors = appColors(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.box,
        title: Text('Error', style: TextStyle(color: colors.white)),
        content: Text(message, style: TextStyle(color: colors.hintText)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK', style: TextStyle(color: colors.green)),
          ),
        ],
      ),
    );
  }
}
