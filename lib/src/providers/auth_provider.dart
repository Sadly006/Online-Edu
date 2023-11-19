import 'package:flutter/material.dart';
import 'package:online_edu/src/services/auth_service.dart';
import '../models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future signInWithEmailAndPassword(String email, String password) async {
    final user = await _authService.signInWithEmailAndPassword(email, password);
    if (user != null) {
      _user = User(uid: user.uid, email: user.email!);
      notifyListeners();
      return 1;
    }
    else{
      return 0;
    }
  }
}