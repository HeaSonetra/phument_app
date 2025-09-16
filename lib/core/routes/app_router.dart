import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/accounts/presentation/screens/accounts_screen.dart';
import '../../features/accounts/presentation/screens/account_detail_screen.dart';
import '../../features/cards/presentation/screens/cards_screen.dart';
import '../../features/cards/presentation/screens/card_detail_screen.dart';
import '../../features/transfers/presentation/screens/transfers_screen.dart';
import '../../features/transfers/presentation/screens/transfer_review_screen.dart';
import '../../features/transfers/presentation/screens/transfer_success_screen.dart';
import '../../features/bill_pay/presentation/screens/bill_pay_screen.dart';
import '../../features/top_up/presentation/screens/top_up_screen.dart';
import '../../features/qr_pay/presentation/screens/qr_pay_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/support/presentation/screens/support_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/profile/presentation/screens/settings_screen.dart';

class AppRouter {
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String otp = '/otp';
  static const String dashboard = '/dashboard';
  static const String accounts = '/accounts';
  static const String accountDetail = '/accounts/detail';
  static const String cards = '/cards';
  static const String cardDetail = '/cards/detail';
  static const String transfers = '/transfers';
  static const String transferReview = '/transfers/review';
  static const String transferSuccess = '/transfers/success';
  static const String billPay = '/bill-pay';
  static const String topUp = '/top-up';
  static const String qrPay = '/qr-pay';
  static const String notifications = '/notifications';
  static const String support = '/support';
  static const String profile = '/profile';
  static const String settings = '/settings';

  static final GoRouter router = GoRouter(
    initialLocation: onboarding,
    routes: [
      // Onboarding
      GoRoute(
        path: onboarding,
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),

      // Authentication
      GoRoute(
        path: login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: otp,
        name: 'otp',
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '';
          return OtpScreen(phoneNumber: phoneNumber);
        },
      ),

      // Main App
      GoRoute(
        path: dashboard,
        name: 'dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),

      // Accounts
      GoRoute(
        path: accounts,
        name: 'accounts',
        builder: (context, state) => const AccountsScreen(),
      ),
      GoRoute(
        path: '$accountDetail/:accountId',
        name: 'accountDetail',
        builder: (context, state) {
          final accountId = state.pathParameters['accountId']!;
          return AccountDetailScreen(accountId: accountId);
        },
      ),

      // Cards
      GoRoute(
        path: cards,
        name: 'cards',
        builder: (context, state) => const CardsScreen(),
      ),
      GoRoute(
        path: '$cardDetail/:cardId',
        name: 'cardDetail',
        builder: (context, state) {
          final cardId = state.pathParameters['cardId']!;
          return CardDetailScreen(cardId: cardId);
        },
      ),

      // Transfers
      GoRoute(
        path: transfers,
        name: 'transfers',
        builder: (context, state) => const TransfersScreen(),
      ),
      GoRoute(
        path: transferReview,
        name: 'transferReview',
        builder: (context, state) {
          final transferData = state.extra as Map<String, dynamic>? ?? {};
          return TransferReviewScreen(transferData: transferData);
        },
      ),
      GoRoute(
        path: transferSuccess,
        name: 'transferSuccess',
        builder: (context, state) {
          final transferData = state.extra as Map<String, dynamic>? ?? {};
          return TransferSuccessScreen(transferData: transferData);
        },
      ),

      // Bill Pay
      GoRoute(
        path: billPay,
        name: 'billPay',
        builder: (context, state) => const BillPayScreen(),
      ),

      // Top Up
      GoRoute(
        path: topUp,
        name: 'topUp',
        builder: (context, state) => const TopUpScreen(),
      ),

      // QR Pay
      GoRoute(
        path: qrPay,
        name: 'qrPay',
        builder: (context, state) => const QrPayScreen(),
      ),

      // Notifications
      GoRoute(
        path: notifications,
        name: 'notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),

      // Support
      GoRoute(
        path: support,
        name: 'support',
        builder: (context, state) => const SupportScreen(),
      ),

      // Profile
      GoRoute(
        path: profile,
        name: 'profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: settings,
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text('Page not found: ${state.uri}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(dashboard),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    ),
  );
}
