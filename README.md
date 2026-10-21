# B2B Freshmore

B2B Freshmore is a Flutter mobile application for a business-to-business fresh produce ordering workflow. The source is organized into presentation, state management, domain, and data layers.

## Main components

- **Presentation:** Flutter screens and reusable UI components under `lib/presentation`.
- **State management:** BLoC and Cubit classes under `lib/base_architecture/state_management`.
- **Domain:** Models, entities, repositories, and use cases under `lib/base_architecture/domain`.
- **Data:** HTTP and local storage implementations under `lib/base_architecture/data`.
- **Dependency injection:** Service registration in `lib/injection_container.dart`.

The source includes flows and state classes for authentication, categories and products, cart and orders, payments, and wallet activity. Hive CE is used for local data, and Easy Localization is configured in the app entry point.

## Requirements

- Flutter SDK compatible with the Dart constraint in `pubspec.yaml` (`^3.10.8`).
- A platform target supported by Flutter, such as Android, iOS, web, or desktop.

## Setup

Fetch the Dart and Flutter dependencies:

```sh
flutter pub get
```

Run the app on a connected device or selected simulator:

```sh
flutter run
```

## Tests

Run all tests with:

```sh
flutter test
```

Focused unit tests can also be run by file:

```sh
flutter test test/formatter_test.dart
flutter test test/architecture_test.dart
flutter test test/state_management_test.dart
flutter test test/base_architecture/data/api_repository_test.dart
flutter test test/base_architecture/domain/crud_usecase_test.dart
flutter test test/base_architecture/state_management/base_bloc_test.dart
```

The formatter tests cover thousands grouping and Myanmar phone-number formatting, including empty input, international prefixes, and unsupported prefixes. The architecture tests cover API response mapping and nested category model parsing. The state management tests cover `BottomNavCubit` initialization and tab selection. `test/widget_test.dart` checks phone-number filtering in a Flutter text field.

## Current checkout notes

The API repository reads its base URL from the `API_BASE_URL` Dart define unless a URL is injected directly. For example:

```sh
flutter run --dart-define=API_BASE_URL=https://api.example.com
```

This checkout is incomplete: `api_end_point.dart` is empty, and several screen/component files imported by the app are missing. This prevents a full app build and endpoint-specific app BLoC analysis. The generic repository, CRUD use case, and base BLoC tests use injected dependencies and do not depend on the missing endpoint values.
