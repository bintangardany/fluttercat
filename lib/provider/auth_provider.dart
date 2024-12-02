import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Authentication state
  User? get currentUser => _auth.currentUser;
  bool get isAuthenticated => currentUser != null;

  // Loading state
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // User role
  String _userRole = 'user'; // Default to user
  String get userRole => _userRole;

  // Sign-in method
  Future<void> signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    _setLoading(true);
    try {
      final trimmedEmail = email.trim().toLowerCase();

      if (!_isEmailValid(trimmedEmail) || password.isEmpty) {
        _showSnackBar(context, 'Please enter a valid email and password');
        return;
      }

      final UserCredential userCredential =
          await _auth.signInWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );

      await _fetchUserRole(userCredential.user!.uid);
      _showSnackBar(context, 'Welcome ${userCredential.user!.email}!');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        _showSnackBar(context, 'Invalid Email or Password');
      } else {
        _showSnackBar(context, 'Error: ${e.message}');
      }
    } finally {
      _setLoading(false);
    }
  }

  // Sign-up method
  Future<void> signUp({
    required String email,
    required String password,
    required String role,
    required BuildContext context,
  }) async {
    _setLoading(true);
    try {
      final trimmedEmail = email.trim();

      if (!_isEmailValid(trimmedEmail) || password.isEmpty) {
        _showSnackBar(context, 'Please enter a valid email and password');
        return;
      }

      if (password.length < 6) {
        _showSnackBar(context, 'Password must be at least 6 characters');
        return;
      }

      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: trimmedEmail,
        password: password,
      );

      // Save user role in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'email': trimmedEmail,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });

      _showSnackBar(context, 'Account created successfully!');
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        _showSnackBar(context, 'Email is already in use');
      } else {
        _showSnackBar(context, 'Error: ${e.message}');
      }
    } finally {
      _setLoading(false);
    }
  }

  // Fetch user role from Firestore
  Future<void> _fetchUserRole(String userId) async {
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(userId).get();

    if (userDoc.exists) {
      _userRole = userDoc['role'] ?? 'user';
    }
  }

  // Sign out method
  Future<void> signOut(BuildContext context) async {
    _setLoading(true);
    try {
      await _auth.signOut();
      _showSnackBar(context, 'Signed out successfully');
      notifyListeners();
    } finally {
      _setLoading(false);
    }
  }

  // Utility method to show SnackBar
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Utility method to validate email
  bool _isEmailValid(String email) {
    final emailRegex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$");
    return emailRegex.hasMatch(email);
  }

  // Update loading state
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
