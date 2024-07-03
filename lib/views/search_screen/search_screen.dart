import 'package:cached_network_image/cached_network_image.dart';
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
      padding: const EdgeInsets.all(16.0),
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
            child: Card(
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // More rounded corners
              ),
              child: Stack(
                // Use Stack for overlaying elements
                children: [
                  // Background Image with a cool effect
                  Hero(
                    tag: apartment.photos.isNotEmpty
                        ? apartment.photos[0].photo
                        : 'placeholder',
                    child: CachedNetworkImage(
                      imageUrl: apartment.photos.isNotEmpty
                          ? apartment.photos[0].photo
                          : 'https://via.placeholder.com/150',
                      width: double.infinity,
                      height: 180,
                      fit: BoxFit.cover,
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                              Colors.black26, // Add a slight black overlay
                              BlendMode.darken,
                            ),
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),

                  // Content positioned on top of the image
                  Positioned(
                    bottom: 28,
                    left: 16,
                    right: 16, // Align content to the edges
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(
                            0.8), // Semi-transparent white background
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apartment.title,
                            style: GoogleFonts.sora(
                              color: ColorsManager.darkGrey,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            apartment.address,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Colors
                                    .grey), // Smaller address for more space
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'L.E ${apartment.price}/mo',
                            style: GoogleFonts.sora(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
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
