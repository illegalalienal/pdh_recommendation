import 'package:flutter/material.dart';
import 'review_item.dart';
import '../models/review.dart';
import '../services/review_service.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      // Load reviews using the service layer
      future: ReviewService.fetchAllReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Text('No reviews available.');
        }

        final reviews = snapshot.data!;
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "This week's reviews:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                SizedBox(height: 8.0),

                // Render each review as a ReviewItem
                for (int i = 0; i < 3; i++) ...[
                  ReviewItem(
                    title: reviews[i].title,
                    stars: reviews[i].stars,
                    ratingText: reviews[i].ratingText,
                    reviewText: reviews[i].reviewText,
                    hasMoreButton: reviews[i].hasMoreButton,
                  ),
                  if (i != reviews.length - 1) Divider(),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
