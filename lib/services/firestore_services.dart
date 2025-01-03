import 'package:bookhive/models/book_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class BookService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a new book to Firestore
  Future<void> addBook(Book book) async {
    try {
      await _firestore.collection('books').doc(book.id).set(book.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Fetch all books from Firestore
  Future<List<Book>> fetchBooks() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('books').get();
      return snapshot.docs.map((doc) => Book.fromMap(doc.data() as Map<String, dynamic>, doc.id)).toList();
    } catch (e) {
      rethrow;
    }
  }

  // Update an existing book in Firestore
  Future<void> updateBook(Book book) async {
    try {
      await _firestore.collection('books').doc(book.id).update(book.toMap());
    } catch (e) {
      rethrow;
    }
  }

  // Delete a book from Firestore
  Future<void> deleteBook(String bookId) async {
    try {
      await _firestore.collection('books').doc(bookId).delete();
    } catch (e) {
      rethrow;
    }
  }
}
