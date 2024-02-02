import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflie_bloc_/app/bloc/todo_bloc.dart';
import 'package:todo_sqflie_bloc_/app/views/homepage/hompage.dart';
import 'package:todo_sqflie_bloc_/app/views/theme/bloc/theme_bloc.dart';
import 'package:todo_sqflie_bloc_/app/views/theme/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ThemeBloc(),
        ),
        BlocProvider(
          create: (context) => TodoBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeMode>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: state,
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
