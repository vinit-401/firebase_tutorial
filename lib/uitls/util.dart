import 'package:flutter/material.dart';

InputDecoration decoration(String label) {
  return InputDecoration(
    hintText: label,
    focusColor: Colors.green,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(width: 2,color: Colors.green),
      borderRadius: BorderRadius.circular(12),
    ),
  );
}

LinearGradient greenGradient =  LinearGradient(begin: Alignment.topRight,end: Alignment.bottomLeft,colors: [

  Colors.white70,
  Colors.green.shade50,
  Colors.green.shade50,
  Colors.green.shade50,
  Colors.green.shade50,
  Colors.green.shade50,
  Colors.green.shade100,
  Colors.green.shade200,
  Colors.green.shade300,
]);