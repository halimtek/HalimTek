import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }
void main() => runApp(MaterialApp(
  home: Home(),
));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: Text('Halim Tek'),
      centerTitle: true,
      backgroundColor: Colors.red[600],
    ),
    body: Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () {
            print('Icon clicked');
          },
          icon: Icon(
            Icons.mail,
            color: Colors.amber,
            size: 80,
          ),
          tooltip: 'Click me',
        ),
        SizedBox(height: 8),
        Text(
          'Mail',
          style: TextStyle(fontSize: 18),
        ),
      ],
    ),
  ),

    floatingActionButton: FloatingActionButton(
      onPressed: () {
        print('wow');
      },
      backgroundColor: Colors.red[600],
      child: Text('wow'),
       tooltip: 'Floating Action Button',
    ),
  );
  }
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Halim Teknoloji',
//       theme: ThemeData(primarySwatch: Colors.blue),
//       home: MyHomePage(),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key});

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   // true => green, false => blue
//   bool _isGreen = true;

//   void _toggleColor() {
//     setState(() {
//       _isGreen = !_isGreen;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Halim Teknoloji'),
//         actions: [
//           IconButton(
//             tooltip: 'Toggle background color',
//             icon: const Icon(Icons.color_lens),
//             onPressed: _toggleColor,
//           ),
//         ],
//       ),
//       // set the scaffold background color to green or blue
//       backgroundColor: _isGreen ? Colors.green[100] : Colors.blue[100],
//       body: Center(
//         child: Text(
//           _isGreen ? 'Background: Green' : 'Background: Blue',
//           style: const TextStyle(fontSize: 18),
//         ),
//       ),
//     );
//   }
// }
