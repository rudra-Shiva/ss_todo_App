import 'package:flutter/material.dart';
import 'package:todo_app/common/ui/theme/app_color.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.white,
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: Center(
        child: Text('Your content goes here'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add your FAB action here
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: Material(
        color: AppColor.transparent,
        child: BottomAppBar(
          height:60 ,
color: Colors.white,
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home),
                onPressed: () {
                  // Add your action here
                },
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  // Add your action here
                },
              ),
              SizedBox(), // This creates an empty space for the FAB
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {
                  // Add your action here
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
