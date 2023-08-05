import 'dart:io';

import 'package:ecommerceadmin/controllers/productcontroller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
List<String> categoriesList = <String>[
  'surgicalinstruments',
  'coughsyrup',
  'malariapills',
  'masks',
  'painkillers',
  'arvs',
  'sanitarypads',
  'other'
];

class AddProductPage extends ConsumerStatefulWidget {
  const AddProductPage({super.key});

  @override
  ConsumerState<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends ConsumerState<AddProductPage> {
  File? image;
  
  
  late String categoryname;
  final name=TextEditingController();
  final price=TextEditingController();
  final oldPrice=TextEditingController();
  final description=TextEditingController();
  
  
  final GlobalKey _formKey = GlobalKey<FormState>();

  String dropDownValue = categoriesList.first;

  @override
   @override
  void dispose() {
    
    super.dispose();
    name.dispose();
    price.dispose();
    oldPrice.dispose();
    description.dispose();
  }
  Future pickImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 20);
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
    final addProducts = ref.read(productsControllerProvider.notifier);
   

    return Scaffold(
      appBar: AppBar(
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
                              : Image.asset(
                                  "assets/icons/image.png",
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
                      keyboardType: TextInputType.visiblePassword,
                      onChanged: (value) {
                        name.text = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
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
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 350,
                      height: 50,
                      child: DropdownButton<String>(
                        value: dropDownValue,
                        icon: const Icon(Icons.arrow_downward_rounded),
                        elevation: 16,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                        underline: Container(
                          height: 2,
                          color: Colors.black,
                        ),
                        onChanged: (String? value) {
                          // This is called when the user selects an item.
                          setState(() {
                            dropDownValue = value!;
                          });
                        },
                        items: categoriesList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: TextFormField(
                        enableSuggestions: true,
                        keyboardType: TextInputType.visiblePassword,
                        onChanged: (value) {
                          description.text = value;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          hintText: "product description",
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 80, horizontal: 5),
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
                  ),
                 const Padding(
                    padding: const EdgeInsets.all(16.0),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      enableSuggestions: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        oldPrice.text = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        hintText: "old price",
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
                      enableSuggestions: true,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        price.text = value;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2),
                        ),
                        hintText: "new price",
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
                 
                 
                  SizedBox(
                    width: 200,
                    height: 50,
                    child: ElevatedButton(
                        onPressed: () {
                          addProducts.createProduct(
                              context,
                              image,
                              name.text,
                              description.text,
                             double.parse( price.text),
                             double.parse( oldPrice.text),
                              dropDownValue.toString(),
                              
                            
                             
                              
                              );

                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Upload Product",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ))),
    );
  }
}