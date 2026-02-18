# Task Collab App

A comprehensive real-time task collaboration application built with Flutter, following Clean Architecture and SOLID principles.

## 🚀 Features Overview

### 🔐 Authentication
- **Secure Login & Registration**: Implemented with Firebase Authentication.
- **Session Management**: Handles session expiry, auto-login, and secure token storage.
- **Clean Architecture**: Uses `AuthBloc` for state management and `AuthRepository` for data handling.
- **Error Handling**: Custom `AuthFailure` union types for granular error feedback (e.g., weak password, email in use).

### 📁 Project Management
- **Dashboard**: View, create, update, and delete projects.
- **Real-time Updates**: Projects sync in real-time using Cloud Firestore streams.
- **Member Management**: Add members to projects by searching for existing users.

### 📋 Task Management (Kanban Board)
- **Kanban Board**: Visualize tasks across statuses (To Do, In Progress, Review, Done).
- **Task Details**: Create and edit tasks with title, description, due date, priority, and assignees.
- **Filtering**: Filter tasks by assignee or other criteria.
- **Drag & Drop**: (Implied, or future feature for Kanban) Manage task workflow effortlessly.

### 🔔 Notifications
- **Push Notifications**: Integrated `firebase_messaging` for remote notifications.
- **Local Notifications**: `flutter_local_notifications` for foreground alerts and deep linking.
- **Smart Routing**: Tapping a notification navigates directly to the relevant Project or Task board.

### 👤 User & Profile
- **User Search**: Find users by email or name to add to projects.
- **Profile Management**: (In progress) View and update user details.

## 🛠 Tech Stack

- **Framework**: [Flutter](https://flutter.dev/)
- **State Management**: [flutter_bloc](https://pub.dev/packages/flutter_bloc)
- **Dependency Injection**: [get_it](https://pub.dev/packages/get_it) & [injectable](https://pub.dev/packages/injectable)
- **Data Class Generation**: [freezed](https://pub.dev/packages/freezed) & [json_serializable](https://pub.dev/packages/json_serializable)
- **Functional Programming**: [dartz](https://pub.dev/packages/dartz) (Either type for error handling)

### Firebase Services
- **Authentication**: `firebase_auth`
- **Database**: `cloud_firestore`
- **Cloud Messaging**: `firebase_messaging`

## fq Clean Architecture Structure

The project follows a standard Clean Architecture folder structure:

```
lib/
├── core/                   # Core utilities, errors, and DI setup
├── features/
│   ├── auth/               # Authentication feature (Login, Register)
│   ├── projects/           # Project management (Dashboard, CRUD)
│   ├── tasks/              # Task management (Kanban, Details)
│   ├── users/              # User search and management
│   ├── notifications/      # Notification services
│   └── profile/            # User profile settings
└── main.dart               # App entry point
```

Each feature is divided into:
- **Presentation**: BLoCs, Pages, Widgets.
- **Domain**: Entities, UseCases, Repository Interfaces.
- **Data**: Models, DataSources, Repository Implementations.

## 📦 Key Libraries

- `equatable`: Value equality for BLoC states.
- `flutter_secure_storage`: Securely storing session tokens.
- `rxdart`: Reactive programming extensions.
- `google_fonts`: Project typography.

## 🔧 Setup & Installation

1.  **Clone the repository**.
2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
3.  **Code Generation**:
    Run component generation for Freezed/JsonSerializable:
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
4.  **Firebase Configuration**:
    Ensure `firebase_options.dart` is configured for your project.
5.  **Run the App**:
    ```bash
    flutter run
    ```
