import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pravesh_screen/student/QRGenerator.dart';
import 'package:pravesh_screen/app_colors_provider.dart';
import 'package:pravesh_screen/cryptoUtils.dart';
import 'package:uuid/uuid.dart';

class ExitFormHomePage extends StatefulWidget {
  const ExitFormHomePage({super.key});

  @override
  State<ExitFormHomePage> createState() => _ExitFormHomePageState();
}

class _ExitFormHomePageState extends State<ExitFormHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final double targetLatitude = 20.95007;
  final double targetLongitude = 79.02626;
  final double allowedRadius = 10000;

  String? _selectedReasonType;
  bool _showOtherReasonField = false;
  bool _isLoading = false;

  final List<String> _reasonOptions = ['Nagpur', 'Butibori', 'Walk', 'Others'];

  Future<bool> isWithinRadius() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      _showErrorDialog('Location services are disabled.');
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        _showErrorDialog('Location permission denied.');
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      _showErrorDialog(
          'Location permission is permanently denied. Please enable it in settings.');
      return false;
    }

    Position position = await Geolocator.getCurrentPosition();
    return Geolocator.distanceBetween(
          position.latitude,
          position.longitude,
          targetLatitude,
          targetLongitude,
        ) <=
        allowedRadius;
  }

  @override
  void dispose() {
    _reasonController.dispose();
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: colors.white,
            size: screenWidth * 0.075, // ~28px on 375px width
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        title: Text(
          "EXIT FORM",
          style: TextStyle(
            color: colors.white,
            fontSize: screenWidth * 0.055, // ~20.6px
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.04), // ~15px
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.04, // ~15px
                    vertical: screenHeight * 0.02 // ~16px on 812px height
                    ),
                decoration: BoxDecoration(
                  color: colors.green.withOpacity(0.2),
                  borderRadius:
                      BorderRadius.circular(screenWidth * 0.03), // ~11px
                  border: Border.all(color: colors.green, width: 1),
                ),
                child: Center(
                  child: Text(
                    'Fill the details to Exit',
                    style: TextStyle(
                      color: colors.green,
                      fontSize: screenWidth * 0.045, // ~17px
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.06), // ~49px

              // Reason Type
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reason Type',
                    style: TextStyle(
                      color: colors.white,
                      fontSize: screenWidth * 0.04, // ~15px
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.015), // ~12px
                  Container(
                    decoration: BoxDecoration(
                      color: colors.box,
                      borderRadius:
                          BorderRadius.circular(screenWidth * 0.03), // ~11px
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.03, // ~11px
                    ),
                    child: DropdownButtonFormField<String>(
                      value: _selectedReasonType,
                      dropdownColor: colors.box,
                      icon: Icon(Icons.arrow_drop_down, color: colors.green),
                      iconSize: screenWidth * 0.06, // ~22px
                      style: TextStyle(
                        color: colors.white,
                        fontSize: screenWidth * 0.04, // ~15px
                      ),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.list_alt_outlined,
                          color: colors.green,
                          size: screenWidth * 0.06, // ~22px
                        ),
                      ),
                      hint: Text(
                        'Select Reason Type',
                        style: TextStyle(
                          color: colors.hintText,
                          fontSize: screenWidth * 0.04, // ~15px
                        ),
                      ),
                      items: _reasonOptions.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          _selectedReasonType = newValue;
                          _showOtherReasonField = newValue == 'Others';
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: screenHeight * 0.04), // ~32px

              // Other Reason Field
              if (_showOtherReasonField)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Specify Reason',
                      style: TextStyle(
                        color: colors.white,
                        fontSize: screenWidth * 0.04, // ~15px
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.015), // ~12px
                    TextFormField(
                      controller: _reasonController,
                      style: TextStyle(color: colors.white),
                      maxLines: 1,
                      decoration: InputDecoration(
                        hintText: 'Enter your reason...',
                        hintStyle: TextStyle(color: colors.hintText),
                        prefixIcon: Icon(
                          Icons.edit_outlined,
                          color: colors.green,
                          size: screenWidth * 0.06, // ~22px
                        ),
                        filled: true,
                        fillColor: colors.box,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(
                              screenWidth * 0.03), // ~11px
                          borderSide: BorderSide.none,
                        ),
                        contentPadding:
                            EdgeInsets.all(screenWidth * 0.04), // ~15px
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.04), // ~32px
                  ],
                ),

              SizedBox(height: screenHeight * 0.06), // ~49px

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Cancel Button
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: colors.box,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.06, // ~22px
                        vertical: screenHeight * 0.02, // ~16px
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(screenWidth * 0.03), // ~11px
                        side: BorderSide(color: colors.green),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.close,
                            size: screenWidth * 0.06, // ~22px
                            color: colors.green),
                        SizedBox(width: screenHeight * 0.01), // ~8px
                        Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: screenWidth * 0.045, // ~17px
                            color: colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Submit Button or Loader
                  _isLoading
                      ? CircularProgressIndicator(color: colors.green)
                      : ElevatedButton(
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth * 0.06, // ~22px
                              vertical: screenHeight * 0.02, // ~16px
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  screenWidth * 0.03), // ~11px
                            ),
                            elevation: 5,
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.check,
                                  size: screenWidth * 0.06, // ~22px
                                  color: colors.white),
                              SizedBox(width: screenHeight * 0.01), // ~8px
                              Text(
                                'Submit',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045, // ~17px
                                  color: colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),

              SizedBox(height: screenHeight * 0.04), // ~32px

              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05), // ~19px
                child: Text(
                  'Note: QR code will only generate if you are within campus boundaries.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.hintText,
                    fontSize: screenWidth * 0.035, // ~13px
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_selectedReasonType == null) {
      _showErrorDialog('Please select a reason type.');
      return;
    }

    if (_showOtherReasonField && _reasonController.text.trim().isEmpty) {
      _showErrorDialog('Please specify your reason.');
      return;
    }

    setState(() => _isLoading = true);

    try {
      if (!await isWithinRadius()) return;

      String reasonType = _selectedReasonType!;
      String reasonDetails = _reasonController.text.trim();

      if (_showOtherReasonField) {
        reasonType = reasonDetails;
      }

      final encryptedData = CryptoUtils.encryptData({
        "UniqueID": Uuid().v4(),
        "ReasonType": reasonType,
        "ReasonDetails": reasonDetails,
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeGenerator(encryptedData: encryptedData),
        ),
      );
    } catch (e) {
      _showErrorDialog('Error: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorDialog(String message) {
    final colors = appColors(context);
    final screenWidth = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.box,
        title: Text(
          'Error',
          style: TextStyle(
            color: colors.white,
            fontSize: screenWidth * 0.045, // ~17px
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            color: colors.hintText,
            fontSize: screenWidth * 0.04, // ~15px
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'OK',
              style: TextStyle(
                color: colors.green,
                fontSize: screenWidth * 0.04, // ~15px
              ),
            ),
          ),
        ],
      ),
    );
  }
}
