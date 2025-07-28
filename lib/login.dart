import 'package:flutter/material.dart';
import 'package:pravesh_screen/initialInfo/intro_pages.dart';
import 'package:pravesh_screen/widgets/herder_container.dart';
import 'package:pravesh_screen/widgets/btn_name.dart';
import 'package:pravesh_screen/warden/warden_home_screen.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String _errorMessage = '';
  bool _showError = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateLogin() {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email == 'a' && password == 'b') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => IntroPages()),
      );
    } else if (email == 'b' && password == 'c') {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WardenHomeScreen()),
    );
  } else {
      setState(() {
        _errorMessage = 'Wrong ID or Password. Please try again!';
        _showError = true;
      });

      Future.delayed(Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            _showError = false;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Color(0xFFF5F5F5),
        padding: EdgeInsets.only(
            bottom: screenHeight * 0.035), // ~30px on 854px height
        child: Column(
          children: <Widget>[
            HeaderContainer(
              text: '',
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                  left: screenWidth * 0.053, // ~20px on 375px width
                  right: screenWidth * 0.053,
                  top: screenHeight * 0.035, // ~30px on 854px height
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    _textInput(
                        controller: _emailController,
                        hint: "CRISPR ID",
                        icon: Icons.email),
                    _textInput(
                        controller: _passwordController,
                        hint: "Password",
                        icon: Icons.vpn_key,
                        isPassword: true),
                    if (_showError)
                      Container(
                        width: double.infinity,
                        margin:
                            EdgeInsets.only(top: screenHeight * 0.012), // ~10px
                        padding: EdgeInsets.all(screenWidth * 0.032), // ~12px
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(
                              screenWidth * 0.021), // ~8px
                        ),
                        child: Text(
                          _errorMessage,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.037, // ~14px
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    Expanded(
                      child: Center(
                        child: ButtonWidget(
                          onClick: _validateLogin,
                          btnText: "LOGIN",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _textInput({
    TextEditingController? controller,
    String? hint,
    IconData? icon,
    bool isPassword = false,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      margin: EdgeInsets.only(top: screenHeight * 0.012), // ~10px
      decoration: BoxDecoration(
        borderRadius:
            BorderRadius.all(Radius.circular(screenWidth * 0.053)), // ~20px
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: screenWidth * 0.027), // ~10px
      child: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        obscureText: isPassword,
        decoration: InputDecoration(
          label: Text(hint!),
          border: InputBorder.none,
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.black,
          labelStyle: TextStyle(
            color: Colors.black,
            fontSize: screenWidth * 0.04, // ~15px
          ),
        ),
      ),
    );
  }
}
