import 'package:flutter/material.dart';
import '../../home/widgets/search_widget.dart';

class BottomWidget extends StatefulWidget {
  const BottomWidget({super.key});

  @override
  State<BottomWidget> createState() => _BottomWidgetState();
}

class _BottomWidgetState extends State<BottomWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Material(
            elevation: 6,
            borderRadius: const BorderRadius.all(Radius.circular(20.0)),
            color: Theme.of(context).primaryColor,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.10,
                maxWidth: MediaQuery.of(context).size.width * 0.95,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    SearchWidget(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
