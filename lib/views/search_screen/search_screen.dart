import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:graduation/views/apartments_details_view/apartment_details.dart';

class SearchScreen extends StatelessWidget {
  final List<ApartmentModel> apartments;
  final String query;
  final ValueChanged<String> onSearchChanged;

  const SearchScreen({
    super.key,
    required this.apartments,
    required this.query,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    final filteredApartments = apartments.where((apartment) {
      final apartmentTitle = apartment.title.toLowerCase();
      final input = query.toLowerCase();
      return apartmentTitle.contains(input);
    }).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: ListView.builder(
        itemCount: filteredApartments.length,
        itemBuilder: (BuildContext context, int index) {
          final apartment = filteredApartments[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ApartmentDetailsView(apartment: apartment),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    apartment.title,
                    style: GoogleFonts.sora(
                      color: ColorsManager.mainGreen,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    apartment.address,
                    style: const TextStyle(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'L.E ${apartment.price}/mo',
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
