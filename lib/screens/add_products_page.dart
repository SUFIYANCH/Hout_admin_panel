import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hout_admin_panel/modals/product_modal.dart';
import 'package:hout_admin_panel/providers/provider.dart';
import 'package:hout_admin_panel/service/firestore.dart';
import 'package:hout_admin_panel/service/storage_service.dart';
import 'package:image_picker/image_picker.dart';

class AddProductsPage extends ConsumerWidget {
  AddProductsPage({super.key});

  final roomTypeList = [
    "Kitchen Room",
    "Family Room",
    "Dining Room",
    "Living Room",
    "Bedroom",
    "Guest Room",
  ];
  final categoryList = [
    "Dining Table",
    "Chairs",
    "Writing Table",
    "Bench",
    "Bed",
    "Sofa",
  ];
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController sellerNameController = TextEditingController();
  final TextEditingController productDescriptionController =
      TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();
  final TextEditingController warrantyController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController primaryMaterialController =
      TextEditingController();
  final TextEditingController colorController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              isExpanded: true,
              hint: const Text("Category"),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: categoryList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                ref.read(categoryProvider.notifier).state = newValue;
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            controller: productNameController,
            hinttext: "Product Name",
          ),
          CustomTextField(
            controller: sellerNameController,
            hinttext: "Seller Name",
          ),
          CustomTextField(
            controller: productDescriptionController,
            hinttext: "Product Description",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Text(
                      'Add image (1)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          final pickedImage1 = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (pickedImage1 != null) {
                            var img1 = pickedImage1.readAsBytes();

                            ref.read(img1Provider.notifier).state = await img1;
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No image is selected")));
                            }
                          }
                        } catch (e) {
                          Text(e.toString());
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ref.watch(img1Provider) == null
                              ? const Placeholder()
                              : Image.memory(
                                  ref.watch(img1Provider)!,
                                  width: 400,
                                )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Text(
                      'Add image (2)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          final pickedImage2 = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                          if (pickedImage2 != null) {
                            var img2 = pickedImage2.readAsBytes();

                            ref.read(img2Provider.notifier).state = await img2;
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No image is selected")));
                            }
                          }
                        } catch (e) {
                          Text(e.toString());
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ref.watch(img2Provider) == null
                              ? const Placeholder()
                              : Image.memory(
                                  ref.watch(img2Provider)!,
                                  width: 400,
                                )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(width: 1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const Text(
                      'Add image (3)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        try {
                          final pickedImage3 = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);

                          if (pickedImage3 != null) {
                            var img3 = pickedImage3.readAsBytes();

                            ref.read(img3Provider.notifier).state = await img3;
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("No image is selected")));
                            }
                          }
                        } catch (e) {
                          Text(e.toString());
                        }
                      },
                      child: Container(
                          padding: const EdgeInsets.all(10),
                          child: ref.read(img3Provider) == null
                              ? const Placeholder()
                              : Image.memory(
                                  ref.watch(img3Provider)!,
                                  width: 400,
                                )),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            controller: mrpController,
            hinttext: "MRP",
          ),
          CustomTextField(
            controller: offerPriceController,
            hinttext: "Offer Price",
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.5,
            child: DropdownButtonFormField(
              decoration: const InputDecoration(border: OutlineInputBorder()),
              isExpanded: true,
              hint: const Text("Room Type"),
              icon: const Icon(Icons.keyboard_arrow_down),
              items: roomTypeList.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              onChanged: (String? newValue) {
                ref.read(roomTypeProvider.notifier).state = newValue;
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextField(
            controller: warrantyController,
            hinttext: "Warranty",
          ),
          CustomTextField(
            controller: weightController,
            hinttext: "Weight",
          ),
          CustomTextField(
            controller: brandController,
            hinttext: "Brand",
          ),
          CustomTextField(
            controller: primaryMaterialController,
            hinttext: "Primary_material",
          ),
          CustomTextField(
            controller: colorController,
            hinttext: "Color",
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 50),
                  backgroundColor: Colors.amber,
                  foregroundColor: Colors.black),
              onPressed: () async {
                String downloadimg1 = await Storage.uploadImage(
                    ref.watch(img1Provider)!,
                    "png",
                    ref.watch(categoryProvider)!);

                String downloadimg2 = await Storage.uploadImage(
                    ref.watch(img2Provider)!,
                    "png",
                    ref.watch(categoryProvider)!);
                String downloadimg3 = await Storage.uploadImage(
                    ref.watch(img3Provider)!,
                    "png",
                    ref.watch(categoryProvider)!);

                await FirestoreService()
                    .addProducts(Products(
                  category: ref.watch(categoryProvider),
                  name: productNameController.text,
                  seller: sellerNameController.text,
                  description: productDescriptionController.text,
                  img: [downloadimg1, downloadimg2, downloadimg3],
                  mrp: mrpController.text,
                  offerprice: offerPriceController.text,
                  roomType: ref.watch(roomTypeProvider),
                  warranty: warrantyController.text,
                  weight: weightController.text,
                  brand: brandController.text,
                  material: primaryMaterialController.text,
                  color: colorController.text,
                ))
                    .then((value) {
                  ref.watch(img1Provider.notifier).state = null;
                  ref.watch(img2Provider.notifier).state = null;
                  ref.watch(img3Provider.notifier).state = null;

                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Products Added Successfully")));
                });
              },
              child: const Text("Add Products")),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hinttext;
  final TextEditingController? controller;
  const CustomTextField(
      {super.key, required this.hinttext, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
                hintText: hinttext, border: const OutlineInputBorder()),
          ),
        ),
        const SizedBox(
          height: 15,
        )
      ],
    );
  }
}
