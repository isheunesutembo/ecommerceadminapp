import 'dart:io';

import 'package:ecommerceadmin/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import 'package:ecommerceadmin/controllers/productcontroller.dart';
class EditProductPage extends ConsumerStatefulWidget {
  EditProductPage({super.key});

  @override
  ConsumerState<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends ConsumerState<EditProductPage> {
  File? image;
 
  final nameController=TextEditingController();
  final descriptionController=TextEditingController();
  final priceController=TextEditingController();
  final oldPriceController=TextEditingController();


@override
  void dispose() {
   
    super.dispose();
    nameController.dispose();
    descriptionController.dispose();
    oldPriceController.dispose();
    priceController.dispose();
  }
  final GlobalKey _formKey = GlobalKey<FormState>();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      throw 'Failed to pick image';
    }
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)!.settings.arguments as Product;
    final editProducts = ref.read(productsControllerProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          title:const Center(child: Text("Update Product",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: Theme.of(context).iconTheme,),
        body: SingleChildScrollView(
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: image != null
                                ? Image.file(
                              image!,
                              height: 150,
                              width: 150,
                            )
                                : Image.network(
                              "${product.image}",
                              height: 150,
                              width: 150,
                            ),
                          ),
                        ),
                        const Text(
                          "Pick Product Image",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        enableSuggestions: true,
                        initialValue: product.name,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          nameController.text = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "product name",
                          hintStyle: const TextStyle(color: Colors.black),
                          alignLabelWithHint: true,
                        ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "product name cannot be empty";
                          }
                          return null;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: SizedBox(
                        child: TextFormField(
                          enableSuggestions: true,
                          initialValue: product.description,
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            descriptionController.text = value;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 70, horizontal: 5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "product description",
                            hintStyle: const TextStyle(color: Colors.black),
                            alignLabelWithHint: true,
                          ),
                          maxLines: null,
                          validator: ((value) {
                            if (value!.isEmpty) {
                              return "product name cannot be empty";
                            }
                            return null;
                          }),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: product.price.toString(),
                        enableSuggestions: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          priceController.text = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: " price",
                          hintStyle: const TextStyle(color: Colors.black),
                          alignLabelWithHint: true,
                        ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "product price cannot be empty";
                          }
                          return null;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: TextFormField(
                        initialValue: product.oldPrice.toString(),
                        enableSuggestions: true,
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          oldPriceController.text = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "old price",
                          hintStyle: const TextStyle(color: Colors.black),
                          alignLabelWithHint: true,
                        ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return "price cannot be empty";
                          }
                          return null;
                        }),
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () {
                            editProducts.updateProduct(
                                context,
                                image,
                                nameController.text,
                                descriptionController.text,
                                double.parse(priceController.text),
                                double.parse(oldPriceController.text));
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Update Product",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          )),
                    )
                  ],
                ))));
  }
}
