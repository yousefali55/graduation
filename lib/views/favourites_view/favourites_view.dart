import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/apartments_details_view/apartment_details.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';

class FavoritesView extends StatelessWidget {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          final favoritesList = state.favorites;
          if (favoritesList.isEmpty) {
            return Center(
              child: Text(
                'No favorites yet',
                style: GoogleFonts.sora(
                  fontSize: 18,
                  color: Colors.grey,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: favoritesList.length,
            itemBuilder: (BuildContext context, int index) {
              final apartment = favoritesList[index];
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
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: const LinearGradient(
                        // Gradient background
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [Colors.lightGreen, ColorsManager.mainGreen],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      // Overlapping elements
                      children: [
                        // Image with a curved bottom edge
                        ClipPath(
                          clipper:
                              WaveClipper(), // Custom clipper for the wave effect
                          child: Hero(
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
                              placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),

                        // Content overlay with semi-transparent background
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(
                                  0.3), // Semi-transparent black overlay
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Title in white with a larger font size
                                  Text(
                                    apartment.title,
                                    style: GoogleFonts.sora(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // Price in white
                                  Text(
                                    apartment.address,
                                    style: GoogleFonts.sora(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  heightSpace(5),
                                  Text(
                                    'L.E ${apartment.price}/mo',
                                    style: GoogleFonts.sora(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is GetApartmentsLoading) {
          return const Center(
              child: CircularProgressIndicator(color: ColorsManager.mainGreen));
        } else if (state is GetApartmentsFailure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: Text('No favorites yet'));
        }
      },
    );
  }
}

// Custom Clipper for the wave effect
class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height);
    var firstStart = Offset(size.width / 5, size.height);
    var firstEnd = Offset(size.width / 2.25, size.height - 50.0);
    path.quadraticBezierTo(
        firstStart.dx, firstStart.dy, firstEnd.dx, firstEnd.dy);

    var secondStart =
        Offset(size.width - (size.width / 3.24), size.height - 105);
    var secondEnd = Offset(size.width, size.height - 10);
    path.quadraticBezierTo(
        secondStart.dx, secondStart.dy, secondEnd.dx, secondEnd.dy);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
