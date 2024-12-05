import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/pages/onboarding.dart';
import 'package:flutternews/user/widgets/chart_page.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    title: const Text('Nyanco', style: TextStyle(color: Colors.white)),
    automaticallyImplyLeading: false,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        color: Color(0xFF4A1E9E),
      ),
    ),
    actions: [
      IconButton(
        icon: const Icon(Icons.shopping_cart, color: Colors.white),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartPage()));
        },
      ),
      IconButton(
        icon: const Icon(Icons.logout, color: Colors.white),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const Onboarding()),
            (route) => false,
          );
        },
      ),
    ],
  );
}
