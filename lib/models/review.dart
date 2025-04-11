
class Review {
  final String title;             // Name of the meal
  final int stars;                // Rating from 1 to 5
  final String ratingText;        // Formatted rating display string
  final String reviewText;        // Review content
  final List<String> tags;        // List of tags like ["Filling"]
  final bool hasMoreButton;       // Optional UI control
  final String userId;           // UID of the reviewer
  final String? imageUrl;         // Optional image URL


  Review({
    required this.title,
    required this.stars,
    required this.ratingText,
    required this.reviewText,
    required this.tags,
    required this.userId,
    this.hasMoreButton = false,
    this.imageUrl,
  });

  /// Convert Firestore data map to a Review object
  factory Review.fromFirestore(Map<String, dynamic> map) {
    final double rawRating = (map['rating'] ?? 0).toDouble();

    return Review(
      title: map['meal'] ?? 'Untitled',
      stars: rawRating.round(),
      ratingText: '(${rawRating.toStringAsFixed(1)} of 5 Stars)',
      reviewText: map['reviewText'] ?? '',
      tags: List<String>.from(map['tags'] ?? []),
      imageUrl: map['imageUrl'],
      userId: map['userId'],
      hasMoreButton: false,
    );
  }
}
