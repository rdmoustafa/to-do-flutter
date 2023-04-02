import 'package:flutter/material.dart';
import 'package:to_do/widgets/todo_item.dart';

import '../constants/colors.dart';
import '../model/todo.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];

  //Create a controller for the text editor
  final _todoController = TextEditingController();

  @override
  void initState() {
    //This is what i'm using as default/initial state - what I'm fetching
    _foundToDo = todosList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBG, // Setting the background of the app itself
      appBar: _buildAppBar(),
      body: Stack(children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          //This is creating padding for this container
          child: Column(
            children: [
              //Creating the search bar container
              searchBox(),
              //MUST wrap listview with another widget, which in this case is expanded - if it's just listview it will give an error
              //Expanded is a widget that means it's child will take up all the space it can
              Expanded(
                  child: ListView(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50, bottom: 20),
                    child: const Text(
                      "All Things To Do",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
                    ),
                  ),
                  // Looping through a list
                  for (ToDo item in _foundToDo)
                    ToDoItem(
                      todoItem: item,
                      onToDoChanged: _handleToDoChange,
                      onDeleteToDo: _handleDeleteToDo,
                    )
                ],
              ))
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                margin: EdgeInsets.only(bottom: 20, right: 20, left: 20),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 0),
                        blurRadius: 10.0,
                        spreadRadius: 0)
                  ],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  //This is how it knows it's controller
                  controller: _todoController,
                  decoration: InputDecoration(
                      hintText: "Add a new task to do",
                      border: InputBorder.none),
                ),
              )),
              Container(
                margin: EdgeInsets.only(bottom: 20, right: 20),
                child: ElevatedButton(
                  child: Text(
                    "+",
                    style: TextStyle(fontSize: 40),
                  ),
                  onPressed: () {
                    _handleAddToDo(_todoController.text);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: tdBlue, // primary is deprecated
                      minimumSize: Size(60, 60),
                      elevation: 10),
                ),
              )
            ],
          ),
        )
      ]),
    );
  }

  void _runFilter(String enteredWord) {
    List<ToDo> results = [];
    if (enteredWord.isEmpty) {
      results = todosList;
    } else {
      results = todosList
          .where((element) => element.todoText!
              .toLowerCase()
              .contains(enteredWord.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  void _handleAddToDo(String text) {
    setState(() {
      ToDo newItem = ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(), todoText: text);
      todosList.add(newItem);
    });
    //To clear the text box
    _todoController.clear();
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _handleDeleteToDo(String id) {
    setState(() {
      todosList.removeWhere((element) => element.id == id);
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20)),
      //Creating the text field in the search bar
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.all(0),
            // Icon at the begining of this text field
            prefixIcon: Icon(
              Icons.search,
              color: tdBlack,
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, minWidth: 25),
            border: InputBorder.none,
            hintText: "Search",
            hintStyle: TextStyle(color: tdGrey)),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBG,
      elevation: 0,
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Icon(
          Icons.menu,
          color: tdBlack,
          size: 30,
        ),
        Container(
          height: 40,
          width: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset('assets/images/avatar.jpeg'),
          ),
        )
      ]),
    );
  }
}
