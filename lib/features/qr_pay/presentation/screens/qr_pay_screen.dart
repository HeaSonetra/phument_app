import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/empty_state.dart';

class QrPayScreen extends StatelessWidget {
  const QrPayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('QR Pay'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: EmptyState(
        title: 'QR Pay Feature',
        subtitle: 'Scan QR codes to make payments',
        icon: Icons.qr_code,
        action: ElevatedButton(
          onPressed: () {},
          child: const Text('Scan QR Code'),
        ),
      ),
    );
  }
}
