import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../screens/onboarding_screen.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacing24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppTheme.radius20),
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.primary.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppTheme.radius20),
              child: Image.asset(
                data.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to icon if image fails to load
                  return Container(
                    color: theme.colorScheme.primary.withOpacity(0.1),
                    child: Icon(
                      _getIconForPage(data.title),
                      size: 120,
                      color: theme.colorScheme.primary,
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: AppTheme.spacing48),

          // Title
          Text(
            data.title,
            style: AppTheme.headlineMedium.copyWith(
              color: theme.colorScheme.onBackground,
              fontWeight: AppTheme.fontWeightBold,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: AppTheme.spacing16),

          // Subtitle
          Text(
            data.subtitle,
            style: AppTheme.bodyLarge.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getIconForPage(String title) {
    if (title.contains('Welcome')) {
      return Icons.account_balance;
    } else if (title.contains('Secure')) {
      return Icons.security;
    } else if (title.contains('Support')) {
      return Icons.support_agent;
    }
    return Icons.account_balance;
  }
}
