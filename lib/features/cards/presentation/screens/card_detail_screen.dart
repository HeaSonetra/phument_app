import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class CardDetailScreen extends StatelessWidget {
  final String cardId;

  const CardDetailScreen({super.key, required this.cardId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Card Details'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text('Card Details for ID: $cardId')),
    );
  }
}
