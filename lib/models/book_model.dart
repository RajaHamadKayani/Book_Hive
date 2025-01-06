class Book {
  String id;
  String title;
  String author;
  String genre;
  String description;
  DateTime createdAt;
  List<String> likes; // List of user IDs who liked the book
  List<String> dislikes; // List of user IDs who disliked the book
  List<Map<String, dynamic>> ratings; // List of ratings

  Book(
      {required this.id,
      required this.title,
      required this.description,
      required this.author,
      required this.genre,
      required this.createdAt,
      this.likes = const [], // Initialize as an empty list
      this.dislikes = const [], // Initialize as an empty list
      this.ratings = const []});

  // Convert Book object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'genre': genre,
      'createdAt': createdAt.toIso8601String(),
      'likes': likes, // Include likes
      'dislikes': dislikes, // Include dislikes
      'ratings': ratings, // Add ratings to Firestore
    };
  }

  // Create a Book object from Firestore Map
  factory Book.fromMap(Map<String, dynamic> map, String documentId) {
    return Book(
      id: documentId,
      title: map['title'] ?? '',
      author: map['author'] ?? '',
      description: map['description'] ?? '',
      genre: map['genre'] ?? '',
      createdAt:
          DateTime.parse(map['createdAt'] ?? DateTime.now().toIso8601String()),
      likes: List<String>.from(
          map['likes'] ?? []), // Convert Firestore array to List
      dislikes: List<String>.from(
          map['dislikes'] ?? []), // Convert Firestore array to List
      ratings: List<Map<String, dynamic>>.from(
          map['ratings'] ?? []), // Parse ratings
    );
  }
}
