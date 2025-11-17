import 'package:flutter/material.dart';

/// Model describing a hotel entry in the catalog.
class Hotel {
  const Hotel({
    required this.id,
    required this.name,
    required this.city,
    required this.price,
    required this.rating,
    required this.distance,
    required this.tags,
    required this.type,
    required this.image,
    required this.description,
    required this.amenities,
    required this.reviews,
  });

  final String id;
  final String name;
  final String city;
  final double price;
  final double rating;
  final double distance;
  final List<String> tags;
  final String type;
  final String image;
  final String description;
  final List<String> amenities;
  final int reviews;

  Color dynamicTagColor(Color primary) => primary.withOpacity(0.12);
}
