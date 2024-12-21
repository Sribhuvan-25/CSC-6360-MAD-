import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)? onClicked;
  Function(BuildContext?)? deleteTask;

  TodoTile({
    super.key,
    required this.onClicked,
    required this.taskCompleted,
    required this.taskName,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 25),
        child: Slidable(
          endActionPane: ActionPane(
            motion: StretchMotion(),
            children: [
              SlidableAction(
                onPressed: deleteTask,
                icon: Icons.delete,
                backgroundColor: Colors.grey.shade800,
                borderRadius: BorderRadius.circular(12),
              )
            ],
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.grey.shade500,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Checkbox(
                  value: taskCompleted,
                  onChanged: onClicked,
                  activeColor: Colors.blueGrey.shade400,
                ),
                Text(taskName,
                    style: TextStyle(
                        decoration: taskCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none)),
              ],
            ),
          ),
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class TodoTile extends StatelessWidget {
//   final String taskName;
//   final bool taskCompleted;
//   final Function(bool?)? onClicked;
//   final Function(BuildContext?)? deleteTask;
//   final VoidCallback? onTileTap; // Add this line

//   TodoTile({
//     Key? key, // Add 'key' parameter here
//     required this.onClicked,
//     required this.taskCompleted,
//     required this.taskName,
//     required this.deleteTask,
//     required this.onTileTap, // Add this line
//   }) : super(key: key); // Use 'key' parameter here

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTileTap,
//       child: Padding(
//         padding: EdgeInsets.only(left: 25, right: 25, top: 25),
//         child: Slidable(
//           endActionPane: ActionPane(
//             motion: StretchMotion(),
//             children: [
//               SlidableAction(
//                 onPressed: deleteTask,
//                 icon: Icons.delete,
//                 backgroundColor: Colors.grey.shade800,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ],
//           ),
//           child: Container(
//             padding: EdgeInsets.all(24),
//             decoration: BoxDecoration(
//               color: Colors.grey.shade500,
//               borderRadius: BorderRadius.circular(12),
//             ),
//             child: Row(
//               children: [
//                 Checkbox(
//                   value: taskCompleted,
//                   onChanged: onClicked,
//                   activeColor: Colors.blueGrey.shade400,
//                 ),
//                 Text(
//                   taskName,
//                   style: TextStyle(
//                     decoration: taskCompleted
//                         ? TextDecoration.lineThrough
//                         : TextDecoration.none,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
