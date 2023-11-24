import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';

class Storage {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadImage(
      Uint8List file, String ext, String category) async {
    final time = DateTime.now().millisecondsSinceEpoch;
    final ref = storage.ref().child("products/$category/$time.$ext");
    await ref.putData(file, SettableMetadata(contentType: "image/$ext"));
    return await ref.getDownloadURL();
  }

  static Future<String> updateImage(
      Uint8List newFile, String ext, String category, String imageUrl) async {
    final oldRef = storage.refFromURL(imageUrl);
    await oldRef.delete();

    // Upload the new image
    final time = DateTime.now().millisecondsSinceEpoch;
    final newRef = storage.ref().child("products/$category/$time.$ext");
    await newRef.putData(newFile, SettableMetadata(contentType: "image/$ext"));
    return await newRef.getDownloadURL(); // You can return this URL if needed
  }
}
