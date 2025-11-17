class SearchFilters {
  const SearchFilters({
    this.maxPrice = 600,
    this.minRating = 1,
    this.maxDistance = 25,
    this.types = const [],
  });

  final double maxPrice;
  final double minRating;
  final double maxDistance;
  final List<String> types;

  SearchFilters copyWith({
    double? maxPrice,
    double? minRating,
    double? maxDistance,
    List<String>? types,
  }) {
    return SearchFilters(
      maxPrice: maxPrice ?? this.maxPrice,
      minRating: minRating ?? this.minRating,
      maxDistance: maxDistance ?? this.maxDistance,
      types: types ?? this.types,
    );
  }
}
