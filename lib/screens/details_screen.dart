import 'package:flutter/material.dart';
import '../models/paper.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final paper = ModalRoute.of(context)!.settings.arguments as Paper;

    return Scaffold(
      appBar: AppBar(
        title: Text(paper.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              paper.title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Author: ${paper.authors}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text(
              'Abstract: ${paper.abstract}',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Open link
              },
              child: const Text('Read Full Paper'),
            ),
          ],
        ),
      ),
    );
  }
}
