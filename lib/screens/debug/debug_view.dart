import 'package:flutter/material.dart';
import 'package:in_porto/screens/debug/widgets/parse_data_widget.dart';

class DebugView extends StatelessWidget {
  const DebugView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Debug'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: const Column(
        children: [
          ParseDataWidget(),
        ],
      ),
    );
  }
}