import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hout_admin_panel/modals/product_modal.dart';
import 'package:hout_admin_panel/service/auth_service.dart';
import 'package:hout_admin_panel/service/firestore.dart';

//Signup
final isSignupProvider = StateProvider<bool>((ref) {
  return false;
});

//Auth

final authprovider = Provider<AuthService>((ref) {
  return AuthService();
});
final authStateprovider =
    StreamProvider((ref) => ref.read(authprovider).authState);

//Products
final img1Provider = StateProvider<Uint8List?>((ref) {
  return null;
});
final img2Provider = StateProvider<Uint8List?>((ref) {
  return null;
});
final img3Provider = StateProvider<Uint8List?>((ref) {
  return null;
});
final roomTypeProvider = StateProvider<String?>((ref) {
  return "";
});
final categoryProvider = StateProvider<String?>((ref) {
  return "";
});

// get Products
final getProductsProvider = StreamProvider<QuerySnapshot<Products>>((ref) {
  return FirestoreService().getProducts();
});
