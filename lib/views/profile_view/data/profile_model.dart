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
  final String? birthDate; // Store as string
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
    try {
      return ProfileModel(
        id: json['id'] is int ? json['id'] as int : int.parse(json['id']),
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
        birthDate: json['birth_date'] as String?,
        gender: json['gender'],
        savedApartments: List<int>.from(
            (json['saved_apartments'] as List<dynamic>?)?.map((item) {
                  if (item is int) {
                    return item;
                  } else if (item is Map<String, dynamic>) {
                    return item['id'] as int; // Cast extracted id to int
                  } else if (item is String) {
                    return int.parse(item);
                  } else {
                    throw FormatException(
                        "Invalid type in saved_apartments list: ${item.runtimeType}");
                  }
                }) ??
                []),
      );
    } catch (e, stackTrace) {
      // Catch the error along with the stack trace
      print("Error parsing ProfileModel:");
      print("Error Type: ${e.runtimeType}");
      print("Error Message: ${e.toString()}");
      print("Stack Trace:\n$stackTrace"); // Print the stack trace for debugging
      return ProfileModel(
        id: 0,
        username: "",
        email: "",
        firstName: "",
        lastName: "",
        userType: "",
        phoneNumber: "",
        address: "",
        isVerified: false,
        isActive: false,
        savedApartments: [],
      );
    }
  }
}
