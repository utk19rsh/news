import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news/components/backend/functions.dart';
import 'package:news/components/backend/showEmailProvider.dart';
import 'package:news/constants.dart';
import 'package:news/screens/home/home.dart';
import 'package:news/screens/preLogin/signIn.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      const Duration(seconds: 2),
      () => pushReplacement(
        context,
        FirebaseAuth.instance.currentUser == null
            ? const Signin()
            : ChangeNotifierProvider(
                create: (context) => ShowEmail(),
                child: const Home(),
              ),
      ),
    );
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: AspectRatio(
            aspectRatio: 1,
            child: Image.asset("assets/gifs/loader.gif"),
          ),
        ),
      ),
    );
  }
}
