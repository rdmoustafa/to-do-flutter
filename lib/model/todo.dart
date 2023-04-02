class ToDo {
  String? id;
  String? todoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });
  
  //Creating an array of todo items
  static List<ToDo> todoList() {
    return [
      ToDo(id: "01", todoText: "Morning Workout", isDone: true),
      ToDo(id: "02", todoText: "Buy Bananas"),
      ToDo(id: "03", todoText: "Check emails"),
      ToDo(id: "04", todoText: "Buy birthday gift", isDone: true),
      ToDo(id: "05", todoText: "Go to dinner")
    ];
  }
}