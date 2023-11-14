import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hout_admin_panel/providers/provider.dart';
import 'package:hout_admin_panel/service/firestore.dart';
import 'package:hout_admin_panel/widgets/textfield_widget.dart';
import 'package:image_picker/image_picker.dart';

class ProductsScreen extends ConsumerWidget {
  ProductsScreen({super.key});

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
  final categoryList = [
    "Dining Table",
    "Chairs",
    "Writing Table",
    "Bench",
    "Bed",
    "Sofa",
  ];
  final roomTypeList = [
    "Kitchen Room",
    "Family Room",
    "Dining Room",
    "Living Room",
    "Bedroom",
    "Guest Room",
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Products"),
      ),
      body: ref.watch(getProductsProvider).when(
            data: (data) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    var datas = data.docs[index].data();
                    log(datas.toString());

                    return Card(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Image.network(
                              datas.img[1],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "${datas.name}",
                                style: const TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("${datas.brand}"),
                                  Text("${datas.category}"),
                                ],
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2,
                                  child: Text("${datas.description}")),
                              Text("MRP : ₹${datas.mrp}"),
                              Text("Offer Price : ₹${datas.offerprice}"),
                              Text("Room Type : ${datas.roomType}"),
                              Text("Warrenty : ${datas.warranty}"),
                              Text("Material : ${datas.material}"),
                              Text("Colour : ${datas.color}"),
                            ],
                          ),
                          TextButton.icon(
                              onPressed: () {
                                productNameController.text =
                                    datas.name.toString();
                                sellerNameController.text =
                                    datas.seller.toString();

                                brandController.text = datas.brand.toString();
                                productDescriptionController.text =
                                    datas.description.toString();
                                mrpController.text = datas.mrp.toString();
                                offerPriceController.text =
                                    datas.offerprice.toString();
                                warrantyController.text =
                                    datas.warranty.toString();
                                primaryMaterialController.text =
                                    datas.material.toString();
                                colorController.text = datas.color.toString();
                                weightController.text = datas.weight.toString();

                                ref.read(categoryProvider.notifier).state =
                                    datas.category;
                                ref.read(roomTypeProvider.notifier).state =
                                    datas.roomType;

                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title:
                                            const Text("Update the products"),
                                        content: SingleChildScrollView(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: DropdownButtonFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  isExpanded: true,
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  value: ref
                                                      .watch(categoryProvider),
                                                  hint: const Text("Category"),
                                                  items: categoryList
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    ref
                                                        .read(categoryProvider
                                                            .notifier)
                                                        .state = newValue;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 15,
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller:
                                                    productNameController,
                                                hinttext: "Product Name",
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller:
                                                    sellerNameController,
                                                hinttext: "Seller Name",
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller:
                                                    productDescriptionController,
                                                hinttext: "Product Description",
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          'Add image (1)',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            try {
                                                              final pickedImage1 =
                                                                  await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);

                                                              if (pickedImage1 !=
                                                                  null) {
                                                                var img1 =
                                                                    pickedImage1
                                                                        .readAsBytes();

                                                                ref
                                                                    .read(img1Provider
                                                                        .notifier)
                                                                    .state = await img1;
                                                              } else {
                                                                if (context
                                                                    .mounted) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("No image is selected")));
                                                                }
                                                              }
                                                            } catch (e) {
                                                              Text(
                                                                  e.toString());
                                                            }
                                                          },
                                                          child: Container(
                                                              height: 100,
                                                              width: 100,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: ref.watch(
                                                                          img1Provider) ==
                                                                      null
                                                                  ? Image.network(
                                                                      datas.img[
                                                                          0])
                                                                  : Image
                                                                      .memory(
                                                                      ref.watch(
                                                                          img1Provider)!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          'Add image (2)',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            try {
                                                              final pickedImage2 =
                                                                  await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);
                                                              if (pickedImage2 !=
                                                                  null) {
                                                                var img2 =
                                                                    pickedImage2
                                                                        .readAsBytes();

                                                                ref
                                                                    .read(img2Provider
                                                                        .notifier)
                                                                    .state = await img2;
                                                              } else {
                                                                if (context
                                                                    .mounted) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("No image is selected")));
                                                                }
                                                              }
                                                            } catch (e) {
                                                              Text(
                                                                  e.toString());
                                                            }
                                                          },
                                                          child: Container(
                                                              height: 100,
                                                              width: 100,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: ref.watch(
                                                                          img2Provider) ==
                                                                      null
                                                                  ? Image.network(
                                                                      datas.img[
                                                                          1])
                                                                  : Image
                                                                      .memory(
                                                                      ref.watch(
                                                                          img2Provider)!,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                    )),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 15,
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(20)),
                                                    child: Column(
                                                      children: [
                                                        const Text(
                                                          'Add image (3)',
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        InkWell(
                                                          onTap: () async {
                                                            try {
                                                              final pickedImage3 =
                                                                  await ImagePicker()
                                                                      .pickImage(
                                                                          source:
                                                                              ImageSource.gallery);

                                                              if (pickedImage3 !=
                                                                  null) {
                                                                var img3 =
                                                                    pickedImage3
                                                                        .readAsBytes();

                                                                ref
                                                                    .read(img3Provider
                                                                        .notifier)
                                                                    .state = await img3;
                                                              } else {
                                                                if (context
                                                                    .mounted) {
                                                                  ScaffoldMessenger.of(
                                                                          context)
                                                                      .showSnackBar(const SnackBar(
                                                                          content:
                                                                              Text("No image is selected")));
                                                                }
                                                              }
                                                            } catch (e) {
                                                              Text(
                                                                  e.toString());
                                                            }
                                                          },
                                                          child: Container(
                                                              height: 100,
                                                              width: 100,
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: ref.watch(
                                                                          img3Provider) ==
                                                                      null
                                                                  ? Image.network(
                                                                      datas.img[
                                                                          2])
                                                                  : Image
                                                                      .memory(
                                                                      ref.watch(
                                                                          img3Provider)!,
                                                                      fit: BoxFit
                                                                          .cover,
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
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller: mrpController,
                                                hinttext: "MRP",
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller:
                                                    offerPriceController,
                                                hinttext: "Offer Price",
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                child: DropdownButtonFormField(
                                                  decoration: const InputDecoration(
                                                      border:
                                                          OutlineInputBorder()),
                                                  isExpanded: true,
                                                  value: ref
                                                      .watch(roomTypeProvider),
                                                  hint: const Text("Room Type"),
                                                  icon: const Icon(Icons
                                                      .keyboard_arrow_down),
                                                  items: roomTypeList
                                                      .map((String items) {
                                                    return DropdownMenuItem(
                                                      value: items,
                                                      child: Text(items),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (String? newValue) {
                                                    ref
                                                        .read(roomTypeProvider
                                                            .notifier)
                                                        .state = newValue;
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 13,
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller: warrantyController,
                                                hinttext: "Warranty",
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller: weightController,
                                                hinttext: "Weight",
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller: brandController,
                                                hinttext: "Brand",
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller:
                                                    primaryMaterialController,
                                                hinttext: "Primary_material",
                                              ),
                                              CustomTextField(
                                                width:
                                                    MediaQuery.sizeOf(context)
                                                            .width *
                                                        0.3,
                                                controller: colorController,
                                                hinttext: "Color",
                                              ),
                                            ],
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text(
                                                "Cancel",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              )),
                                          TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "Update",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18),
                                              ))
                                        ],
                                      );
                                    });
                              },
                              icon: const Icon(Icons.edit),
                              label: const Text("Edit")),
                          TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text("Are you sure?"),
                                      content: const Text(
                                          "Do you want to delete this product?"),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("No")),
                                        TextButton(
                                            onPressed: () {
                                              FirestoreService()
                                                  .deleteProducts(
                                                      data.docs[index].id)
                                                  .then((value) =>
                                                      Navigator.pop(context));
                                            },
                                            child: const Text("Yes"))
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 6,
                      ),
                  itemCount: data.docs.length);
            },
            error: (error, stackTrace) => Center(child: Text(error.toString())),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
    );
  }
}
