part of 'note_list_bloc.dart';

@immutable
sealed class NoteListState {}

final class NoteListInitial extends NoteListState {}

final class NoteListLoading extends NoteListState {}

final class NoteListEmpty extends NoteListState {}

final class NoteListError extends NoteListState {
  final String errorMessage;

  NoteListError(this.errorMessage);
}

final class NoteListSuccess extends NoteListState {
  final List<TaskEntity> item;

  NoteListSuccess(this.item);
}
