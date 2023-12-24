import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_task_bloc/data/model/todo_entity.dart';
import 'package:todo_task_bloc/data/repository/repository.dart';

part 'note_list_event.dart';
part 'note_list_state.dart';

class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  final Repository<TaskEntity> repository;
  NoteListBloc(this.repository) : super(NoteListInitial()) {
    on<NoteListEvent>((event, emit) async {
      if (event is NoteListStarted || event is NoteListSearch) {
        final String searchTerm;
        emit(NoteListLoading());
        // await Future.delayed(const Duration(milliseconds: 200));
        if (event is NoteListSearch) {
          searchTerm = event.searchterm;
        } else {
          searchTerm = '';
        }
        try {
          final item = await repository.getAll(searchKey: searchTerm);
          if (item.isNotEmpty) {
            emit(NoteListSuccess(item));
          } else {
            emit(NoteListEmpty());
          }
        } catch (e) {
          emit(NoteListError('error = $e'));
        }
      } else if (event is NoteListDeletAll) {
        await repository.deleteAll();
        emit(NoteListEmpty());
      } else if (event is NoteListDeletId) {
        await repository.deleteById(event.id);
      }
    });
  }
}
