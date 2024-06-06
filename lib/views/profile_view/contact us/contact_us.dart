import 'package:flutter/material.dart';
import 'package:graduation/spacing/spacing.dart';
import 'package:graduation/theming/colors_manager.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsManager.mainGreen,
        title: const Text('Contact Us'),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 50),
            Card(
              color: ColorsManager.darkerWhite,
              shadowColor: Colors.green,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 100),
                child: Column(
                  children: [
                    Icon(Icons.location_on, size: 36, color: Colors.green),
                    Text('Our Address'),
                    Text(
                      'Ismailia',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 50),
                    Icon(Icons.phone, size: 36, color: Colors.green),
                    Text('Call Us'),
                    Text('+201028684980',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 50),
                    Icon(Icons.email, size: 36, color: Colors.green),
                    Text('Email Us'),
                    Text('Renting.support@gmail.com',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: 20),
            // const Text(
            //   'Send Us a Message',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: 'Your Name',
            //     labelStyle: const TextStyle(color: Colors.black54),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //           color: Colors.grey), // Default border color
            //       borderRadius:
            //           BorderRadius.circular(8.0), // Optional: rounded corners
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //           color: Colors.green), // Green border on focus
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            // ),
            // heightSpace(8),
            // TextFormField(
            //   decoration: InputDecoration(
            //     labelText: 'Your Email',
            //     labelStyle: const TextStyle(color: Colors.black54),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //           color: Colors.grey), // Default border color
            //       borderRadius:
            //           BorderRadius.circular(8.0), // Optional: rounded corners
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //           color: Colors.green), // Green border on focus
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            // ),
            // heightSpace(8),
            // TextFormField(
            //   maxLines: 3,
            //   decoration: InputDecoration(
            //     labelText: 'Message',
            //     labelStyle: const TextStyle(color: Colors.black54),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //           color: Colors.grey), // Default border color
            //       borderRadius:
            //           BorderRadius.circular(8.0), // Optional: rounded corners
            //     ),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: const BorderSide(
            //           color: Colors.green), // Green border on focus
            //       borderRadius: BorderRadius.circular(8.0),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 20),
            // ElevatedButton(
            //   style: ElevatedButton.styleFrom(
            //     backgroundColor: Colors.green, // Set the button color to green
            //   ),
            //   onPressed: () {
            //     // Handle form submission logic here
            //   },
            //   child: const Text('Submit',
            //       style: TextStyle(
            //           color: Colors.white)), // White text for contrast
            // ),
          ],
        ),
      ),
    );
  }
}
