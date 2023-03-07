import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDo extends StatelessWidget {
  final String taskName;
  final bool completed;
  // + em caso de erro, adicionei final nas duas funções abaixo
  final Function(bool?)? onChanged;
  final Function(BuildContext)? deleteFn;
  final Function(BuildContext)? updateFn;
  final double iconRadius = 12;

  // + e adicionei const no constructor
  const ToDo(
      {super.key,
      required this.taskName,
      required this.completed,
      required this.onChanged,
      required this.deleteFn,
      required this.updateFn});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 10),
        child: Slidable(
          endActionPane: ActionPane(
            motion: const StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteFn,
                icon: Icons.delete,
                backgroundColor: Colors.red.shade300,
                borderRadius: BorderRadius.circular(iconRadius),
              ),
            ],
          ),
          startActionPane: ActionPane(motion: const StretchMotion(), children: [
            SlidableAction(
              onPressed: updateFn,
              icon: Icons.update,
              backgroundColor: Colors.blue.shade300,
              borderRadius: BorderRadius.circular(iconRadius),
            )
          ]),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(12)),
            child: Row(
              children: [
                Checkbox(
                  value: completed,
                  onChanged: onChanged,
                ),
                Text(
                  taskName,
                  style: TextStyle(
                      fontSize: 17.5,
                      color: Colors.grey.shade700,
                      decoration: completed
                          ? TextDecoration.lineThrough
                          : TextDecoration.none),
                )
              ],
            ),
          ),
        ));
  }
}
