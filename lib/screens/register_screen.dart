import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_call_app/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            TextField(
              controller: _confirmPasswordController,
              decoration: InputDecoration(labelText: 'Confirm Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : () async {
                final email = _emailController.text;
                final password = _passwordController.text;
                final confirmPassword = _confirmPasswordController.text;

                // Validate email
                if (email.isEmpty || !email.contains('@')) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please enter a valid email address')),
                  );
                  return;
                }

                // Validate password
                if (password.isEmpty || password.length < 6) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Password must be at least 6 characters')),
                  );
                  return;
                }

                // Confirm password
                if (password != confirmPassword) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Passwords do not match')),
                  );
                  return;
                }

                setState(() {
                  _isLoading = true;
                });

                try {
                  await authService.signUp(email, password);
                  Navigator.pop(context); // Go back to the login screen
                } catch (e) {
                  print('Registration error: $e'); // Print the error to the console
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to register: $e')),
                  );
                } finally {
                  setState(() {
                    _isLoading = false;
                  });
                }
              },
              child: _isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('Register'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the login screen
              },
              child: Text('Already have an account? Login'),
            ),
          ],
        ),
      ),
    );
  }
}