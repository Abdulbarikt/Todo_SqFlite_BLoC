import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflie_bloc_/app/views/homepage/addpage.dart';
import 'package:todo_sqflie_bloc_/app/views/homepage/updatepage.dart';
import 'package:todo_sqflie_bloc_/app/views/theme/bloc/theme_bloc.dart';
import '../../bloc/todo_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoBloc>(context).add(InitailEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is EditState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UpdatePage(
                        id: state.index,
                        title: state.tittle,
                        description: state.description,
                        image: state.image,
                      )));
        }
        if (state is AddButtonState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );
        } else if (state is DeleteState) {
          BlocProvider.of<TodoBloc>(context).add(InitailEvent());
        }
      },
      builder: (context, state) {
        if (state is ImageSuccessState) {}
        if (state is LoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is AddSubmitState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Todo List',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.teal,
              actions: [
                Switch(
                    value: context.read<ThemeBloc>().state == ThemeMode.dark,
                    onChanged: (value) {
                      context.read<ThemeBloc>().add(ThemeChanged(value));
                    }),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<TodoBloc>(context).add(AddButtonEvent());
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: state.students.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    gradient: const LinearGradient(
                      colors: [Colors.indigo, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: state.students[index]['image'] != null
                          ? MemoryImage(state.students[index]['image'])
                          : null,
                      radius: 40,
                    ),
                    contentPadding: const EdgeInsets.all(16.0),
                    onTap: () {
                      BlocProvider.of<TodoBloc>(context).add(EditEvent(
                          index: state.students[index]['id'],
                          tittle: state.students[index]['title'],
                          description: state.students[index]['description'],
                          image: state.students[index]['image']));
                    },
                    title: Text(
                      state.students[index]['title'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: Colors.white, // Text color
                      ),
                    ),
                    subtitle: Text(
                      state.students[index]['description'],
                      style: const TextStyle(
                        color: Colors.white70,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        BlocProvider.of<TodoBloc>(context).add(
                          DeleteButtonEvent(
                            index: state.students[index]['id'],
                          ),
                        );
                      },
                      icon: const Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
