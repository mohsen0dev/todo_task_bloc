import 'package:hive/hive.dart';
part 'todo_entity.g.dart';

@HiveType(typeId: 0)
class TaskEntity extends HiveObject {
  int id = -1;
  @HiveField(0)
  String title = '';
  @HiveField(1)
  String description = '';
  @HiveField(2)
  int active = 0;
}
