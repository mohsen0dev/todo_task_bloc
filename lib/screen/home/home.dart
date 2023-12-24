import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_bloc/data/model/todo_entity.dart';
import 'package:todo_task_bloc/data/repository/repository.dart';
import 'package:todo_task_bloc/screen/add/add_edit_task.dart';
import 'package:todo_task_bloc/screen/add/cubit/add_edit_note_cubit.dart';
import 'package:todo_task_bloc/screen/home/bloc/note_list_bloc.dart';
import 'package:todo_task_bloc/screen/widgets/emty_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    searchController.text = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('یادداشت ها'),
        centerTitle: true,
      ),
      //! FloatingActionButton
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BlocProvider<AddEditNoteCubit>(
                  create: (context) => AddEditNoteCubit(
                      TaskEntity(), context.read<Repository<TaskEntity>>()),
                  child: const AddTaskScreen(),
                ),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: BlocProvider<NoteListBloc>(
        create: (context) {
          return NoteListBloc(context.read<Repository<TaskEntity>>());
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Column(
              children: [
                Builder(builder: (context) {
                  //! serach
                  return SearchBar(searchController: searchController);
                }),
                Expanded(
                  child: Consumer<Repository<TaskEntity>>(
                      builder: (context, repository, child) {
                    context.read<NoteListBloc>().add(NoteListStarted());
                    return BlocBuilder<NoteListBloc, NoteListState>(
                      builder: (context, state) {
                        //! show list
                        if (state is NoteListSuccess) {
                          return TaskListView(
                            item: state.item,
                          );
                          //! show loading
                        } else if (state is NoteListLoading ||
                            state is NoteListInitial) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                          //! show error
                        } else if (state is NoteListEmpty) {
                          return const EmptyPage();
                          //! show error
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

//! search
class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required this.searchController,
  });

  final TextEditingController searchController;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: TextField(
        controller: searchController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          label: Text('جستجو'),
          suffixIcon: Icon(Icons.search),
        ),
        textDirection: TextDirection.rtl,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.search,
        onChanged: (value) {
          context.read<NoteListBloc>().add(NoteListSearch(value));
        },
      ),
    );
  }
}

//! list
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
          return ItemDelete(item: item);
        } else {
          var task = item[index - 1];
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<AddEditNoteCubit>(
                    create: (context) => AddEditNoteCubit(
                        task, context.read<Repository<TaskEntity>>()),
                    child: const AddTaskScreen(),
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

//! delete and cunt task
class ItemDelete extends StatelessWidget {
  const ItemDelete({
    super.key,
    required this.item,
  });

  final List<TaskEntity> item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        children: [
          Text('تعداد کد یادداشت ها = ${item.length}'),
          const Spacer(),
          MaterialButton(
            onPressed: () {
              context.read<NoteListBloc>().add(NoteListDeletAll());
            },
            color: Colors.purple.shade100,
            child: const Text('حذف همه'),
          )
        ],
      ),
    );
  }
}
