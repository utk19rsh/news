import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:news/components/backend/functions.dart';
import 'package:news/components/backend/showEmailProvider.dart';
import 'package:news/constants.dart';
import 'package:news/screens/preLogin/signIn.dart';
import 'package:provider/provider.dart';

class PostTile extends StatelessWidget {
  const PostTile({
    Key? key,
    required this.name,
    required this.email,
    required this.body,
  }) : super(key: key);

  final String name;
  final String email;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: backgroundColor,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              name.characters.first.toUpperCase(),
              style: const TextStyle(
                color: black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name : ",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: grey.shade400,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: black,
                          fontSize: 15,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email : ",
                      style: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: grey.shade400,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: Consumer<ShowEmail>(builder: (context, value, _) {
                        return Text(
                          value.showEmail ? email : hideEmail(email),
                          style: const TextStyle(
                            color: black,
                            fontSize: 15,
                            letterSpacing: 0.5,
                            fontWeight: FontWeight.w600,
                          ),
                        );
                      }),
                    ),
                  ],
                ),
                const SizedBox(height: 7.5),
                Text(
                  body,
                  style: const TextStyle(
                    color: black,
                    fontSize: 15,
                    letterSpacing: 0.5,
                  ),
                ),
                // RichText(
                //   text: TextSpan(
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: "Name : ",
                //         style: TextStyle(
                //           fontStyle: FontStyle.italic,
                //           color: grey.shade300,
                //           letterSpacing: 0.5,
                //           fontWeight: FontWeight.w300,
                //         ),
                //       ),
                //       TextSpan(
                //         text: name,
                //         style: const TextStyle(
                //           color: black,
                //           fontSize: 16,
                //           letterSpacing: 0.5,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // RichText(
                //   text: TextSpan(
                //     children: <TextSpan>[
                //       TextSpan(
                //         text: "Email : ",
                //         style: TextStyle(
                //           fontStyle: FontStyle.italic,
                //           color: grey.shade300,
                //           letterSpacing: 0.5,
                //           fontWeight: FontWeight.w300,
                //         ),
                //       ),
                //       TextSpan(
                //         text: email,
                //         style: const TextStyle(
                //           color: black,
                //           fontSize: 16,
                //           letterSpacing: 0.5,
                //           fontWeight: FontWeight.w600,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class SignoutIcon extends StatelessWidget {
  const SignoutIcon({
    Key? key,
    required this.mounted,
  }) : super(key: key);

  final bool mounted;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        if (mounted) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (builder) => const Signin()),
            (route) => false,
          );
        }
      },
      icon: const Icon(
        MdiIcons.logout,
      ),
    );
  }
}
