import 'package:flutter/material.dart';

class Hotel {
  Hotel({
    required this.id,
    required this.name,
    required this.city,
    required this.price,
    required this.rating,
    required this.distanceKm,
    required this.tags,
    required this.image,
    this.description = '',
    this.amenities = const [],
  });

  final String id;
  final String name;
  final String city;
  final double price;
  final double rating;
  final double distanceKm;
  final List<String> tags;
  final String image;
  final String description;
  final List<String> amenities;

  Color heroColor(Color primary) => primary.withOpacity(0.15);
}
