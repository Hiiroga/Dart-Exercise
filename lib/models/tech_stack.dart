import 'package:flutter/material.dart';

class TechStack {
  final String title;
  final String platform;
  final String lang;
  final Color color;

  const TechStack({
    required this.title,
    required this.platform,
    required this.lang,
    required this.color,
  });

  factory TechStack.fromJson(Map<String, dynamic> json) {
    return TechStack(
      title: json['title'] ?? '',
      platform: json['platform'] ?? '',
      lang: json['lang'] ?? '',
      color: json['color'] ?? Colors.blue,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'platform': platform,
      'lang': lang,
      'color': color.toString(),
    };
  }
}
