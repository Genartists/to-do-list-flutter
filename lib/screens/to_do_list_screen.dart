import 'package:flutter/material.dart';

class Task {
  String title;
  bool isDone;

  Task({required this.title, this.isDone = false});
}

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final List<Task> _tasks = [];

  // Controller for the text field in the Add Task dialog
  final TextEditingController _textFieldController = TextEditingController();

  void _addTask(String title) {
    if (title.trim().isNotEmpty) {
      setState(() {
        _tasks.add(Task(title: title));
      });
      _textFieldController.clear(); // Clear the text field
      Navigator.pop(context); // Close the bottom sheet
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: const Text('Task title cannot be empty!'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating, // Modern look
             shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
             margin: const EdgeInsets.all(10),
            ),
      );
    }
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _tasks[index].isDone = !_tasks[index].isDone;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  // Method to show the Add Task Bottom Sheet
  void _showAddTaskSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        // Use padding to avoid keyboard overlap
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Add New Task',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.primary,
                    ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _textFieldController,
                autofocus: true, // Automatically focus the text field
                decoration: const InputDecoration(
                  hintText: 'Enter task description',
                ),
                onSubmitted: (_) => _addTask(_textFieldController.text), // Add on keyboard submit
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                // Uses ElevatedButtonTheme from main.dart
                onPressed: () => _addTask(_textFieldController.text),
                child: const Text('Add Task'),
              ),
              const SizedBox(height: 20), // Add padding at the bottom
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My To-Do List'),
      ),
      body: _tasks.isEmpty
          ? _buildEmptyState() // Show message if list is empty
          : _buildTaskList(), // Show list if tasks exist
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddTaskSheet,
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.checklist_rtl_outlined, // Suitable icon for tasks
            size: 80,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet!',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap the + button to add your first task.',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskList() {
     return ListView.builder(
        itemCount: _tasks.length,
        padding: const EdgeInsets.only(top: 10.0, bottom: 80.0), // Padding top and bottom (for FAB)
        itemBuilder: (context, index) {
          final task = _tasks[index];
          return Card(
            // Uses CardTheme from main.dart
            child: ListTile(
              // Uses ListTileTheme from main.dart
              contentPadding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              // Interactive Checkbox
              leading: Checkbox(
                // Uses CheckboxTheme from main.dart
                value: task.isDone,
                onChanged: (bool? value) {
                  _toggleTaskStatus(index);
                },
              ),
              // Task Title (strikethrough if done)
              title: Text(
                task.title,
                style: TextStyle(
                  fontSize: 16.5,
                  color: task.isDone ? Colors.grey[500] : Theme.of(context).textTheme.bodyMedium?.color,
                  decoration: task.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                   decorationColor: task.isDone ? Colors.grey[500] : null,
                   decorationThickness: 1.5,
                ),
              ),
              // Delete Button
              trailing: IconButton(
                icon: Icon(Icons.delete_outline, color: Colors.red[300]),
                tooltip: 'Delete Task',
                onPressed: () => _deleteTask(index),
                // Add splash radius for better feedback
                splashRadius: 24.0,
              ),
              onTap: () => _toggleTaskStatus(index), // Allow tapping row to toggle
            ),
          );
        },
      );
  }

  @override
  void dispose() {
    _textFieldController.dispose();
    super.dispose();
  }
}