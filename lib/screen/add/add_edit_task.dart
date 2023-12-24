import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task_bloc/screen/add/cubit/add_edit_note_cubit.dart';
import 'package:todo_task_bloc/screen/widgets/textfield.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    titleController = TextEditingController(
        text: context.read<AddEditNoteCubit>().state.task.title);
    descriptionController = TextEditingController(
        text: context.read<AddEditNoteCubit>().state.task.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      //! floating action
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
            //! active bar
            const ActiveItem(),
            //! title
            myTextfild(
              wi: MediaQuery.sizeOf(context).width,
              txtControlr: titleController,
              lablText: const Text('عنوان'),
              onChanged: (value) {
                context.read<AddEditNoteCubit>().onChangedtitle(value);
              },
            ),
            //! description
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

//! floating action
  FloatingActionButton myFloatingAction(TextEditingController titleController,
      TextEditingController descriptionController, BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (titleController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty) {
          context.read<AddEditNoteCubit>().onSaveClick();
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

//! active bar
class ActiveItem extends StatelessWidget {
  const ActiveItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddEditNoteCubit, AddEditNoteState>(
      builder: (context, state) {
        late int isActive = state.task.active;
        return Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  context.read<AddEditNoteCubit>().onChangedActive(0);
                  isActive = 0;
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
                        value: isActive == 0 ? true : false,
                        onChanged: (v) {
                          context.read<AddEditNoteCubit>().onChangedActive(0);
                          isActive = 0;
                        },
                        groupValue: true,
                      ),
                      const Text(
                        'عادی',
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
                  isActive = 1;
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
                        value: isActive == 1 ? true : false,
                        onChanged: (v) {
                          context.read<AddEditNoteCubit>().onChangedActive(1);
                          isActive = 1;
                        },
                        groupValue: true,
                      ),
                      const Text(
                        'متوسط',
                        style: TextStyle(fontSize: 18, color: Colors.white),
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
                  isActive = 2;
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
                        value: isActive == 2 ? true : false,
                        onChanged: (v) {
                          context.read<AddEditNoteCubit>().onChangedActive(2);
                          isActive = 2;
                        },
                        groupValue: true,
                      ),
                      const Text(
                        'زیاد',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
