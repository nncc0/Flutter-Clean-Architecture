# app

A Flutter project with clean architecture and best practices.

## Features

- Clean Architecture with BLoC pattern
- Dependency Injection with GetIt
- Routing with GoRouter
- Dark/Light Theme Support
- Internationalization (i18n)



## Project Structure

```
lib/
├── core/                  # Core functionality
│   ├── errors/            # Custom exceptions and failures
│   ├── network/           # Network-related code
│   ├── utils/             # Utility functions and constants
│   ├── widgets/           # Reusable widgets
│   ├── services/          # App services
│   ├── usecases/          # Use cases for business logic
│   └── common/            # Common resources
│   └── theme/             # Theme-related code
│   └── l10n/              # Localization

└── features/              # Feature modules
    
    └── settings/          # Settings feature
```

## Getting Started

1. Install dependencies:
   ```bash
   flutter pub get
   ```

2. Run the app:
   ```bash
   flutter run
   ```

## Dependencies

### Core
- flutter_bloc: State management
- equatable: Value equality
- get_it: Service locator
- go_router: Declarative routing
- dartz: Functional programming
- formz: Form input validation

### Network
- dio: HTTP client
- connectivity_plus: Network connectivity
- internet_connection_checker: Internet connection

### Storage
- shared_preferences: Local storage
- flutter_secure_storage: Secure storage

### UI
- flutter_screenutil: Screen adaptation
- lottie: Animation
- cached_network_image: Cached images




## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Commit your changes
5. Push to the branch
6. Create a Pull Request

## License

This project is licensed under the MIT License.
