import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SignInAppleId extends StatefulWidget {
  @override
  _SignInAppleIdState createState() => _SignInAppleIdState();
}

class _SignInAppleIdState extends State<SignInAppleId> {
  Future<void> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        webAuthenticationOptions: WebAuthenticationOptions(
          clientId: 'id.dev-kjt.service-infolelang-api-mobile',
          redirectUri:
              Uri.parse('https://local.test:8888/v1/auth/apple/callback'),
        ),
      );

      print('Authorization Code: ${appleCredential.authorizationCode}');
      print(
          'Full Name: ${appleCredential.givenName} ${appleCredential.familyName}');
      print('Email: ${appleCredential.email}');

      // Kirim ke backend untuk memvalidasi token
      final response = await http.post(
        Uri.parse('https://local.test:8888/v1/auth/apple/callback'),
        body: jsonEncode({
          'authorizationCode': appleCredential.authorizationCode,
          'givenName': appleCredential.givenName,
          'familyName': appleCredential.familyName,
          'email': appleCredential.email,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Sign in successful: ${response.body}');
      } else {
        print('Error signing in: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: signInWithApple,
        child: const Text('Sign In with Apple'),
      ),
    );
  }
}
