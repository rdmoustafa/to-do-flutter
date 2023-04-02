import 'package:flutter/material.dart';

import '../constants/colors.dart';
import '../model/todo.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todoItem;
  final onToDoChanged;
  final onDeleteToDo;

  const ToDoItem({Key? key, required this.todoItem, required this.onToDoChanged, required this.onDeleteToDo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ListTile(
        onTap: () {
          print("Clicked an item :)");
          onToDoChanged(todoItem);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: Colors.white,
        leading: todoItem.isDone
            ? const Icon(Icons.check_box, color: tdBlue)
            : const Icon(Icons.check_box_outline_blank),
        title: Text(
          //The exclamation point is because the type of todoText is String? as it might be null
          //FIXME there is no null checking
          todoItem.todoText!,
          style: TextStyle(
              fontSize: 16,
              color: tdBlack,
              decoration: todoItem.isDone ? TextDecoration.lineThrough : null
          ),
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          //We have a container so that we can design and style the area/box part
          height: 35,
          width: 35,
          decoration: BoxDecoration(
              color: tdRed, borderRadius: BorderRadius.circular(5)),
          child: IconButton(
            color: Colors.white,
            iconSize: 18,
            icon: Icon(Icons.delete),
            onPressed: () {
              // print("Deleting");
              onDeleteToDo(todoItem.id);
            },
          ),
        ),
      ),
    );
  }
}
