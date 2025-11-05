import 'package:flutter/material.dart';

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
