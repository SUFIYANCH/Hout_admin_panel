import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hout_admin_panel/modals/product_modal.dart';

class FirestoreService {
  CollectionReference<Products> firestore = FirebaseFirestore.instance
      .collection("products")
      .withConverter(
          fromFirestore: Products.fromFirestore,
          toFirestore: (value, options) => value.toFirestore());

  Future<DocumentReference<Products>> addProducts(Products data) async {
    return await firestore.add(data);
  }

  Stream<DocumentSnapshot<Products>> getProducts() {
    return firestore.doc().snapshots();
  }
}
