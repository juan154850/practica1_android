import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoItem {
  String task;
  DateTime date;

  TodoItem({required this.task, required this.date});
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  final List<TodoItem> _todoItems = [];

  String _dateConverter(DateTime newDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String _dateFormatted = formatter.format(newDate);
    return _dateFormatted;
  }

  String buttonMsg = "Fecha";
  DateTime _data = DateTime.now();

  void _showSelectedDate(StateSetter setState) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900, 1),
      lastDate: DateTime(2100, 1),
      helpText: "Fecha",
    );
    if (newDate != null) {
      setState(() {
        _data = newDate;
        buttonMsg = "Fecha: ${_dateConverter(_data)}";
      });
    }
  }

  void _addTodoItem(String task) {
    setState(() {
      _todoItems.add(TodoItem(task: task, date: _data));  // Guardar el recordatorio con la fecha seleccionada
    });
  }

  void _removeTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptAddTodoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _textFieldController = TextEditingController();
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Nuevo Recordatorio'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _textFieldController,
                    decoration: InputDecoration(hintText: 'Escribe tu recordatorio'),
                  ),
                  ElevatedButton(
                    child: Text(buttonMsg),
                    onPressed: () {
                      _showSelectedDate(setState);
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancelar'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Añadir'),
                  onPressed: () {
                    _addTodoItem(_textFieldController.text);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Recordatorios'),
      ),
      body: ListView.builder(
        itemCount: _todoItems.length,
        itemBuilder: (context, index) {
          return Dismissible(
            key: Key(_todoItems[index].task),
            background: Container(color: Colors.red),
            onDismissed: (direction) {
              _removeTodoItem(index);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Recordatorio eliminado')),
              );
            },
            child: ListTile(
              title: Text(_todoItems[index].task),
              subtitle: Text("Fecha: ${_dateConverter(_todoItems[index].date)}"), // Mostrar la fecha
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Añadir Recordatorio',
        child: Icon(Icons.add),
      ),
    );
  }
}
