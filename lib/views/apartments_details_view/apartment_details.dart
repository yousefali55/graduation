import 'package:flutter/material.dart';
import 'package:graduation/theming/colors_manager.dart';
import 'package:graduation/views/home_view/data/apartments_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ApartmentDetailsView extends StatelessWidget {
  final ApartmentModel apartment;

  const ApartmentDetailsView({super.key, required this.apartment});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Details',
          style: TextStyle(color: Color.fromARGB(255, 24, 24, 24)),
        ),
        backgroundColor: ColorsManager.mainGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    CachedNetworkImage(
                      imageUrl: apartment.photos.isNotEmpty
                          ? apartment.photos[0].photo
                          : 'https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1',
                      fit: BoxFit.cover,
                      height: 200,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            apartment.title,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${apartment.rooms} rooms | ${apartment.bathrooms} bathrooms | ${apartment.size} sqft',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Description:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            apartment.description,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Location:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            apartment.address,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Beds:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            apartment.beds.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'View: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            apartment.view,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Finishing type:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            apartment.finishingType,
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Floor number:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            apartment.floorNumber.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Year of construction:',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            apartment.yearOfConstruction.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                          const SizedBox(height: 22),
                          Row(
                            children: [
                              const Icon(Icons.price_change),
                              const SizedBox(width: 8),
                              Text(
                                'Price: ${apartment.price} E.G.P',
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(width: 8),
                              Text(
                                'Contact Agent: ${apartment.ownerPhoneNumber}',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () async {
                              final phoneNumber = apartment.ownerPhoneNumber;

                              if (phoneNumber.isNotEmpty) {
                                final Uri launchUri = Uri(
                                  scheme: 'tel',
                                  path: phoneNumber,
                                );

                                try {
                                  await launchUrl(launchUri);
                                } catch (e) {
                                  // Handle error if phone app can't be opened
                                  print("Could not launch phone app: $e");
                                  // Consider showing a snackbar with the error message
                                }
                              } else {
                                // Handle the case where the phone number is missing or empty
                                print("Phone number is missing or empty.");
                                // Consider showing a snackbar to the user
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsManager.mainGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text('Contact Agent',
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
