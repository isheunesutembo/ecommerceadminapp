import 'package:ecommerceadmin/controllers/authcontroller.dart';
import 'package:ecommerceadmin/ui/registerpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LogInPage extends ConsumerStatefulWidget {
  LogInPage({super.key});

  @override
  ConsumerState<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends ConsumerState<LogInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    signInWithEmailAndPassword(context, ref, String? email, String? password) {
      ref
          .read(authControllerProvider.notifier)
          .signInWithEmailAndPassword(context, email, password);
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
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
                backgroundColor: Colors.white,
                radius: 50,
                child: Image.asset("assets/icons/pharmacy.png")),
            const SizedBox(
              height: 32,
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
              height: 32,
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
                  hintText: "enter password",
                  prefixIcon: const Icon(
                    Icons.password_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  alignLabelWithHint: true,
                ),
                validator: ((value) {
                  if (value!.isEmpty) {
                    "password is not empty";
                  }
                  return null;
                }),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: 350,
                child: ElevatedButton(
                  onPressed: () {
                    signInWithEmailAndPassword(context, ref,
                        _emailController.text, _passwordController.text);
                  },
                  child: const Text("SignIn"),
                ),
              ),
            ),
            const SizedBox(
              height: 32,
            ),
            Center(
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                    child: const Text(
                      "No account ? Register",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )))
          ],
        ),
      ))),
    );
  }
}
