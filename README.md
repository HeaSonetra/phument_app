# Techey Bank - Flutter Banking App

A complete Flutter UI-only sample banking app suitable for demo/mockups. Built with Flutter 3.x, Material 3, and clean architecture principles.

## Features

### 🏦 Core Banking Features
- **Onboarding**: 3-slide welcome experience with skip/next navigation
- **Authentication**: Login with phone/email and OTP verification
- **Dashboard**: Account overview with balance cards and quick actions
- **Accounts**: Account management with detailed views and transaction history
- **Cards**: Card carousel with freeze/unfreeze functionality
- **Transfers**: Money transfer with beneficiary selection and amount keypad
- **Bill Pay**: Utility bill payments with category selection
- **Top Up**: Mobile recharge with operator selection
- **QR Pay**: QR code payment interface (mock)
- **Notifications**: Transactional and promotional notifications
- **Support**: Chat interface with support team
- **Profile**: User profile and settings management

### 🎨 Design System
- **Material 3**: Modern design with teal color scheme
- **Responsive**: Phone-first design that scales to tablets
- **Dark Mode**: Full light/dark theme support
- **Localization**: English and Khmer language support
- **Accessibility**: Large touch targets and semantic labels

### 🏗️ Architecture
- **Clean Architecture**: Feature-based folder structure
- **State Management**: Flutter Riverpod for lightweight state
- **Navigation**: Go Router with type-safe routes
- **Mock Data**: JSON-based mock repositories
- **Reusable Components**: Consistent UI component library

## Project Structure

```
lib/
├── core/
│   ├── theme/           # App theme and design system
│   ├── widgets/         # Reusable UI components
│   ├── routes/          # Navigation configuration
│   ├── mock/            # Mock data repositories
│   └── utils/           # Utility functions
├── features/
│   ├── onboarding/      # Onboarding screens
│   ├── auth/           # Authentication screens
│   ├── dashboard/      # Main dashboard
│   ├── accounts/       # Account management
│   ├── cards/          # Card management
│   ├── transfers/      # Money transfers
│   ├── bill_pay/       # Bill payments
│   ├── top_up/         # Mobile top-up
│   ├── qr_pay/         # QR payments
│   ├── notifications/  # Notifications
│   ├── support/        # Support chat
│   └── profile/        # Profile and settings
└── l10n/               # Localization files
```

## Getting Started

### Prerequisites
- Flutter 3.x or higher
- Dart 3.x or higher
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd techey_bank
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Dependencies

Key dependencies used in this project:

- `flutter_riverpod`: State management
- `go_router`: Navigation and routing
- `flutter_localizations`: Internationalization
- `intl`: Date and number formatting
- `flutter_svg`: SVG image support
- `lottie`: Animations
- `shimmer`: Loading placeholders
- `confetti`: Success animations

## Mock Data

The app uses mock JSON data located in `assets/mock/`:

- `accounts.json`: Bank account information
- `transactions.json`: Transaction history
- `cards.json`: Credit/debit card details
- `bills.json`: Bill payment providers
- `notifications.json`: Notification data

### Editing Mock Data

To modify the mock data:

1. Navigate to `assets/mock/`
2. Edit the respective JSON files
3. Hot reload the app to see changes

Example: To add a new account, edit `accounts.json`:

```json
{
  "id": "4",
  "accountNumber": "9876543210",
  "accountName": "New Savings Account",
  "balance": "1,000.00",
  "currency": "USD",
  "accountType": "savings",
  "isActive": true,
  "lastTransaction": "2024-01-16T10:30:00Z"
}
```

## Customization

### Theme Colors

Edit `lib/core/theme/app_theme.dart` to customize colors:

```dart
static const Color primaryColor = Color(0xFF00695C); // Teal 800
static const Color secondaryColor = Color(0xFF26A69A); // Teal 400
```

### Adding New Screens

1. Create feature folder: `lib/features/new_feature/`
2. Add presentation screens and widgets
3. Update routes in `lib/core/routes/app_router.dart`
4. Add navigation calls where needed

### Localization

Add new strings to:
- `lib/l10n/app_en.arb` (English)
- `lib/l10n/app_km.arb` (Khmer)

## Features Overview

### Dashboard
- Personalized greeting with time-based messages
- Account balance cards with hide/show functionality
- Quick action buttons for common tasks
- Recent transactions list

### Accounts
- Account list with filtering by type
- Detailed account view with transaction history
- Date range and type filtering
- Balance visibility toggle

### Authentication
- Phone/email login with validation
- OTP verification with resend functionality
- Form validation and error handling

### Settings
- Language selection (English/Khmer)
- Theme selection (Light/Dark/System)
- Biometric authentication toggle
- Security and privacy options

## UI Components

### Core Components
- `PrimaryButton`: Main action button
- `OutlineButton`: Secondary action button
- `ChipFilter`: Filter selection chips
- `AmountKeypad`: Custom number keypad
- `InfoTile`: Information display tile
- `EmptyState`: Empty state placeholder
- `SectionHeader`: Section title with actions
- `BalanceCard`: Account balance display
- `TransactionTile`: Transaction list item

### Design Tokens
- Consistent spacing (4px, 8px, 12px, 16px, etc.)
- Typography scale with predefined text styles
- Color palette with semantic naming
- Border radius values (4px, 8px, 12px, 16px, etc.)
- Elevation levels for shadows

## Testing

The project includes basic widget tests for critical components:

```bash
flutter test
```

## Building for Production

### Android
```bash
flutter build apk --release
```

### iOS
```bash
flutter build ios --release
```

### Web
```bash
flutter build web --release
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is for demonstration purposes only. Please ensure you have proper licensing for any production use.

## Support

For questions or support, please contact the development team or create an issue in the repository.

---

**Note**: This is a UI-only demo app with mock data. No real banking functionality, network calls, or payment processing is implemented.