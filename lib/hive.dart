import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class hive extends StatefulWidget {
  const hive({super.key});

  @override
  State<hive> createState() => _hiveState();
}

class _hiveState extends State<hive> {
  final myBox = Hive.box("myBox");
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Hive.openBox("myBox");
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}