part of 'add_edit_note_cubit.dart';

@immutable
sealed class AddEditNoteState {
  final TaskEntity task;

  const AddEditNoteState(this.task);
}

final class AddEditNoteInitial extends AddEditNoteState {
  const AddEditNoteInitial(super.task);
}

final class AddEditNoteChangeActive extends AddEditNoteState {
  const AddEditNoteChangeActive(super.task);
}
