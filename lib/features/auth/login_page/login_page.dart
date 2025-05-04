import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:songguessgame/features/auth/auth_api.dart';
import 'package:songguessgame/features/auth/register_page/register_page.dart';
import 'package:songguessgame/features/view_all_new_games_page/view_all_new_games_page.dart';
import 'package:songguessgame/main.dart';
import 'package:songguessgame/utils/storage_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = const FlutterSecureStorage();

  final _formKey = GlobalKey<FormState>();
  String username = '';
  String password = '';
  bool isLoading = false;
  String errorMessage = '';
  bool _obscureText = true;

  /// Called when the user taps the traditional login button.
  /// Uses username+password flow.
  void _attemptLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      try {
        // Example call to your existing REST endpoint
        final tokens = await login(username, password);
        // Store the token
        await setTokens(tokens);
        await signalR.start(tokens.jwtToken);

        // Navigate to MapView and replace LoginPage
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ViewAllNewGamesPage()),
        );
      } catch (e) {
        setState(() {
          errorMessage = 'Login failed: Invalid username or password';
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Please log in to continue',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 20),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          // USERNAME
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              border: OutlineInputBorder(),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              username = value;
                            },
                          ),
                          const SizedBox(height: 16),

                          // PASSWORD
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Password',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: Icon(_obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscureText,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              password = value;
                            },
                          ),
                          const SizedBox(height: 16),

                          ElevatedButton(
                            onPressed: _attemptLogin,
                            child: const Text('Login'),
                          ),

                          // ERROR MESSAGE
                          if (errorMessage.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 16),
                              child: Text(
                                errorMessage,
                                style: const TextStyle(color: Colors.red),
                              ),
                            ),

                          // NAVIGATE TO REGISTER
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(
                                "Don't have an account? Register here."),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ViewAllNewGamesPage(),
                                ),
                              );
                            },
                            child: const Text(
                                "Don't want to sign up? Continue as guest"),
                          ),

                          //Commenting out login with google/apple for now
                          /*const SizedBox(height: 24),

                          // SIGN IN WITH GOOGLE
                          SignInButton(Buttons.GoogleDark,
                              onPressed: _signInWithGoogle),

                          // SIGN IN WITH APPLE
                          // (Available on iOS 13+ and macOS 10.15+)
                          const SizedBox(height: 8),
                          if (Platform.isIOS)
                            SignInButton(Buttons.AppleDark,
                                onPressed: _signInWithApple),*/
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}






