part of '../auth.dart';

class AuthViewmodel extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Map<String, dynamic>? _userProfile;
  Map<String, dynamic>? get userProfile => _userProfile;

  String? _message;
  String? get message => _message;

  // ✅ 1. Add a private field to store the ID in memory
  int? _userId;

  // ✅ 2. The Getter for ProxyProvider
  // Returning 0 as a default if null to prevent crashes in downstream ViewModels
  int get userId => _userId ?? 0;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  void clearMessage() {
    _message = null;
    notifyListeners();
  }

  // ... [register method remains same] ...
    Future<void> register(String email, String password) async {
    _setLoading(true);
    final res = await AuthApi.register(email, password);
    _setLoading(false);

    _message = res['message'] ?? res['error'];
    notifyListeners();
  }

  /// ---------- LOGIN ----------
  Future<void> login(String email, String password) async {
    _setLoading(true);
    try {
      final res = await AuthApi.login(email, password);
      _setLoading(false);

      if (res['id'] != null) {
        // ✅ 3. Update memory state
        _userId = res['id'];
        
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('user_id', res['id']);
        prefs.setBool('is_premium', res['is_premium'] ?? false);
        AuthService.setLoggedIn(true);
        _message = "Login successful";
        
        // Notify listeners so ProxyProviders see the new userId
        notifyListeners(); 
      } else {
        _message = res['error'] ?? "Unexpected response";
      }
    } catch (e) {
      _setLoading(false);
      _message = "Failed to login. Try again.";
    }
    notifyListeners();
  }
  
  /// ---------- GET PROFILE ----------
  Future<void> fetchProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');
    if (userId == null) return;

    _setLoading(true);
    final res = await AuthApi.getProfile(userId);
    _setLoading(false);

    if (res['error'] != null) {
      _message = res['error'];
    } else {
      _userProfile = res['user'];
    }
    notifyListeners();
  }

  /// ---------- LOGOUT ----------
  Future<bool> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final idToLogout = _userId ?? prefs.getInt('user_id');
    if (idToLogout == null) return false;

    _setLoading(true);
    final res = await AuthApi.logout(idToLogout);
    _setLoading(false);

    if (res['message']?.toLowerCase().contains('logged out') == true) {
      // ✅ 4. Clear memory state
      _userId = null; 
      
      await prefs.remove('user_id');
      AuthService.setLoggedIn(false);
      _message = res['message'];
      notifyListeners();
      return true;
    }
    // ... rest of the method
    return false;
  }
  Future<bool> deleteAccount() async {
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getInt('user_id');
  if (userId == null) return false;

  _setLoading(true);
  final res = await AuthApi.deleteAccount(userId);
  _setLoading(false);

  if (res['status'] == 'success') {
    await prefs.clear();
    _message = "Account deleted successfully";
    notifyListeners();
    return true;
  } else {
    _message = res['error'] ?? "Account deletion failed";
    notifyListeners();
    return false;
  }
  }
  }