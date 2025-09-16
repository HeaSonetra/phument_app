import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../screens/dashboard_screen.dart';

class QuickActionButton extends StatelessWidget {
  final QuickActionData data;

  const QuickActionButton({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: data.onTap,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radius12),
          border: Border.all(color: theme.colorScheme.outline.withOpacity(0.2)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radius8),
              ),
              child: Icon(
                data.icon,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ),
            const SizedBox(height: AppTheme.spacing8),
            Text(
              data.label,
              style: AppTheme.bodySmall.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: AppTheme.fontWeightMedium,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
