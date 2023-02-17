// import 'package:flutter/material.dart';
// import 'package:webapp/components/constants/background.dart';

// class DragAndDrop extends StatefulWidget {
//   const DragAndDrop({Key? key}) : super(key: key);

//   @override
//   State<DragAndDrop> createState() => _DragAndDropState();
// }

// class _DragAndDropState extends State<DragAndDrop> {
//   bool insideTarget = false;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           DragTarget<String>(
//             builder: (context, candidateData, rejectedData) {
//               return Container(
//                   height: 200.0,
//                   width: 800.0,
//                   color: myAppBarColor,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: const [
//                       Icon(Icons.cloud_upload,
//                           size: 80, color: Color.fromARGB(255, 80, 200, 255)),
//                       Text('Drop Files',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Color.fromARGB(255, 80, 200, 255),
//                               fontSize: 24)),
//                     ],
//                   ));
//             },
//             onAccept: ((data) {
//               setState(() {
//                 insideTarget = true;
//               });
//             }),
//           ),
//           const MyFiles(boxIcon: 'Icon', boxColor: Colors.red)
//         ],
//       ),
//     );
//   }
// }

// class MyFiles extends StatelessWidget {
//   final String boxIcon;
//   final Color boxColor;

//   const MyFiles({Key? key, required this.boxIcon, required this.boxColor})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Draggable(
//       data: boxIcon,
//       feedback: Container(height: 120.0, width: 120.0, color: Colors.yellow),
//       childWhenDragging: Container(
//         height: 120.0,
//         width: 120.0,
//         color: Colors.grey,
//       ),
//       child: Container(height: 120.0, width: 120.0, color: boxColor),
//     );
//   }
// }
