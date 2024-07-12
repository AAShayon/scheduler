import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduler/modules/home/viewModel/home_screen_view_model.dart';
import 'package:scheduler/modules/auth/view/login_page.dart';
import 'dart:convert';

class User extends StatelessWidget {
  const User({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeScreenViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(model.name ?? 'User'),
        actions: [
          if (model.profileImage != null)
            CircleAvatar(
              backgroundImage: MemoryImage(base64Decode(model.profileImage!)),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${model.name}'),
            Text('Start Date: ${model.startDate}'),
            Text('End Date: ${model.endDate}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await model.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
