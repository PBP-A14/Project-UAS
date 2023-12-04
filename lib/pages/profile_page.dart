import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            // crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
            children: [
              const SizedBox(height: 16),
              const Text(
                'Your Progress',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Your progress widgets go here
              const SizedBox(height: 16),
              const Text(
                'Your Reading History',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Your Reading History widgets go here
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Add your logic to handle the change password button click
                  // It might include showing a dialog or navigating to another page
                },
                child: const Text('Change Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
