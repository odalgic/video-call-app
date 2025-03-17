import 'package:firebase_core/firebase_core.dart'; // Required for Firebase initialization
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/services/auth_service.dart';
import 'package:video_call_app/screens/wrapper.dart';
import 'package:video_call_app/screens/login_screen.dart';
import 'package:video_call_app/screens/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully');
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: MaterialApp(
        title: 'Video Call App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Wrapper(),
        routes: {
          '/login': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
        },
      ),
    );
  }
}