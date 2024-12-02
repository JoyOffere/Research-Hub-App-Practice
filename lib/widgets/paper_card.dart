import 'package:flutter/material.dart';
import '../models/paper.dart';
import '../theme/colors.dart';

class PaperCard extends StatelessWidget {
  final Paper paper;

  const PaperCard({super.key, required this.paper});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondaryBackground,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/details',
            arguments: paper,
          );
        },
        child: Hero(
          tag: paper.title, // Unique tag for Hero animation
          child: ListTile(
            title: Text(
              paper.title,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            subtitle: Text(
              paper.authors,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ),
      ),
    );
  }
}
