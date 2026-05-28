# Expense Manager

A Flutter-based expense tracking app with analytics, category filtering, and local SQLite storage.

## Features

- Add, edit, and delete expenses
- Category-wise filtering
- Analytics screen
- Local data persistence using SQLite

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Dart SDK `^3.9.2`)
- Android Studio / VS Code with Flutter plugin
- Android emulator or physical device

## Setup Steps

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd expense_manager
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## Dependencies

| Package | Purpose |
|--------|---------|
| `sqflite` | Local SQLite database |
| `provider` | State management |
| `intl` | Date formatting |
| `sizer` | Responsive UI |
| `path` | File path utilities |

## Project Structure

```
lib/
├── db/          # Database helper (SQLite)
├── models/      # Expense model
├── providers/   # State management
├── screens/     # UI screens
├── utils/       # App dimensions/constants
├── widgets/     # Reusable widgets
└── main.dart
```
