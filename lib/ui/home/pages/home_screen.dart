import 'package:flutter/material.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/ui/home/components/home_drawer.dart';
import 'package:hemura/ui/home/components/home_page.dart';
import 'package:hemura/ui/tasks/components/add_task.dart';
import 'package:hemura/ui/tasks/task_screen.dart';
import 'package:hemura/utils/enums/date_operations.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({required this.sessionEntity, super.key});

  final SessionEntity sessionEntity;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    final String weekday = DateOperations.getWeekDayENG();
    final List<Widget> widgets = [
      HomePage(sessionEntity: widget.sessionEntity),
      TaskScreen(),
      Container(),
      AddTask(weekday: weekday,),
    ];
    return Scaffold(
      drawer: HomeDrawer(sessionEntity: widget.sessionEntity),
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("Hemura"),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.person))],
      ),
      body: widgets[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: "Calendário",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Configurações",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Adicionar",
          ),
        ],
      ),
    );
  }
}
