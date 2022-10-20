import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sellthedwell/utils/strings.dart';

class InvalidScreen extends StatefulWidget {
  const InvalidScreen({Key? key}) : super(key: key);

  @override
  State<InvalidScreen> createState() => _InvalidScreenState();
}

class _InvalidScreenState extends State<InvalidScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(Strings.invalidRoute),
      ),
    );
  }
}
