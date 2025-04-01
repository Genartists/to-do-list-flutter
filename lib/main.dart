import 'package:flutter/material.dart';
import 'screens/to_do_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter To-Do List',
      debugShowCheckedModeBanner: false, 
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal, 
          brightness: Brightness.light, 
        ),

        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal, 
          foregroundColor: Colors.white, 
          elevation: 2.0, // Subtle shadow
          titleTextStyle: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600, 
            color: Colors.white, 
          ),
          centerTitle: true, 
        ),

        // Style for Floating Action Button
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal[700],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          elevation: 4.0,
        ),

        // Style for Elevated Buttons (used in Add Task)
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, 
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // Style for Cards (our To-Do items)
        cardTheme: CardTheme(
          elevation: 2.0, // Subtle shadow
          margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          clipBehavior: Clip.antiAlias, 
        ),

        // Style for ListTiles within Cards
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(15.0), 
          ),
           iconColor: Colors.teal[600],
        ),

        // Style for Checkboxes
         checkboxTheme: CheckboxThemeData(
           fillColor: MaterialStateProperty.resolveWith((states) {
             if (states.contains(MaterialState.selected)) {
               return Colors.teal; // Color when checked
             }
             return Colors.grey[400]; // Color when unchecked
           }),
           checkColor: MaterialStateProperty.all(Colors.white), // Color of the check mark
           shape: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(4.0), // Slightly rounded checkbox
           ),
         ),

        textTheme: const TextTheme(
          titleLarge: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(fontSize: 16.0),
          // Define other text styles as needed
        ),

        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.grey[400]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
          ),
          filled: true,
          fillColor: Colors.grey[50]?.withOpacity(0.5),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
        ),
      ),
      home: const TodoListScreen(),
    );
  }
}