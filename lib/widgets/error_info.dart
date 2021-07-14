import 'package:flutter/material.dart';

class ErrorInfo extends StatelessWidget {
  ErrorInfo({required this.info});

  final info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Center(
        child: Text(
          info,
          style: TextStyle(
            color: Colors.red.shade500,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
