import 'package:bookhive/models/user_model.dart';
import 'package:bookhive/utils/toast_util.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Register a new user
  Future<void> registerUser(UserModel user, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      // Add user details to Firestore
      await _firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toMap());
    } catch (e) {
      throw Exception("Error registering user: $e");
    }
  }

  // Login user
  Future<User?> loginUser(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception("Error logging in user: $e");
    }
  }

  // Fetch current user data
  Future<UserModel?> fetchCurrentUser() async {
    try {
      final User? user = _auth.currentUser;
      if (user != null) {
        final DocumentSnapshot doc =
            await _firestore.collection('users').doc(user.uid).get();
        if (doc.exists) {
          return UserModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
        }
      }
    } catch (e) {
      throw Exception("Error fetching current user data: $e");
    }
    return null;
  }
}
