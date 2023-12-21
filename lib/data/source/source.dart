//crud

import 'package:todo_task_bloc/data/model/todo_entity.dart';

abstract class DataSource<T> {
  Future<T> createOrUpdate(T data);
  Future<T> findById(dynamic id);
  Future<List<T>> getAll({String searchKey});
  Future<void> deleteAll();
  Future<void> delete(T data);
  Future<void> deleteById(dynamic id);
}
