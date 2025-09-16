import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/empty_state.dart';

class TransfersScreen extends StatelessWidget {
  const TransfersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Transfers'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: EmptyState(
        title: 'Transfers Feature',
        subtitle: 'Money transfer feature coming soon',
        icon: Icons.swap_horiz,
        action: ElevatedButton(
          onPressed: () {},
          child: const Text('New Transfer'),
        ),
      ),
    );
  }
}
