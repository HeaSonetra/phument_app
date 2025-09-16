import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/empty_state.dart';

class BillPayScreen extends StatelessWidget {
  const BillPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Bill Pay'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: EmptyState(
        title: 'Bill Pay Feature',
        subtitle: 'Pay your bills easily and securely',
        icon: Icons.receipt,
        action: ElevatedButton(
          onPressed: () {},
          child: const Text('Pay Bills'),
        ),
      ),
    );
  }
}
