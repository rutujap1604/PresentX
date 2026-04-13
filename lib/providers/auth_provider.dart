import 'package:flutter/material.dart';

class MockUser {
  final String uid;
  final String? email;
  final String? displayName;

  MockUser({required this.uid, this.email, this.displayName});
}

class AuthProvider with ChangeNotifier {
  MockUser? _user;
  String? _role;
  bool _isLoading = false;
  String? _errorMessage;
  Map<String, dynamic>? _cachedUserData;

  MockUser? get user => _user;
  String? get role => _role;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  AuthProvider() {
    // Initial state is logged out for demo
  }

  Future<bool> signIn(String email, String password) async {
    _setLoading(true);
    _errorMessage = null;
    
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    if (email.isEmpty || password.isEmpty) {
      _errorMessage = 'Please enter email and password';
      _setLoading(false);
      return false;
    }

    _user = MockUser(
      uid: 'demo_uid_123',
      email: email,
      displayName: email.split('@')[0],
    );

    // Handle hardcoded Admin credentials
    if (email.toLowerCase() == 'admin@gmail.com') {
      if (password != '12345') {
        _errorMessage = 'Invalid password for Admin';
        _setLoading(false);
        return false;
      }
      _role = 'admin';
    } 
    // Flexible role assignment for other demo accounts
    else if (email.toLowerCase().contains('teacher')) {
      _role = 'teacher';
    } else if (email.toLowerCase().contains('admin')) {
      _role = 'admin';
    } else {
      _role = 'student';
    }

    _cachedUserData = {
      'name': _role == 'admin' ? 'System Admin' : (_user!.displayName ?? 'Demo User'),
      'role': _role,
      'email': email,
      'department': _role == 'student' ? 'Computer Science' : 'Administration',
      'class': _role == 'student' ? 'TY' : 'N/A',
      'prn': _role == 'student' ? '12345678X' : 'ADMIN_001',
    };

    _setLoading(false);
    notifyListeners();
    return true;
  }

  Future<bool> signUp({
    required String email,
    required String password,
    required String name,
    required String role,
    String? department,
    String? className,
    String? prn,
  }) async {
    _setLoading(true);
    _errorMessage = null;

    await Future.delayed(const Duration(milliseconds: 500));

    _user = MockUser(
      uid: 'demo_uid_signup',
      email: email,
      displayName: name,
    );
    _role = role;

    _cachedUserData = {
      'name': name,
      'role': role,
      'email': email,
      'department': department ?? 'Computer Science',
      'class': className ?? 'TY',
      'prn': prn ?? '12345678X',
    };

    _setLoading(false);
    notifyListeners();
    return true;
  }

  Future<void> signOut() async {
    _user = null;
    _role = null;
    _cachedUserData = null;
    notifyListeners();
  }

  Future<Map<String, dynamic>?> getUserData() async {
    if (_user == null) return null;
    return _cachedUserData;
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
