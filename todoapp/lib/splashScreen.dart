import 'dart:async';

import 'package:flutter/material.dart';
import 'package:todoapp/TodoUi.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const TodoWidget(
                    title: 'Todo App',
                  )));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset(
              'assets/images/TodoLogo.png',
              height: 250,
            ),
            const SizedBox(
              height: 200,
            ),
            const Text('From'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/images/rohan.jpg'),
                ),
                const SizedBox(
                  width: 7,
                ),
                Text(
                  'Rohan Shrestha',
                  style: TextStyle(fontSize: 24, color: Colors.grey.shade700),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
