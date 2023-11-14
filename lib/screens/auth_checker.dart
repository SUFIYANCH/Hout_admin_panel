import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hout_admin_panel/providers/provider.dart';
import 'package:hout_admin_panel/screens/admin_page.dart';
import 'package:hout_admin_panel/screens/loginorsignup.dart';

class Authchecker extends ConsumerWidget {
  const Authchecker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(authStateprovider).when(
      data: (data) {
        return data == null ? const LoginorSignup() : const AdminPage();
      },
      error: (error, stackTrace) {
        return const Text('Something Went Wrong');
      },
      loading: () {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
