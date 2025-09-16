import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TransferReviewScreen extends StatelessWidget {
  final Map<String, dynamic> transferData;

  const TransferReviewScreen({super.key, required this.transferData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Review Transfer'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text('Transfer Review Screen')),
    );
  }
}
