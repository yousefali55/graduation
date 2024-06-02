import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListView.builder(
        itemCount: filteredApartments.length,
        itemBuilder: (BuildContext context, int index) {
          final apartment = filteredApartments[index];
          return Container(
            height: 40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: ColorsManager.mainGreen,
            ),
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            child: Center(
              child: Text(
                apartment.title,
                style: GoogleFonts.sora(
                  color: ColorsManager.darkerWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
