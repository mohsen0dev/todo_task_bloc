import 'package:flutter/material.dart';
import 'package:todo_task_bloc/screen/home/home.dart';
import 'package:todo_task_bloc/screen/widgets/textfield.dart';

// ignore: must_be_immutable
class AddTaskScreen extends StatefulWidget {
  final List? taskList;
  AddTaskScreen({Key? key, this.taskList}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  int active = 0;
  @override
  void initState() {
    if (widget.taskList != null) {
      widget.titleController.text = widget.taskList![0][0].toString();
      widget.descriptionController.text = widget.taskList![0][1].toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton:
          fAb(widget.titleController, widget.descriptionController, context),
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
                          value: active == 0 ? true : false,
                          onChanged: (v) {
                            setState(() {
                              active = 0;
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
                          value: active == 1 ? true : false,
                          onChanged: (v) {
                            setState(() {
                              active = 1;
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
                          value: active == 2 ? true : false,
                          onChanged: (v) {
                            setState(() {
                              active = 2;
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

  FloatingActionButton fAb(TextEditingController titleController,
      TextEditingController descriptionController, BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        if (titleController.text.isNotEmpty &&
            descriptionController.text.isNotEmpty) {
          List newTask = task(
              title: titleController.text,
              description: descriptionController.text,
              active: active);
          MyHomePage.taskList.add(newTask);
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
