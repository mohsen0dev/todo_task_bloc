import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_task_bloc/data/model/todo_entity.dart';
import 'package:todo_task_bloc/data/repository/repository.dart';

part 'add_edit_note_state.dart';

class AddEditNoteCubit extends Cubit<AddEditNoteState> {
  final TaskEntity _task;
  final Repository<TaskEntity> repository;
  AddEditNoteCubit(this._task, this.repository)
      : super(AddEditNoteInitial(_task));

  void onSaveClick() {
    repository.createOrUpdate(_task);
  }

  void onChangedtitle(String title) {
    _task.title = title;
  }

  void onChangedtDescription(String description) {
    _task.description = description;
  }

  void onChangedActive(int active) {
    _task.active = active;
    emit(AddEditNoteChangeActive(_task));
  }
}
