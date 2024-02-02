import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:todo_sqflie_bloc_/app/controller/db/db.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<UpdateButtonEvent>((event, emit) async {
      if (event.title.isNotEmpty && event.description.isNotEmpty) {
        final data = {
          "image": event.image,
          "title": event.title,
          "description": event.description,
        };
        StudentDatabase.updateData(event.index, data);
        final datalist = await StudentDatabase.getAllStudents();
        emit(AddSubmitState(students: datalist));
      }
    });
    on<InitailEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final dataList = await StudentDatabase.getAllStudents();
        emit(AddSubmitState(students: dataList));
      } catch (e) {
        emit(ErrorState());
      }
    });
    on<AddButtonEvent>((event, emit) {
      emit(AddButtonState());
    });
    on<AddSubmitEvent>((event, emit) async {
      if (event.title.isNotEmpty && event.description.isNotEmpty) {
        StudentDatabase.insertStudent(
          title: event.title,
          description: event.description,
          imageBytes: event.image,
        );
        final dataList = await StudentDatabase.getAllStudents();
        emit(AddSubmitState(students: dataList));
      }
    });
    on<DeleteButtonEvent>((event, emit) async {
      await StudentDatabase.deleteData(event.index);
      emit(DeleteState());
    });
    on<EditEvent>((event, emit) {
      emit(EditState(
          index: event.index,
          tittle: event.tittle,
          description: event.description,
          image: event.image));
    });

    on<ImageEvent>((event, emit) async {
      final imagePicker = ImagePicker();
      try {
        final pickedFile =
            await imagePicker.pickImage(source: ImageSource.gallery);
        if (pickedFile != null) {
          final bytes = await pickedFile.readAsBytes();
          emit(ImageSuccessState(image: bytes));
        } else {
          emit(ImageErrorState(error: 'No image selected.'));
        }
      } catch (e) {
        emit(ImageErrorState(error: 'Error picking image: $e'));
        print('Error picking image: $e');
      }
    });
  }
}
