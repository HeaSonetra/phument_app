import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class TransferSuccessScreen extends StatelessWidget {
  final Map<String, dynamic> transferData;

  const TransferSuccessScreen({super.key, required this.transferData});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Transfer Successful'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: Center(child: Text('Transfer Success Screen')),
    );
  }
}
