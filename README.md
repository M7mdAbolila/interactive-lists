# Interactive Lists

An example Flutter app that showcases an interactive task list with reordering, swipe-to-delete, confirmation dialogs, and rich undo feedback. It is designed as a teaching/demo project for experimenting with ReorderableListView and Dismissible widgets together.

## Demo

https://github.com/user-attachments/assets/b828c0e1-1675-4e83-bc93-a541733f4cf5

## Features

- Reorder tasks with a drag handle powered by `ReorderableListView`
- Swipe to delete tasks with a confirmation dialog and undo snackbar
- Animated list state changes for empty and populated states
- Checkbox toggles to mark tasks as complete with visual feedback
- Clean widget decomposition for easy experimentation and extension

## Getting Started

1. Ensure you have the Flutter SDK (3.19 or newer recommended) installed and available on your PATH.
2. Install dependencies: `flutter pub get`
3. Run the app on an emulator or device: `flutter run`
4. Use `flutter test` to execute any automated tests you add in the future.

## Project Structure

```
lib/
|- main.dart                     # App entry point and MaterialApp setup
|- task_management/
   |- task_management_screen.dart   # Scaffold and high-level screen layout
   |- tasks_list_widget.dart        # Stateful list with reorder/delete logic
   |- task_dismissible_wrapper.dart # Swipe-to-delete wiring with confirmation
   |- task_tile_widget.dart         # Presentation for individual task rows
```

## How It Works

The `TasksListWidget` seeds a sample list of tasks and renders them inside a `ReorderableListView.builder`. Each row is wrapped in a `Dismissible` to provide swipe actions and delete confirmation. When a task is removed, the widget shows an undo `SnackBar` so users can restore the item. Basic animations via `AnimatedSwitcher` and `AnimatedBuilder` keep transitions smooth while interacting with the list.

## Customization Ideas

- Load tasks from a repository or backend instead of hardcoded sample data
- Persist task completion state with local storage or a state management solution
- Add filters or grouping (e.g., completed vs. pending tasks)
- Introduce tests for reorder and deletion behaviors using Flutter's widget testing tools

## Troubleshooting

- Run `flutter doctor` to verify your environment if you encounter build issues.
- If hot reload behaves unexpectedly, stop the current session and rerun `flutter run` to reset state.
