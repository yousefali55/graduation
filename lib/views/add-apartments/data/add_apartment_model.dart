class AddApartmentModel {
  final String title;
  final String titleEn;
  final String titleAr;
  final String description;
  final String descriptionEn;
  final String descriptionAr;
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

  AddApartmentModel({
    required this.title,
    required this.titleEn,
    required this.titleAr,
    required this.description,
    required this.descriptionEn,
    required this.descriptionAr,
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
  });

  factory AddApartmentModel.fromJson(Map<String, dynamic> json) {
    return AddApartmentModel(
      title: json['title'],
      titleEn: json['title_en'],
      titleAr: json['title_ar'],
      description: json['description'],
      descriptionEn: json['description_en'],
      descriptionAr: json['description_ar'],
      address: json['address'],
      price: double.parse(json['price']), // Convert to double
      rooms: json['rooms'],
      size: double.parse(json['size']), // Convert to double
      beds: json['beds'],
      bathrooms: json['bathrooms'],
      view: json['view'],
      finishingType: json['finishing_type'],
      floorNumber: json['floor_number'],
      yearOfConstruction: json['year_of_construction'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'title_en': titleEn,
      'title_ar': titleAr,
      'description': description,
      'description_en': descriptionEn,
      'description_ar': descriptionAr,
      'address': address,
      'price': price.toString(), // Convert to string for JSON
      'rooms': rooms.toString(), // Convert to string
      'size': size.toString(),
      'beds': beds.toString(),
      'bathrooms': bathrooms.toString(),
      'view': view,
      'finishing_type': finishingType,
      'floor_number': floorNumber.toString(), // Convert to string
      'year_of_construction':
          yearOfConstruction.toString(), // Convert to string
    };
  }
}
