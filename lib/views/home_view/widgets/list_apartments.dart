import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/apartments_details_view/apartment_details.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_cubit.dart';
import 'package:graduation/views/home_view/data/cubit/get_apartments_state.dart';

class ListApartment extends StatelessWidget {
  const ListApartment({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetApartmentsCubit, GetApartmentsState>(
      builder: (context, state) {
        if (state is GetApartmentsSuccess) {
          return ListView.builder(
            itemCount: state.apartments.length,
            itemBuilder: (context, index) {
              final apartment = state.apartments[index];
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
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Hero(
                              tag: apartment.photos.isNotEmpty
                                  ? apartment.photos[0].photo
                                  : 'placeholder',
                              child: ClipRRect(
                                // Asymmetrical clipping for visual interest
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.elliptical(
                                      120, 60), // Exaggerated curve
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: apartment.photos.isNotEmpty
                                      ? apartment.photos[0].photo
                                      : 'https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1',
                                  placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          color: ColorsManager.mainGreen)),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 220,
                                ),
                              ),
                            ),
                            Positioned(
                              // Animated "NEW" badge with gradient and shadow
                              top: 16,
                              left: 16,
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: 1),
                                duration: const Duration(milliseconds: 800),
                                builder: (context, value, child) {
                                  return Transform.scale(
                                    scale: value,
                                    child: Opacity(
                                      opacity: value,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12, vertical: 6),
                                        decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              ColorsManager.mainGreen,
                                              Colors.greenAccent
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 1,
                                              blurRadius: 2,
                                              offset: const Offset(0, 1),
                                            ),
                                          ],
                                        ),
                                        child: const Text(
                                          'NEW',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              bottom: -15,
                              right: 24,
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  // Use InkWell for ripple effect
                                  borderRadius: BorderRadius.circular(30),
                                  onTap: () {
                                    final cubit =
                                        context.read<GetApartmentsCubit>();
                                    cubit.toggleFavorite(apartment);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      apartment.isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: apartment.isFavorite
                                          ? Colors.red
                                          : Colors.grey[600],
                                      size: 28,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildIconText(
                                      Icons.bed,
                                      '${apartment.beds}    ',
                                      ColorsManager.mainGreen,
                                      20),
                                  _buildIconText(
                                      Icons.bathtub,
                                      '${apartment.bathrooms}    ',
                                      ColorsManager.mainGreen,
                                      20),
                                  _buildIconText(
                                      Icons.bedroom_parent,
                                      '${apartment.rooms}  ',
                                      ColorsManager.mainGreen,
                                      20),
                                ],
                              ),
                              heightSpace(16),
                              Text(
                                apartment.title,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                apartment.address,
                                style: TextStyle(
                                    fontSize: 14, color: Colors.grey[600]),
                              ),
                              heightSpace(8),
                              Text(
                                '${apartment.price} L.E/mo',
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        } else if (state is GetApartmentsFailure) {
          return Center(
              child: Text('Failed to load apartments: ${state.errorMessage}'));
        } else if (state is GetApartmentsLoading) {
          return const Center(
              child: CircularProgressIndicator(color: ColorsManager.mainGreen));
        } else {
          return const Center(child: Text('No apartments available'));
        }
      },
    );
  }

  // Helper function for a nice row for a property and its value
  Widget _buildIconText(IconData icon, String text, Color color, double size) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: size, color: color), // Use the passed size
        const SizedBox(width: 8),
        Text(text,
            style: TextStyle(
                fontSize: size - 2,
                color: color)), // Adjust text size based on icon size
      ],
    );
  }
}
