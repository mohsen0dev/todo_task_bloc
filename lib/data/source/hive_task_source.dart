import 'package:hive/hive.dart';
import 'package:todo_task_bloc/data/model/todo_entity.dart';
import 'package:todo_task_bloc/data/source/source.dart';

class HiveTaskDataSource implements DataSource<TaskEntity> {
  final Box<TaskEntity> box;

  HiveTaskDataSource({required this.box});
  @override
  Future<TaskEntity> createOrUpdate(TaskEntity data) async {
    if (data.isInBox) {
      data.save();
    } else {
      data.id = await box.add(data);
    }
    return data;
  }

  @override
  Future<void> delete(TaskEntity data) async {
    return await data.delete();
  }

  @override
  Future<void> deleteAll() {
    return box.clear();
  }

  @override
  Future<void> deleteById(id) async {
    await box.delete(id);
  }

  @override
  Future<TaskEntity> findById(id) async {
    //! return box.get(id)!;
    return box.values.firstWhere((element) => element.id == id);
  }

  @override
  Future<List<TaskEntity>> getAll({String searchKey = ''}) async {
    if (searchKey.isEmpty) {
      return box.values.toList();
    } else {
      return box.values
          .where((element) => element.title.contains(searchKey))
          .toList();
    }
  }
}
