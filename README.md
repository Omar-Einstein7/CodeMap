# CodeMap

A Flutter-based educational platform that delivers structured programming courses with an interactive learning experience.

## Features

- **Course Catalog** — Browse courses by category (Mobile, Frontend, Backend, AI, Desktop)
- **Rich Content** — Video lessons, text articles, and interactive quizzes
- **Authentication** — Full auth flow with login, signup, and password recovery
- **Progress Tracking** — Track lesson completion across courses
- **Favourites** — Bookmark courses for quick access
- **User Profile** — Personalized profile and settings
- **Dark Mode** — Theme toggle with persistent preference

## Architecture

```
lib/
  main.dart                  # App entry point
  src/
    app.dart                 # Root app widget (CodeMapApp)
    config/                  # API URLs, Dio setup, generic data helpers
    extensions/              # Context, string, num, widget, date_time, collection extensions
    imports/                 # Barrel files for centralized imports
    routing/                 # GoRouter config, route constants, global navigator
    services/                # Dio client, interceptors, secure storage, service locator, session, splash
    shared/                  # Reusable enums, helpers, widgets, wrappers
    theme/                   # Light/dark theming with Riverpod
    utils/                   # Result type, failure classes, usecase abstraction
  features/                  # Feature-based modules
    auth/                    # Authentication (data, domain, presentation)
    course/                  # Course browsing, detail, content, lessons
    favourite/               # Favourite/bookmark management
    home/                    # Home screen with featured & recent courses
    navigation/              # Bottom navigation shell
    profile/                 # User profile & settings
    splash/                  # Splash screen with auth check
```

### State Management

- **Riverpod** — Theme state, DI via providers
- **BLoC/Cubit** — Feature-level state (auth, courses, session, favourites, profile)
- **GoRouter** — Declarative routing with auth redirect guards

## Tech Stack

| Package | Purpose |
|---|---|
| `flutter_riverpod` | State management |
| `flutter_bloc` | Feature state management |
| `go_router` | Declarative routing |
| `dio` | HTTP networking |
| `get_it` | Service locator |
| `shared_preferences` | Local key-value storage |
| `flutter_secure_storage` | Secure token storage |
| `equatable` | Value equality |
| `logger` | Debug logging |
| `lottie` | Animations |
| `url_launcher` | External links |
| `intl` | Internationalization |

## Getting Started

### Prerequisites

- Flutter SDK ^3.10.8
- Dart SDK ^3.10.8

### Setup

```bash
# Clone the repository
git clone https://github.com/Omar-Einstein7/CodeMap.git
cd CodeMap

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build

```bash
# Android APK
flutter build apk --release

# iOS
flutter build ios --release

# Web
flutter build web
```

## Project Structure

Each feature follows a clean architecture approach:

```
features/{feature}/
  data/
    datasources/             # Remote & local data sources
    models/                  # Data transfer objects (DTOs)
    repositories/            # Repository implementations
  domain/
    entities/                # Business logic entities
    repositories/            # Repository abstractions
  presentation/
    cubit/                   # BLoC/Cubit state management
    pages/                   # Screen widgets
    widgets/                 # Reusable UI components
```
