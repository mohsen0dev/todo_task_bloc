import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task_bloc/screen/add/cubit/add_edit_note_cubit.dart';
import 'package:todo_task_bloc/screen/widgets/textfield.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late int active = 0;

  @override
  void initState() {
    titleController = TextEditingController(
        text: context.read<AddEditNoteCubit>().state.task.title);
    descriptionController = TextEditingController(
        text: context.read<AddEditNoteCubit>().state.task.description);
    active = context.read<AddEditNoteCubit>().state.task.active;

    // if (task != null) {
    //   titleController.text = task!.title.toString();
    //   descriptionController.text = task!.description.toString();
    //   active = task!.active;
    // }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          myFloatingAction(titleController, descriptionController, context),
      appBar: AppBar(
        title: const Text('افزودت یادداشت'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            BlocBuilder<AddEditNoteCubit, AddEditNoteState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<AddEditNoteCubit>().onChangedActive(0);
                          active = 0;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.all(8),
                          height: 50,
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Colors.white,
                                value: active == 0 ? true : false,
                                onChanged: (v) {
                                  context
                                      .read<AddEditNoteCubit>()
                                      .onChangedActive(0);
                                  active = 0;
                                },
                                groupValue: true,
                              ),
                              const Text(
                                'عادی',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<AddEditNoteCubit>().onChangedActive(1);
                          active = 1;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.all(8),
                          height: 50,
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Colors.white,
                                value: active == 1 ? true : false,
                                onChanged: (v) {
                                  context
                                      .read<AddEditNoteCubit>()
                                      .onChangedActive(1);
                                  active = 1;
                                },
                                groupValue: true,
                              ),
                              const Text(
                                'متوسط',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.read<AddEditNoteCubit>().onChangedActive(2);
                          active = 2;
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12)),
                          margin: const EdgeInsets.all(8),
                          height: 50,
                          child: Row(
                            children: [
                              Radio(
                                activeColor: Colors.white,
                                value: active == 2 ? true : false,
                                onChanged: (v) {
                                  context
                                      .read<AddEditNoteCubit>()
                                      .onChangedActive(2);
                                  active = 2;
                                },
                                groupValue: true,
                              ),
                              const Text(
                                'زیاد',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            myTextfild(
              wi: MediaQuery.sizeOf(context).width,
              txtControlr: titleController,
              lablText: const Text('عنوان'),
              onChanged: (value) {
                context.read<AddEditNoteCubit>().onChangedtitle(value);
              },
            ),
            Expanded(
              child: Container(
                  margin: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      border: Border(
                    left: BorderSide(),
                    right: BorderSide(),
                    top: BorderSide(),
                  )),
                  child: TextField(
                    controller: descriptionController,
                    decoration: const InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    maxLines: null,
                    onChanged: (value) {
                      context
                          .read<AddEditNoteCubit>()
                          .onChangedtDescription(value);
                    },
                  )),
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton myFloatingAction(TextEditingController titleController,
      TextEditingController descriptionController, BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (titleController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty) {
          context.read<AddEditNoteCubit>().onSaveClick();
          // task!.title = titleController.text;
          // task!.description = descriptionController.text;
          // task!.active = active;
          // context.read<Repository<TaskEntity>>().createOrUpdate(task!);
          Navigator.pop(context);
        }
      },
      child: const Icon(
        Icons.save,
        size: 30,
      ),
    );
  }
}
