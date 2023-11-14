import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hout_admin_panel/providers/provider.dart';
import 'package:hout_admin_panel/screens/login_screen.dart';
import 'package:hout_admin_panel/screens/signup_screen.dart';

class LoginorSignup extends ConsumerWidget {
  const LoginorSignup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(isSignupProvider) ? SignUpScreen() : LoginScreen();
  }
}
