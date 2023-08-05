import 'dart:io';

import 'package:ecommerceadmin/controllers/authcontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _storeName = TextEditingController();
  final _storeAdress = TextEditingController();
  final _phoneNumber = TextEditingController();
  File? image;
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _storeName.dispose();
    _storeAdress.dispose();
    _phoneNumber.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    signUpWithEmailAndPassword(context, ref, email, name, address, phonenumber,
        password, File? image) {
      ref.read(authControllerProvider.notifier).signUpWithEmailAndPassword(
          context,  email, name, address, phonenumber, password, image);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Form(
            child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Center(
              child: GestureDetector(
                onTap: () {
                  pickImage();
                },
                child: image != null
                    ? Image.file(
                        image!,
                        height: 100,
                        width: 100,
                      )
                    : Image.asset(
                        "assets/icons/image.png",
                        height: 100,
                        width: 100,
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enableSuggestions: true,
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.solid),
                  ),
                  hintText: "email:example@48.com",
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.black,
                    size: 20,
                  ),
                  alignLabelWithHint: true,
                ),
                validator: ((value) {
                  if (value!.isEmpty || !value.contains("@")) {
                    "enter a valid email";
                  }
                  return null;
                }),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enableSuggestions: true,
                keyboardType: TextInputType.text,
                controller: _storeName,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.solid),
                  ),
                  hintText: "shop name",
                  prefixIcon: const Icon(
                    Icons.store,
                    color: Colors.black,
                    size: 20,
                  ),
                  alignLabelWithHint: true,
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    "store name cannot be empty";
                  }
                  return null;
                }),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enableSuggestions: true,
                keyboardType: TextInputType.streetAddress,
                controller: _storeAdress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.solid),
                  ),
                  hintText: "shop address",
                  prefixIcon: const Icon(
                    Icons.location_history,
                    color: Colors.black,
                    size: 20,
                  ),
                  alignLabelWithHint: true,
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    "store address cannot be empty";
                  }
                  return null;
                }),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enableSuggestions: true,
                keyboardType: TextInputType.phone,
                controller: _phoneNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.solid),
                  ),
                  hintText: "phone number",
                  prefixIcon: const Icon(
                    Icons.phone,
                    color: Colors.black,
                    size: 20,
                  ),
                  alignLabelWithHint: true,
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    "phone cannot be empty";
                  }
                  return null;
                }),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                enableSuggestions: true,
                keyboardType: TextInputType.visiblePassword,
                controller: _passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(width: 0, style: BorderStyle.solid),
                  ),
                  hintText: "password",
                  prefixIcon: const Icon(
                    Icons.password,
                    color: Colors.black,
                    size: 20,
                  ),
                  alignLabelWithHint: true,
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    "password cannot be empty";
                  }
                  return null;
                }),
              ),
            ),
            SizedBox(
                width: 350,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    signUpWithEmailAndPassword(
                        context,
                        ref,
                        _emailController.text,
                        _storeName.text,
                        _storeAdress.text,
                        _phoneNumber.text,
                        _passwordController.text,
                        image);
                  },
                  child: Text("Register"),
                ))
          ],
        )),
      )),
    );
  }
}
