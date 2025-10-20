# GoodPlace - AI Coding Assistant Instructions

## Project Overview
GoodPlace is a Flutter habit tracking application with Firebase backend, AI-powered motivation features, and a comprehensive user experience for building and maintaining habits.

## Architecture & Code Organization

### Feature-Based Structure
- **Features are organized by domain**: `lib/features/{feature_name}/`
- **Each feature contains**: `pages/`, `widgets/`, `mixins/`, `services/`
- **Example**: `lib/features/auth/`, `lib/features/home/`, `lib/features/create habit/`

### Core Components
- **`lib/core/`**: Shared utilities, constants, extensions, and widgets
- **`lib/config/`**: App configuration (routes, theme)
- **`lib/packages/`**: Third-party package customizations

## Key Patterns & Conventions

### State Management
- **Provider Pattern**: Use `HabitProvider` for habit-related state
- **Singleton Pattern**: `HabitProvider.instance` for global access
- **ChangeNotifier**: All providers extend `ChangeNotifier` with `notifyListeners()`

### UI Development
```dart
// Context Extensions (always use these)
context.theme // Instead of Theme.of(context)
context.textTheme // Instead of Theme.of(context).textTheme
context.dynamicWidth(0.3) // Responsive width
context.navigator.pushNamed(routeName) // Navigation

// Theming
AppColors.primaryButtonColor // Use predefined colors
AppTextStyles().font() // Use Google Fonts (Rubik) wrapper
AppPaddings.smallPaddingValue // Use predefined spacing
```

### Data Models
```dart
// HabitModel follows Firestore document pattern
class HabitModel {
  // Always include fromSnapshot() and toMap() for Firestore
  factory HabitModel.fromSnapshot(DocumentSnapshot snapshot)
  Map<String, dynamic> toMap()
}
```

### Navigation
```dart
// Named routes only - defined in lib/config/routes.dart
static const String routeName = 'feature_page';
// Add to AppRoutes._routes map
'feature_page': (_) => const FeaturePage(),
```

### Firebase Integration
- **Firestore**: CRUD operations via `UserDatabaseService`
- **Auth**: Email/Google sign-in via `AuthManager`
- **Messaging**: Push notifications via `NotificationService`
- **Always handle Firebase exceptions with user-friendly toasts**

### AI Integration (OpenAI)
```dart
// Use ChatgptService for AI features
final ChatgptService chatgptService = ChatgptService();
final body = chatgptService.getApiBody(
  systemContentText: systemPrompt,
  userContentText: userMessage
);
// Handle streaming responses
chatgptService.getChatResponse(body).listen((word) { ... });
```

## Development Workflow

### Setup Requirements
1. **Firebase Configuration**: Android/iOS setup required
2. **Environment Variables**: Create `.env` with `API_KEY` and `API_URL`
3. **Dependencies**: Run `flutter pub get`

### Building & Running
```bash
flutter pub get          # Install dependencies
flutter run             # Run on connected device
flutter build apk       # Build Android APK
flutter build ios       # Build iOS app
```

### Testing
- **Unit Tests**: `flutter test` (if any exist)
- **Integration**: Manual testing with Firebase emulator
- **AI Features**: Test with valid OpenAI API credentials

## Code Style Guidelines

### Naming Conventions
- **Files**: snake_case (e.g., `habit_provider.dart`)
- **Classes**: PascalCase (e.g., `HabitProvider`)
- **Variables**: camelCase (e.g., `habitList`)
- **Constants**: SCREAMING_SNAKE_CASE in enums

### Widget Patterns
```dart
// Mixins for complex stateful widgets
mixin FeatureMixin on State<FeaturePage> {
  // Controllers, lifecycle methods, business logic
}

// Custom widgets in lib/core/utils/widgets/
class CustomButton extends StatelessWidget {
  // Consistent styling with app theme
}
```

### Error Handling
```dart
// Use Toast for user feedback
Toast.errToast(title: "Error", desc: "Something went wrong");

// Firebase operations with try-catch
try {
  await firestoreOperation();
} catch (e) {
  Toast.errToast(title: "Failed", desc: e.toString());
}
```

## Key Files to Reference

### Architecture Understanding
- `lib/main.dart`: App initialization and Provider setup
- `lib/config/routes.dart`: Navigation structure
- `lib/features/user_data/habit_provider.dart`: State management
- `lib/core/utils/models/habit_model.dart`: Data model

### UI Patterns
- `lib/core/extensions/context_extension.dart`: UI utilities
- `lib/config/theme.dart`: Colors, typography, themes
- `lib/core/constants/`: Design tokens and assets

### Feature Examples
- `lib/features/auth/`: Authentication flow
- `lib/features/home/`: Main habit dashboard
- `lib/features/AI chat/`: AI integration pattern

## Common Pitfalls to Avoid

1. **Don't bypass Provider**: Always use `HabitProvider` for habit operations
2. **Navigation**: Only use named routes, never direct MaterialPageRoute
3. **Firebase**: Always handle async operations and exceptions
4. **UI Consistency**: Use context extensions and predefined constants
5. **State Management**: Call `notifyListeners()` after state changes

## AI-Specific Guidelines

### GoodPlaceT (AI Assistant)
- **Context**: Always include user's habit data in AI prompts
- **Streaming**: Handle real-time responses for better UX
- **System Prompts**: Use predefined prompts from `SystemContentTexts`
- **Error Handling**: Graceful fallback when API unavailable

### Prompt Engineering
```dart
// Include habit context for personalized responses
String context = habitProvider.getAllHabitInformation();
// Format: "Habit title:Running,purpose:daily exercise,..."
```

## Performance Considerations

- **Provider Optimization**: Use `context.select` for specific state changes
- **List Views**: Implement proper keys and efficient rebuilding
- **Firebase**: Use real-time listeners judiciously
- **Animations**: Use `flutter_animate` for smooth transitions

## Testing Strategy

- **Manual Testing**: Primary testing method for Firebase/AI features
- **UI Testing**: Verify on multiple screen sizes
- **Integration**: Test complete user flows (auth → habit creation → tracking)
- **Edge Cases**: Network failures, invalid API responses, empty states</content>
<parameter name="filePath">/Users/dougd/GoodPlace/.github/copilot-instructions.md