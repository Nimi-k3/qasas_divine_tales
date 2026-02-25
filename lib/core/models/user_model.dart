class UserModel {
  final int id;
  final String email;
  final bool isPremium;
  final DateTime? subscriptionExpiry;

  UserModel({
    required this.id,
    required this.email,
    required this.isPremium,
    this.subscriptionExpiry,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      isPremium: json['is_premium'],
      subscriptionExpiry: json['subscription_expiry'] != null
          ? DateTime.parse(json['subscription_expiry'])
          : null,
    );
  }
}
