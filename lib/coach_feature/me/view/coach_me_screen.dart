import 'package:flutter/material.dart';

class CoachMeScreen extends StatelessWidget {
  const CoachMeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _Scaffold();
  }
}

class _Scaffold extends StatelessWidget {
  const _Scaffold({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Text("me"),));
  }
}
