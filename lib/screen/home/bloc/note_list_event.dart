part of 'note_list_bloc.dart';

@immutable
sealed class NoteListEvent {}

final class NoteListStarted extends NoteListEvent {}

final class NoteListSearch extends NoteListEvent {
  final String searchterm;

  NoteListSearch(this.searchterm);
}

final class NoteListDeletAll extends NoteListEvent {}

final class NoteListDeletId extends NoteListEvent {
  final int id;

  NoteListDeletId(this.id);
}
