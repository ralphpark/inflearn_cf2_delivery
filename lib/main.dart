
import 'package:flutter/material.dart';
import 'package:inflearn_cf2_actual/common/component/custom_text_form_field.dart';
import 'package:inflearn_cf2_actual/common/view/splash_screen.dart';
import 'package:inflearn_cf2_actual/user/view/login_screen.dart';

void main() {
  runApp(_App());
}

class _App extends StatelessWidget {
  const _App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'NotoSansKR',
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
