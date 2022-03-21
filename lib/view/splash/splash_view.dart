import 'package:agriverts/core/constants/text_constants.dart';
import 'package:agriverts/product/init/init_app.dart';
import 'package:agriverts/product/navigation/route.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  late Size size;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(milliseconds: 1500),
      () {
        initializeApp();
        checkAuthAndReplace();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Image.asset(
          TextConstants.splashAssetPath,
          fit: BoxFit.contain,
          width: size.width / 1.5,
          height: size.width / 1.5,
        ),
      ),
    );
  }

  void checkAuthAndReplace() {
    if (_firebaseAuth.currentUser != null) {
      context.router.replace(HomeView());
    } else {
      context.router.replace(AuthView());
    }
  }
}
