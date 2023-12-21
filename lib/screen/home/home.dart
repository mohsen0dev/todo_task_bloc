import 'package:flutter/material.dart';
import 'package:todo_task_bloc/screen/add/add_task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  static List taskList = [
    task(title: 'text1', description: 'body1', active: 0),
    task(title: 'text2', description: 'body2', active: 1),
    task(title: 'text3', description: 'body3', active: 2),
  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ValueNotifier<List<dynamic>> _listNotifier;
  @override
  void initState() {
    super.initState();

    _listNotifier = ValueNotifier<List<dynamic>>(MyHomePage.taskList);
  }

  @override
  Widget build(BuildContext context) {
    _listNotifier = ValueNotifier<List>(MyHomePage.taskList);
    return Scaffold(
      appBar: AppBar(
        title: const Text('یادداشت ها'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AddTaskScreen()))
                .then((value) {
              setState(() {});
            });
          },
          child: const Icon(
            Icons.add,
            size: 30,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              const TextField(),
              Row(
                children: [
                  Text('تعداد کد یادداشت ها = ${MyHomePage.taskList.length}'),
                  const Spacer(),
                  MaterialButton(
                    onPressed: () {},
                    color: Colors.purple.shade100,
                    child: const Text('حذف همه'),
                  )
                ],
              ),
              Expanded(
                child: ValueListenableBuilder<List>(
                    valueListenable: _listNotifier,
                    builder: (context, value, child) {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: MyHomePage.taskList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddTaskScreen(
                                            taskList: [
                                              MyHomePage.taskList[index]
                                            ],
                                          )));
                            },
                            child: SizedBox(
                              height: 80,
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    flex: 20,
                                    child: Container(
                                      // height: 80,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                blurRadius: 4,
                                                color: Colors.black26,
                                                offset: Offset(0, 0))
                                          ]),
                                      margin: const EdgeInsets.only(
                                          bottom: 4, right: 2),
                                      padding: const EdgeInsets.all(24),
                                      child: Text(
                                          '${MyHomePage.taskList[index][0]}'),
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.only(
                                        bottom: 8, top: 4),
                                    decoration: BoxDecoration(
                                        color: setColor(
                                            number: MyHomePage.taskList[index]
                                                [2]),
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(6),
                                            topLeft: Radius.circular(6))),
                                    width: 12,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
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
