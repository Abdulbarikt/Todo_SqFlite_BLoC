// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

final class TodoInitial extends TodoState {}

class AddButtonState extends TodoState {}

class AddSubmitState extends TodoState {
  final List<Map<String, dynamic>> students;
  AddSubmitState({
    required this.students,
  });
}

class EditState extends TodoState {
  int index;
  String tittle;
  String description;
  Uint8List image;
  EditState(
      {required this.index, required this.tittle, required this.description,required this.image});
}

class ErrorState extends TodoState {}

class LoadingState extends TodoState {}

class DeleteState extends TodoState {}

class PrintState extends TodoState {}

class ImageSuccessState extends TodoState {
  final Uint8List image;

  ImageSuccessState({required this.image});
}

class ImageErrorState extends TodoState {
  String error;
  ImageErrorState({
    required this.error,
  });
}
