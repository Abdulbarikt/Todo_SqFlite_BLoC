import 'dart:typed_data';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_sqflie_bloc_/app/bloc/todo_bloc.dart';
import 'package:todo_sqflie_bloc_/app/views/widgets/taskbutton.dart';
import 'package:todo_sqflie_bloc_/app/views/widgets/textfield.dart';

class AddPage extends StatelessWidget {
  AddPage({Key? key}) : super(key: key);

  TextEditingController title = TextEditingController();

  TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Uint8List? image;
    return BlocListener<TodoBloc, TodoState>(
      listener: (context, state) {
        if (state is AddSubmitState) {
          Navigator.pop(context);
        }
      },
      child: BlocBuilder<TodoBloc, TodoState>(
        builder: (context, state) {
          if (state is ImageSuccessState) {
            image = state.image;
          }
          return Scaffold(
            backgroundColor: const Color.fromARGB(255, 249, 250, 247),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 80),
                  const Center(
                    child: Text(
                      'ADD TASK',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
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
                                backgroundImage: Image.memory(state.image)
                                    .image, // Corrected line
                              )
                            : CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 70,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset('assets/camera.jpg'),
                                ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Center(
                      child: Text(
                    'Add Photo',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Task Title',
                    controller: title,
                    hint: 'Enter Task Title',
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    label: 'Description',
                    controller: description,
                    hint: 'Enter Description',
                  ),
                  const SizedBox(height: 20),
                  AddTaskButton(
                    onTap: () {
                      if (title.text.isNotEmpty &&
                          description.text.isNotEmpty) {
                        if (image != null) {
                          BlocProvider.of<TodoBloc>(context).add(
                            AddSubmitEvent(
                              title: title.text,
                              description: description.text,
                              image:
                                  image!, 
                            ),
                          );
                          title.clear();
                          description.clear();
                        }
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
