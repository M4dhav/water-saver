class UserData {
  final String name;
  final String email;
  final bool onboardingComplete;
  final int reservoir;
  final int tank;

  UserData({
    required this.name,
    required this.email,
    required this.reservoir,
    required this.onboardingComplete,
    required this.tank,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'onboardingComplete': onboardingComplete,
      'reservoir': reservoir,
      'tank': tank,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      onboardingComplete: map['onboardingComplete'] ?? false,
      reservoir: map['reservoir'] ?? 0,
      tank: map['tank'] ?? 0,
    );
  }
}
