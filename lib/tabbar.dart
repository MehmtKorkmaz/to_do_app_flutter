import 'package:flutter/material.dart';

class TabBarView1 extends StatefulWidget {
  const TabBarView1({super.key});

  @override
  State<TabBarView1> createState() => _TabBarView1State();
}

class _TabBarView1State extends State<TabBarView1> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        body: const Column(
          children: [
            TabBar(tabs: [
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.home),
              ),
              Tab(
                icon: Icon(Icons.home),
              )
            ]),
          ],
        ),
      ),
    );
  }
}
