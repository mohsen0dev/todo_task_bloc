import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_task_bloc/data/model/todo_entity.dart';
import 'package:todo_task_bloc/data/repository/repository.dart';
import 'package:todo_task_bloc/screen/widgets/textfield.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatefulWidget {
  final TaskEntity? task;

  AddTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  int active = 0;
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  @override
  void initState() {
    if (widget.task != null) {
      widget.titleController.text = widget.task!.title.toString();
      widget.descriptionController.text = widget.task!.description.toString();
      widget.active = widget.task!.active;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: myFloatingAction(
          widget.titleController, widget.descriptionController, context),
      appBar: AppBar(
        title: const Text('افزودت یادداشت'),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              children: [
                Expanded(
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
                          value: widget.active == 0 ? true : false,
                          onChanged: (v) {
                            setState(() {
                              widget.active = 0;
                            });
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
                Expanded(
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
                          value: widget.active == 1 ? true : false,
                          onChanged: (v) {
                            setState(() {
                              widget.active = 1;
                            });
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
                Expanded(
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
                          value: widget.active == 2 ? true : false,
                          onChanged: (v) {
                            setState(() {
                              widget.active = 2;
                            });
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
              ],
            ),
            myTextfild(
              wi: MediaQuery.sizeOf(context).width,
              txtControlr: widget.titleController,
              lablText: const Text('عنوان'),
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
                    controller: widget.descriptionController,
                    decoration: const InputDecoration(
                        border:
                            UnderlineInputBorder(borderSide: BorderSide.none)),
                    maxLines: null,
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
          widget.task!.title = titleController.text;
          widget.task!.description = descriptionController.text;
          widget.task!.active = widget.active;
          context.read<Repository<TaskEntity>>().createOrUpdate(widget.task!);
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
