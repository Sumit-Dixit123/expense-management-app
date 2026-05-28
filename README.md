# Expense Manager

A Flutter expense tracking app built with Provider state management and local SQLite storage.

## Features

- Add, edit, and delete expenses
- 7 expense categories: Food, Transport, Shopping, Health, Entertainment, Bills, Other
- Search expenses by title
- Filter expenses by category
- Analytics screen with category-wise spending breakdown and progress bars
- Dark / Light mode toggle
- Local data persistence using SQLite (no internet required)
- Responsive UI using `sizer` package

## Tech Stack

| Layer | Technology |
|-------|-----------|
| UI | Flutter (Material 3) |
| State Management | Provider |
| Local Database | SQLite via `sqflite` |
| Date Formatting | `intl` |
| Responsive UI | `sizer` |

## Prerequisites

- Flutter SDK `^3.9.2` — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK `^3.9.2` (comes with Flutter)
- Android Studio or VS Code with Flutter & Dart plugins
- Android emulator / physical device (Android or iOS)

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

   To run on a specific platform:
   ```bash
   flutter run -d android
   flutter run -d ios
   flutter run -d windows
   ```

4. **Build APK (optional)**
   ```bash
   flutter build apk --release
   ```

## Project Structure

```
lib/
├── db/
│   └── database_helper.dart     # SQLite CRUD operations
├── models/
│   └── expense.dart             # Expense model + kCategories list
├── providers/
│   └── expense_provider.dart    # State management (Provider)
├── screens/
│   ├── home_screen.dart         # Expense list + search + filter
│   ├── add_edit_expense_screen.dart  # Add / Edit form
│   └── analytics_screen.dart   # Category-wise analytics
├── utils/
│   └── app_dimens.dart          # App dimension constants
├── widgets/
│   ├── category_filter_bar.dart # Category filter chips
│   └── expense_list_item.dart   # Single expense card
└── main.dart                    # App entry point + Provider setup
```

## What Was Implemented

- **Expense Model** — `id`, `title`, `amount`, `category`, `date` with `toMap` / `fromMap` / `copyWith`
- **DatabaseHelper** — Singleton SQLite helper with insert, getAll, update, delete
- **ExpenseProvider** — ChangeNotifier managing expenses list, search, category filter, dark mode, category totals
- **HomeScreen** — Search bar, category filter bar, expense list with edit/delete actions
- **AddEditExpenseScreen** — Form with validation for title, amount, category dropdown, date picker
- **AnalyticsScreen** — Grand total card + per-category amount, percentage, and linear progress bar
