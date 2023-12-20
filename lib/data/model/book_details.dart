// To parse this JSON data, do
//
//     final bookDetails = bookDetailsFromJson(jsonString);

import 'dart:convert';

BookDetails bookDetailsFromJson(String str) => BookDetails.fromJson(json.decode(str));

String bookDetailsToJson(BookDetails data) => json.encode(data.toJson());

class BookDetails {
    List<Review> reviews;
    List<Like> likes;
    List<View> views;
    List<Rating> ratings;

    BookDetails({
        required this.reviews,
        required this.likes,
        required this.views,
        required this.ratings,
    });

    factory BookDetails.fromJson(Map<String, dynamic> json) => BookDetails(
        reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        likes: List<Like>.from(json["likes"].map((x) => Like.fromJson(x))),
        views: List<View>.from(json["views"].map((x) => View.fromJson(x))),
        ratings: List<Rating>.from(json["ratings"].map((x) => Rating.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
        "views": List<dynamic>.from(views.map((x) => x.toJson())),
        "ratings": List<dynamic>.from(ratings.map((x) => x.toJson())),
    };
}

class Like {
    int bookId;
    String user;
    int likesCount;

    Like({
        required this.bookId,
        required this.user,
        required this.likesCount,
    });

    factory Like.fromJson(Map<String, dynamic> json) => Like(
        bookId: json["book_id"],
        user: json["user"],
        likesCount: json["likes_count"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "user": user,
        "likes_count": likesCount,
    };
}

class Rating {
    int bookId;
    String user;
    int rating;

    Rating({
        required this.bookId,
        required this.user,
        required this.rating,
    });

    factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        bookId: json["book_id"],
        user: json["user"],
        rating: json["rating"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "user": user,
        "rating": rating,
    };
}

class Review {
    int bookId;
    String user;
    String review;

    Review({
        required this.bookId,
        required this.user,
        required this.review,
    });

    factory Review.fromJson(Map<String, dynamic> json) => Review(
        bookId: json["book_id"],
        user: json["user"],
        review: json["review"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "user": user,
        "review": review,
    };
}

class View {
    int bookId;
    String user;

    View({
        required this.bookId,
        required this.user,
    });

    factory View.fromJson(Map<String, dynamic> json) => View(
        bookId: json["book_id"],
        user: json["user"],
    );

    Map<String, dynamic> toJson() => {
        "book_id": bookId,
        "user": user,
    };
}
