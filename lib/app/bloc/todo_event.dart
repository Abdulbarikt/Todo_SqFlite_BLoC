// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

@immutable
class TodoEvent {}

class InitailEvent extends TodoEvent {}

class AddButtonEvent extends TodoEvent {}

class AddSubmitEvent extends TodoEvent {
  final String title;
  final String description;
  Uint8List image;
  AddSubmitEvent({
    required this.title,
    required this.description,
    required this.image,
  });
}

class DeleteButtonEvent extends TodoEvent {
  final int index;
  DeleteButtonEvent({
    required this.index,
  });
}

class EditEvent extends TodoEvent {
  int index;
  String tittle;
  String description;
  Uint8List image;
  EditEvent(
      {required this.index,
      required this.tittle,
      required this.description,
      required this.image});
}

class UpdateButtonEvent extends TodoEvent {
  int index;
  final String title;
  final String description;
  final Uint8List image;

  UpdateButtonEvent(
      {required this.index,
      required this.title,
      required this.description,
      required this.image});
}

class ImageEvent extends TodoEvent {}
