import 'package:flutter/material.dart';

class CustomError {

  bool error;
  Map<String, dynamic> errorMaps;

  CustomError({
    @required this.error,
    @required this.errorMaps,
  });

  CustomError.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    errorMaps = json['errorMaps'];
  }
}