import 'package:cloud_firestore/cloud_firestore.dart';

class Products {
  String? category;
  String? name;
  String? seller;
  String? description;
  List<String> img;
  String? mrp;
  String? offerprice;
  String? roomType;
  String? warranty;
  String? weight;
  String? brand;
  String? material;
  String? color;

  Products({
    required this.category,
    required this.name,
    required this.seller,
    required this.description,
    required this.img,
    required this.mrp,
    required this.offerprice,
    required this.roomType,
    required this.warranty,
    required this.weight,
    required this.brand,
    required this.material,
    required this.color,
  });

  factory Products.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Products(
      category: data?["category"],
      name: data?["name"],
      seller: data?["seller"],
      description: data?["description"],
      img: data?["img"],
      mrp: data?["mrp"],
      offerprice: data?["offerprice"],
      roomType: data?["roomtype"],
      warranty: data?["warranty"],
      weight: data?["weight"],
      brand: data?["brand"],
      material: data?["material"],
      color: data?["color"],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "category": category,
      "name": name,
      "seller": seller,
      "description": description,
      "img": img,
      "mrp": mrp,
      "offerprice": offerprice,
      "roomtype": roomType,
      "warranty": warranty,
      "weight": weight,
      "brand": brand,
      "material": material,
      "color": color,
    };
  }
}
