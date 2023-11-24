import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hout_admin_panel/modals/product_modal.dart';

class FirestoreService {
  CollectionReference<Products> firestore = FirebaseFirestore.instance
      .collection("products")
      .withConverter(
          fromFirestore: Products.fromFirestore,
          toFirestore: (value, options) => value.toFirestore());

  Future<DocumentReference<Products>> addProducts(Products data) {
    return firestore.add(data);
  }

  Stream<QuerySnapshot<Products>> getProducts() {
    return firestore.snapshots();
  }

  Future<void> updateProducts(Products updatedata, String id) {
    return firestore.doc(id).set(updatedata);
  }

  Future<void> deleteProducts(String id) {
    return firestore.doc(id).delete();
  }
}
