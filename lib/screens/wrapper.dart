import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase User
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/services/auth_service.dart';
import 'package:video_call_app/screens/login_screen.dart';
import 'package:video_call_app/screens/home_screen.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return StreamBuilder<User?>(
      stream: authService.userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user == null ? LoginScreen() : HomeScreen();
        } else {
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}