import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/database_helper.dart';
import 'package:todo_app/login_page.dart';
import 'package:todo_app/todo_model.dart';
import 'package:intl/intl.dart';
void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class AdvanceTODO extends StatefulWidget {
  const AdvanceTODO({super.key});

  @override
  State createState() => _AdvanceTODOState();
}


class _AdvanceTODOState extends State {

  late DatabaseHelper _databaseHelper;
  late TextEditingController titleController;
  late TextEditingController contentController;
  late TextEditingController dateController;
  late List<Todo> tasks;

  @override
  void initState() {
    super.initState();
    initDB();
    titleController = TextEditingController();
    contentController = TextEditingController();
    dateController = TextEditingController();
    tasks = [];
    _fetchTasks();
  }

  Future<void> initDB()async{
     _databaseHelper = DatabaseHelper();
    await _databaseHelper.initializeDatabase();
  }

  Future<void> _fetchTasks() async {
    final List<Todo> todoList = await _databaseHelper.getAllTodos();
    setState(() {
      tasks = todoList;
    });
  }

  bool isEditTask = false;

  List colorList = const [
    Color.fromRGBO(253, 181, 181, 1),
    Color.fromRGBO(160, 187, 255, 1),
    Color.fromRGBO(253, 249, 177, 1),
    Color.fromRGBO(237, 166, 237, 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(197, 115, 89, 244),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 30,
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
              top: 50,
            ),
            child: Text(
              "Good Morning",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(
              left: 20,
            ),
            child: Text(
              "Anuj",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              height: 600,
              width: 500,
              // color: Colors.grey,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(217, 217, 217, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Create ToDo List",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: Container(
                      // color: colorList[index % colorList.length],
                      padding: const EdgeInsets.only(top: 0),
                      decoration: const BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 1),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30))),
                      child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            return Slidable(
                              actionPane: const SlidableDrawerActionPane(),
                              secondaryActions: [
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle
                                  ),
                                  child: IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () {
                                      _deleteTask(index);
                                    },
                                  ),
                                ),
                                Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: IconSlideAction(
                                    caption: 'Edit',
                                    color: Colors.blue,
                                    icon: Icons.edit,
                                    onTap: () {
                                      isEditTask = true;
                                      showModalmyBottomSheet(index);
                                    },
                                  ),
                                ),
                              ],
                              child: Container(
                                padding: const EdgeInsets.only(top: 0),
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: colorList[index % colorList.length],
                                ),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      height: 50,
                                      width: 50,
                                      // decoration: const BoxDecoration(
                                      //   shape: BoxShape.circle,
                                      // ),
                                      child: Image.asset(
                                          "assets/images/todolist.png"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          tasks[index].title,
                                          style: const TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          tasks[index].content,
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          tasks[index].date,
                                          style: const TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    const Column(
                                      children: [
                                        Padding(
                                            padding: EdgeInsets.only(right: 100)),
                                        Icon(
                                          Icons.check_box,
                                          color: Colors.green,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 99, 183, 252),
        onPressed: () {
          showModalmyBottomSheet(null);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _editTask(int index) async {
    final editedTodo = Todo(
      id: tasks[index].id,
      title: titleController.text,
      content: contentController.text,
      date: dateController.text,
    );
    await _databaseHelper.updateTodo(editedTodo);
    _fetchTasks();
  }

   Future<void> _deleteTask(int index) async {
    await _databaseHelper.deleteTodo(tasks[index].id!);
    _fetchTasks();
  }

  Future<void> _addTask() async {
    final newTodo = Todo(
      title: titleController.text,
      content: contentController.text,
      date: dateController.text,
    );
    await _databaseHelper.insertTodo(newTodo);
    _fetchTasks();
    titleController.clear();
    contentController.clear();
    dateController.clear();
  }

  void showModalmyBottomSheet(int? index) {
    if (isEditTask == true && index != null) {
      titleController.text = tasks[index].title;
      contentController.text = tasks[index].content;
      dateController.text = tasks[index].date;

      isEditTask = true;
    } else {
      titleController.clear();
      contentController.clear();
      dateController.clear();

      isEditTask = false;
    }
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Create Task",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: titleController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText: "Title",
                        hintText: "Enter Title"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Title";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: contentController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Content",
                      hintText: "Enter Content",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Content";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: dateController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                      labelText: "Date",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter Date";
                      } else {
                        return null;
                      }
                    },
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2024),
                          lastDate: DateTime(2025));
                      String formatedDate =
                          DateFormat.yMMMd().format(pickedDate!);
                      setState(() {
                        dateController.text = formatedDate;
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.yellow)),
                      onPressed: () {
                        if (isEditTask == true) {
                          _editTask(index!);
                          isEditTask = false;
                        } else {
                          _addTask();
                        }
                        titleController.clear();
                        contentController.clear();
                        dateController.clear();
                        Navigator.pop(context);
                      },
                      child: const Text("Add Task"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

