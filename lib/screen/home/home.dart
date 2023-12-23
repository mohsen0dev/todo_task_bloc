import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_bloc/data/model/todo_entity.dart';
import 'package:todo_task_bloc/data/repository/repository.dart';
import 'package:todo_task_bloc/screen/add/add_task.dart';
import 'package:todo_task_bloc/screen/home/bloc/note_list_bloc.dart';
import 'package:todo_task_bloc/screen/widgets/emty_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('یادداشت ها'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddTaskScreen(
                          task: TaskEntity(),
                        ))).then((value) {
              setState(() {});
            });
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: BlocProvider<NoteListBloc>(
        create: (context) =>
            NoteListBloc(context.read<Repository<TaskEntity>>()),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                const TextField(),
                Expanded(
                  child: Consumer<Repository<TaskEntity>>(
                      builder: (context, repository, child) {
                    context.read<NoteListBloc>().add(NoteListStarted());
                    return BlocBuilder<NoteListBloc, NoteListState>(
                      builder: (context, state) {
                        if (state is NoteListSuccess) {
                          return TaskListView(
                            item: state.item,
                          );
                        } else if (state is NoteListLoading ||
                            state is NoteListInitial) {
                          const Center(
                            child: CircularProgressIndicator(),
                          );

                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.green,
                          );
                        } else if (state is NoteListEmpty) {
                          return const EmptyPage();
                        } else if (state is NoteListError) {
                          return const Center(
                            child: Text('خطا در برقراری ارتباط با سرور'),
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  final List<TaskEntity> item;

  const TaskListView({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: item.length + 1,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return Row(
            children: [
              Text('تعداد کد یادداشت ها = ${item.length}'),
              // Text('تعداد کد یادداشت ها = ${MyHomePage.taskList.length}'),
              const Spacer(),
              MaterialButton(
                onPressed: () {
                  context.read<NoteListBloc>().add(NoteListDeletAll());
                },
                color: Colors.purple.shade100,
                child: const Text('حذف همه'),
              )
            ],
          );
        } else {
          var task = item[index - 1];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(
                    task: task,
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 80,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 20,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 4,
                                color: Colors.black26,
                                offset: Offset(0, 0))
                          ]),
                      margin: const EdgeInsets.only(bottom: 4, right: 2),
                      padding: const EdgeInsets.all(24),
                      child: Text(task.title),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 8, top: 4),
                    decoration: BoxDecoration(
                        color: setColor(number: task.active),
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(6),
                            topLeft: Radius.circular(6))),
                    width: 12,
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Color setColor({required int number}) {
    if (number == 1) {
      return Colors.blue;
    } else if (number == 2) {
      return Colors.red;
    } else {
      return Colors.green;
    }
  }
}

List task({
  required String description,
  required String title,
  required int active,
}) {
  return [title = title, description = description, active = active];
}
