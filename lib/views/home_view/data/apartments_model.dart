import 'package:intl/intl.dart'; // Import DateFormat for date parsing

class Photo {
  final int id;
  final int apartmentId;
  final String photo;
  final DateTime addedAt;

  Photo({
    required this.id,
    required this.apartmentId,
    required this.photo,
    required this.addedAt,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    final dateFormat = DateFormat('yyyy-MM-dd hh:mm:ss a');
    return Photo(
      id: json['id'],
      apartmentId: json['apartment'],
      photo: json['photo'],
      addedAt: dateFormat.parse(json['added_at']), // Corrected parsing
    );
  }

  Map<String, dynamic> toJson() {
    final dateFormat = DateFormat('yyyy-MM-dd hh:mm:ss a');
    return {
      'id': id,
      'apartment': apartmentId,
      'photo': photo,
      'added_at': dateFormat.format(addedAt), // Corrected formatting
    };
  }
}

class ApartmentModel {
  final int id;
  final List<Photo> photos;
  final String ownerUsername;
  final String ownerPhoneNumber;
  final String ownerEmail;
  final String title;
  final String titleEn;
  final String? titleAr;
  final String description;
  final String descriptionEn;
  final String? descriptionAr;
  final String address;
  final double price;
  final int rooms;
  final double size;
  final int beds;
  final int bathrooms;
  final String view;
  final String finishingType;
  final int floorNumber;
  final int yearOfConstruction;
  final int owner;
  bool isFavorite; // Add isFavorite property

  ApartmentModel({
    required this.id,
    required this.photos,
    required this.ownerUsername,
    required this.ownerPhoneNumber,
    required this.ownerEmail,
    required this.title,
    required this.titleEn,
    this.titleAr,
    required this.description,
    required this.descriptionEn,
    this.descriptionAr,
    required this.address,
    required this.price,
    required this.rooms,
    required this.size,
    required this.beds,
    required this.bathrooms,
    required this.view,
    required this.finishingType,
    required this.floorNumber,
    required this.yearOfConstruction,
    required this.owner,
    this.isFavorite = false, // Initialize isFavorite to false
  });

  factory ApartmentModel.fromJson(Map<String, dynamic> json) {
    List<Photo> photos = [];
    if (json['photos'] != null) {
      photos = List<Photo>.from(
        json['photos'].map((photoJson) => Photo.fromJson(photoJson)),
      );
    }

    return ApartmentModel(
      id: json['id'],
      photos: photos,
      ownerUsername: json['owner_username'],
      ownerPhoneNumber: json['owner_phone_number'],
      ownerEmail: json['owner_email'],
      title: json['title'],
      titleEn: json['title_en'],
      titleAr: json['title_ar'],
      description: json['description'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      address: json['address'],
      price: double.tryParse(json['price'].toString()) ??
          0.0, // Handle parsing error
      rooms: json['rooms'],
      size: double.tryParse(json['size'].toString()) ??
          0.0, // Handle parsing error
      beds: json['beds'],
      bathrooms: json['bathrooms'],
      view: json['view'],
      finishingType: json['finishing_type'],
      floorNumber: json['floor_number'],
      yearOfConstruction: json['year_of_construction'],
      owner: json['owner'],
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> photosJson =
        photos.map((photo) => photo.toJson()).toList();

    return {
      'id': id,
      'photos': photosJson,
      'owner_username': ownerUsername,
      'owner_phone_number': ownerPhoneNumber,
      'owner_email': ownerEmail,
      'title': title,
      'title_en': titleEn,
      'title_ar': titleAr,
      'description': description,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'address': address,
      'price': price,
      'rooms': rooms,
      'size': size,
      'beds': beds,
      'bathrooms': bathrooms,
      'view': view,
      'finishing_type': finishingType,
      'floor_number': floorNumber,
      'year_of_construction': yearOfConstruction,
      'owner': owner,
    };
  }
}
