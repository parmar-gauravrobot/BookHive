import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();
  User? _user;
  String? _error;
  bool _loading = false;

  AuthProvider() {
    _service.authStateChanges().listen((u) {
      _user = u;
      notifyListeners();
    });
  }

  User? get user => _user;
  String? get error => _error;
  bool get loading => _loading;

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    try {
      await _service.signIn(email, password);
      _error = null;
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> signUp(String email, String password) async {
    _setLoading(true);
    try {
      await _service.signUp(email, password);
      _error = null;
      return true;
    } on FirebaseAuthException catch (e) {
      _error = e.message;
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<void> signOut() => _service.signOut();

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }
}


