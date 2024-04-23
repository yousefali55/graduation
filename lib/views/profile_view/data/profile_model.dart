class ProfileModel {
  final int id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String userType;
  final String? avatar;
  final String phoneNumber;
  final String address;
  final bool isVerified;
  final bool isActive;
  final String? nationalId;
  final String? birthGovernorate;
  final DateTime? birthDate;
  final String? gender;
  final List<int> savedApartments;

  ProfileModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.userType,
    this.avatar,
    required this.phoneNumber,
    required this.address,
    required this.isVerified,
    required this.isActive,
    this.nationalId,
    this.birthGovernorate,
    this.birthDate,
    this.gender,
    required this.savedApartments,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      firstName: json['first_name'] ?? "",
      lastName: json['last_name'] ?? "",
      userType: json['user_type'],
      avatar: json['avatar'],
      phoneNumber: json['phone_number'] ?? "",
      address: json['address'] ?? "",
      isVerified: json['is_verified'],
      isActive: json['is_active'],
      nationalId: json['national_id'],
      birthGovernorate: json['birth_governorate'],
      birthDate: json['birth_date'] != null ? DateTime.parse(json['birth_date']) : null,
      gender: json['gender'],
      savedApartments: List<int>.from(json['saved_apartments'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'user_type': userType,
      'avatar': avatar,
      'phone_number': phoneNumber,
      'address': address,
      'is_verified': isVerified,
      'is_active': isActive,
      'national_id': nationalId,
      'birth_governorate': birthGovernorate,
      'birth_date': birthDate?.toIso8601String(),
      'gender': gender,
      'saved_apartments': savedApartments,
    };
  }
}
