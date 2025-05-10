import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'models/user_info.dart';
import 'dashboard_screen.dart';

class AuthScreen extends StatefulWidget {
  final String role; // "Parent" or "Child"

  const AuthScreen({super.key, required this.role});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  bool _isSignUp = false;

  @override
  Widget build(BuildContext context) {
    final isParent = widget.role == "Parent";

    return Scaffold(
      backgroundColor: const Color(0xFFF9FFFD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Image.asset('assets/final logo.png', width: 80, height: 80),
                const SizedBox(height: 20),
                Text(
                  widget.role,
                  style: GoogleFonts.kodchasan(
                    fontSize: 22,
                    color: const Color(0xFF5A3DA0),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Username",
                    style: GoogleFonts.kodchasan(
                      fontSize: 14,
                      color: const Color(0xFF5A3DA0),
                    ),
                  ),
                ),
                TextFormField(
                  onChanged: (val) => _username = val,
                  decoration: const InputDecoration(
                    hintText: "Value",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  style: GoogleFonts.kodchasan(fontSize: 14),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Password",
                    style: GoogleFonts.kodchasan(
                      fontSize: 14,
                      color: const Color(0xFF5A3DA0),
                    ),
                  ),
                ),
                TextFormField(
                  obscureText: true,
                  onChanged: (val) => _password = val,
                  decoration: const InputDecoration(
                    hintText: "Value",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  style: GoogleFonts.kodchasan(fontSize: 14),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final userInfo = UserInfo(
                          name: isParent ? "George" : "Peter",
                          role: widget.role,
                          profileImage:
                              isParent
                                  ? 'assets/parent_profile.png'
                                  : 'assets/child_profile.png',
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => DashboardScreen(userInfo: userInfo),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFC94D),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Text(
                      _isSignUp ? "Sign Up" : "Sign In",
                      style: GoogleFonts.kodchasan(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSignUp = !_isSignUp;
                    });
                  },
                  child: Text(
                    _isSignUp
                        ? "Already have an account? Sign In"
                        : "Create Account",
                    style: GoogleFonts.kodchasan(
                      fontSize: 14,
                      color: const Color(0xFFFF7EA2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
