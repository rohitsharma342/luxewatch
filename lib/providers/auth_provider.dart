import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../data/static_data.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _currentUser != null;
  String? get error => _error;

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = StaticData.currentUser.copyWith(email: email);
      _isLoading = false;
      notifyListeners();
      return true;
    } else {
      _error = 'Invalid credentials';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    _currentUser = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      profileImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200',
      createdAt: DateTime.now(),
    );
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = null;
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> updateProfile(String name, String email) async {
    if (_currentUser == null) return false;

    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 500));

    _currentUser = _currentUser!.copyWith(name: name, email: email);
    _isLoading = false;
    notifyListeners();
    return true;
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}