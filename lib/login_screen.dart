import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
        color: Theme.of(context).backgroundColor,
        child: Column(
          children: [
            Text(
              'Hello',
              style: textTheme.headline4!.copyWith(color: Colors.white),
            ),
            Text(
              'Login to check-in your course',
              style: textTheme.headline6!.copyWith(color: Colors.white),
            ),
            Image(image: AssetImage('assets/image/Illustration_1.png'))
          ],
        ));
  }
}
