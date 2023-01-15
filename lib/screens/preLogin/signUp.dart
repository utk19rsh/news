import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:news/components/backend/functions.dart';
import 'package:news/components/backend/showEmailProvider.dart';
import 'package:news/components/frontend/snackbar.dart';
import 'package:news/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/screens/home/home.dart';
import 'package:news/screens/preLogin/components.dart';
import 'package:news/screens/preLogin/signIn.dart';
import 'package:provider/provider.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController email = TextEditingController(),
      password = TextEditingController(),
      name = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void dispose() {
    email.dispose();
    name.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox.shrink(),
            Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    name,
                    hint: " Name",
                    keyboardType: TextInputType.name,
                    validator: (value) => value != null && value.length > 1
                        ? null
                        : "Password must have at least 2 characters",
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    email,
                    hint: " Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => validateEmail(value),
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormField(
                    password,
                    hint: " Password",
                    validator: (value) => value != null && value.length >= 7
                        ? null
                        : "Password must have at least 6 characters",
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            Column(
              children: [
                signupButton(context),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      const TextSpan(
                        text: "New here?",
                        style: TextStyle(
                          color: black,
                          fontSize: 15,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TextSpan(
                        text: " Signin",
                        style: const TextStyle(
                          color: theme,
                          fontSize: 15,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => push(context, const Signin()),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
              ],
            )
          ],
        ),
      ),
    );
  }

  GestureDetector signupButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (formKey.currentState!.validate()) {
          setState(() => isLoading = true);
          try {
            final UserCredential user =
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
              email: email.text,
              password: password.text,
            );
            if (user.user == null) {
              if (mounted) {
                buildSnackBar(
                  context,
                  "Something went wrong",
                );
              }
            } else {
              await FirebaseFirestore.instance
                  .collection("AllUsers")
                  .doc(email.text)
                  .set({
                "createdAt": DateTime.now(),
                "email": email.text,
                "name": name.text,
                "password": password.text,
              });

              if (mounted) {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => ChangeNotifierProvider(
                      create: (context) => ShowEmail(),
                      child: const Home(),
                    ),
                  ),
                  (route) => false,
                );
              }
            }
          } catch (e) {
            if (e.toString().contains(
                "The email address is already in use by another account")) {
              buildSnackBar(context, "User already exists.");
            }
            debugPrint(e.toString());
          }
          setState(() => isLoading = false);
        }
      },
      child: Container(
        width: double.infinity,
        height: 55,
        margin: const EdgeInsets.symmetric(
          horizontal: 45,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: theme,
          borderRadius: BorderRadius.circular(12.5),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(
                  color: white,
                ),
              )
            : const Text(
                "Signup",
                style: TextStyle(
                  color: white,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  fontSize: 18,
                ),
              ),
      ),
    );
  }
}
