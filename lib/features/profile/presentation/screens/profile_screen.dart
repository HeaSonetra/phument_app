import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/routes/app_router.dart';
import '../../../../core/widgets/info_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppTheme.spacing24),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(AppTheme.radius24),
                  bottomRight: Radius.circular(AppTheme.radius24),
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: const Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing16),
                  Text(
                    'John Doe',
                    style: AppTheme.headlineSmall.copyWith(
                      color: Colors.white,
                      fontWeight: AppTheme.fontWeightBold,
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing4),
                  Text(
                    'john.doe@example.com',
                    style: AppTheme.bodyMedium.copyWith(
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: AppTheme.spacing8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacing12,
                      vertical: AppTheme.spacing4,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.successColor,
                      borderRadius: BorderRadius.circular(AppTheme.radius12),
                    ),
                    child: Text(
                      'Verified',
                      style: AppTheme.labelSmall.copyWith(
                        color: Colors.white,
                        fontWeight: AppTheme.fontWeightMedium,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Profile options
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacing16),
              child: Column(
                children: [
                  InfoTile(
                    title: 'Personal Information',
                    subtitle: 'Update your personal details',
                    leading: const Icon(Icons.person_outline),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  InfoTile(
                    title: 'Security Settings',
                    subtitle: 'Manage your security preferences',
                    leading: const Icon(Icons.security),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.go(AppRouter.settings),
                  ),
                  InfoTile(
                    title: 'Notifications',
                    subtitle: 'Manage notification preferences',
                    leading: const Icon(Icons.notifications_outlined),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.go(AppRouter.notifications),
                  ),
                  InfoTile(
                    title: 'Help & Support',
                    subtitle: 'Get help and contact support',
                    leading: const Icon(Icons.help_outline),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () => context.go(AppRouter.support),
                  ),
                  InfoTile(
                    title: 'About',
                    subtitle: 'App version and information',
                    leading: const Icon(Icons.info_outline),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {},
                  ),
                  InfoTile(
                    title: 'Sign Out',
                    subtitle: 'Sign out of your account',
                    leading: const Icon(
                      Icons.logout,
                      color: AppTheme.errorColor,
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Handle sign out
                      context.go(AppRouter.login);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
