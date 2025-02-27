import 'package:flutter/material.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/ui/home/components/today_tasks.dart';

class HomePage extends StatefulWidget {
  const HomePage({required this.sessionEntity, super.key});
  final SessionEntity sessionEntity;


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [TodayTasks(sessionEntity: widget.sessionEntity,)],
    );
  }
}
