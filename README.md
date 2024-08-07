# To-Do List App

## How to Run the App

To get a local copy up and running, follow these simple steps:

1. Open your terminal.

2. Clone the repository:

   git clone https://github.com/Prathapexplr/To-Do.git

3. Navigate to the project directory:

   cd todo

4. Install the Flutter dependencies:

   flutter pub get

5. Run the App:

   flutter run

6. Run all the Tests:

   flutter test

## Introduction

This is a simple To-Do List application built using Flutter. The app demonstrates the use of BLoC for state management and adheres to clean architecture principles.

## Features

- Add a new task
- Mark a task as completed
- Delete a task
- Filter tasks by all, completed, and pending

## App Functionality

- **Adding a Task:** On the Home screen, click on the floating "+" icon. An "ADD NEW TASK" popup will appear. Enter the required task in the TextField and click on the "ADD" button. This will add the task to the list, which includes a checkbox, task description, and a delete icon.
  
- **Completing a Task:** Tick the checkbox next to a task to mark it as completed.
  
- **Deleting a Task:** Click on the delete icon next to a task to delete it.
  
- **Filtering Tasks:** Use the filter option on the top of the app bar to display Completed, Pending, or All tasks.

## Architecture

The app is structured using clean architecture principles, separating it into the following layers:

- **Presentation Layer:** Contains UI code and BLoC for state management.
- **Domain Layer:** Contains business logic and entities.
- **Data Layer:** Contains data models and repository implementations.

## State Management

The app uses BLoC (Business Logic Component) for managing state. Each feature has its own BLoC.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- You have installed [Flutter](https://flutter.dev/docs/get-started/install) on your machine.
- You are using a machine running on one of the following operating systems: Windows, macOS, Linux.
- You have a code editor like [Visual Studio Code](https://code.visualstudio.com/) or [Android Studio](https://developer.android.com/studio) set up for Flutter development.

## Testing

The app includes:

- Unit tests for the business logic.
- Widget tests for the UI components.
- Tests that cover the core functionalities of the app.

## Project Structure

Here's a brief overview of the project structure following clean architecture principles:

- **lib**
  - **data**: Contains data models and repository implementations.
  - **domain**: Contains business logic and entities.
  - **presentation**: Contains UI code and BLoC for state management.
  - **main.dart**: The entry point of the application.

## Versions Used

- Flutter SDK: 3.16.9
- Dart SDK: 3.2.6 (Flutter)
