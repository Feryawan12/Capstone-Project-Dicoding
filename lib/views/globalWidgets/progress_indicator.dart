import 'package:flutter/material.dart';

class ProgressDefaultIndicator extends StatefulWidget {
  const ProgressDefaultIndicator({super.key});

  @override
  State<ProgressDefaultIndicator> createState() =>
      _ProgressDefaultIndicatorState();
}

class _ProgressDefaultIndicatorState extends State<ProgressDefaultIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary, value: 30),
    );
  }
}
