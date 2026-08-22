import 'package:flutter/material.dart';

/// General Auth Container Shell View.
class AuthView extends StatelessWidget {
  final Widget child;

  const AuthView({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}
