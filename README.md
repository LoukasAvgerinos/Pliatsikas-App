<<<<<<< HEAD
# pliatsikas_app

Pliatsikas Managing Orders

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
# Pliatsikas Order Management App

A comprehensive Flutter application for managing orders at Pliatsikas Chicken business. This app streamlines the process of creating, editing, and tracking customer orders for various chicken products, with support for Greek and English languages.

## 📋 Table of Contents

- [Features](#features)
- [Screenshots](#screenshots)
- [Technologies Used](#technologies-used)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Database](#database)
- [Localization](#localization)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

- **Order Management**: Create, edit, and track customer orders
- **Product Catalog**: Comprehensive list of chicken products with pricing
- **Customer Information**: Store customer details (name, phone, address)
- **Delivery Scheduling**: Set and manage delivery dates
- **Order Notes**: Add special instructions or notes to orders
- **Local Database**: Persistent storage using SQLite
- **Multi-language Support**: Greek and English localization
- **Responsive Design**: Optimized for mobile devices
- **Date-based Order Filtering**: View orders by specific dates
- **Order Status Tracking**: Mark orders as finished or cancelled

## 📸 Screenshots

*Add screenshots of your app here once available*

## 🛠 Technologies Used

- **Flutter**: Cross-platform mobile development framework
- **Dart**: Programming language
- **SQLite (sqflite)**: Local database for data persistence
- **Shared Preferences**: For storing app settings
- **Google Fonts**: Custom typography
- **Lottie**: For animations
- **UUID**: For generating unique order IDs
- **Intl**: Internationalization support

## 📋 Prerequisites

Before running this project, make sure you have the following installed:

- Flutter SDK (version 3.6.1 or higher)
- Dart SDK (version 3.6.1 or higher)
- Android Studio or VS Code with Flutter extensions
- Android/iOS emulator or physical device

## 🚀 Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/your-username/pliatsikas-app.git
   cd pliatsikas-app
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Configure launcher icons (optional):**
   ```bash
   flutter pub run flutter_launcher_icons
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## 📖 Usage

### Creating a New Order

1. From the home screen, tap the floating action button (+)
2. Enter customer information (name, phone, address)
3. Select products and quantities from the catalog
4. Set the delivery date
5. Add any special notes
6. Tap "Submit" to save the order

### Viewing Orders by Date

1. Tap the "Orders by Date" button on the home screen
2. Select a date to view orders for that day
3. Browse through the list of orders
4. Tap on an order to view details or edit

### Editing an Order

1. From the orders list, tap on an existing order
2. Modify customer information, products, or delivery date
3. Save changes

### Managing Order Status

- Use the "Finished" button to mark orders as completed
- Use the "Cancel" button to cancel orders
- View order history and status

## 🏗 Project Structure

```
lib/
├── main.dart                 # App entry point
├── buttons/                  # Custom button widgets
├── constants/                # App constants and configurations
├── database/                 # Database creation and management
├── models/                   # Data models (Product)
├── pages/                    # App screens/pages
├── theme/                    # App theming
└── widgets/                  # Reusable UI components
```

## 💾 Database

The app uses SQLite for local data storage with the following main tables:

- **Orders**: Stores order information including customer details, delivery date, and notes
- **Order Products**: Links orders to products with quantities

Database operations are handled through the `DatabaseHelper` class in `lib/database/database_creation.dart`.

## 🌍 Localization

The app supports both Greek and English languages:

- Default language: Greek (el)
- Supported locales: Greek (el), English (en)
- Uses Flutter's internationalization framework

## 📄 License

This project is private and not intended for public distribution.

---

**Developed by:** Loukas Avgerinos  
**Version:** 1.0.1 
**Last Updated:** December 2025
>>>>>>> badc306 (Add search functionality to orders page and update version to 1.0.2)
