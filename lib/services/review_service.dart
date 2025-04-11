import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/review.dart';

class ReviewService {
  /// Fetches all reviews from Firestore and converts them to Review objects
  static Future<List<Review>> fetchAllReviews() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('reviews').get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Review.fromFirestore(data);
      }).toList();
    } catch (e) {
      print("Error fetching reviews: $e");
      return [];
    }
  }
}
