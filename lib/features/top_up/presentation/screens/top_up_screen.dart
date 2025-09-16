import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/empty_state.dart';

class TopUpScreen extends StatelessWidget {
  const TopUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Top Up'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: EmptyState(
        title: 'Top Up Feature',
        subtitle: 'Recharge your mobile phone easily',
        icon: Icons.phone_android,
        action: ElevatedButton(
          onPressed: () {},
          child: const Text('Top Up Now'),
        ),
      ),
    );
  }
}
