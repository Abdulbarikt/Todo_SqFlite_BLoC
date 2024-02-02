// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_typing_uninitialized_variables
import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflie_bloc_/app/bloc/todo_bloc.dart';

class UpdatePage extends StatefulWidget {
  final id;
  final String title;
  final String description;
  final Uint8List image;
  const UpdatePage({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  }) : super(key: key);

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Uint8List image;
    title.text = widget.title;
    description.text = widget.description;

    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is AddSubmitState) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    const Center(
                      child: Text(
                        'UPDATE TASK',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<TodoBloc>(context).add(ImageEvent());
                        },
                        child: DottedBorder(
                            dashPattern: const [15, 5],
                            borderType: BorderType.Circle,
                            child: state is ImageSuccessState
                                ? CircleAvatar(
                                    radius: 70,
                                    backgroundImage: MemoryImage(state.image),
                                  )
                                : CircleAvatar(
                                    radius: 70,
                                    backgroundImage: MemoryImage(widget.image),
                                  )),
                      ),
                    ),
                    const Text(
                      'Task Title',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: title,
                      style: const TextStyle(fontSize: 16),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Enter Task Title',
                        labelStyle: const TextStyle(color: Colors.indigo),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.indigo, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Description',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: description,
                      style: const TextStyle(fontSize: 16),
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Enter Description',
                        labelStyle: const TextStyle(color: Colors.indigo),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Colors.indigo, width: 2.0),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      onTap: () {
                        Uint8List updatedImage;
                        if (state is ImageSuccessState) {
                          updatedImage = state.image;

                          BlocProvider.of<TodoBloc>(context).add(
                            UpdateButtonEvent(
                              image: updatedImage,
                              index: widget.id,
                              title: title.text,
                              description: description.text,
                            ),
                          );
                        }
                      },
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        width: double.infinity,
                        child: const Center(
                          child: Text(
                            'Add Task',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
