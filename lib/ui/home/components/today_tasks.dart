import 'package:flutter/material.dart';
import 'package:hemura/domain/session_entity.dart';
import 'package:hemura/domain/task_entity.dart';
import 'package:hemura/ui/home/components/filter_dialog.dart';
import 'package:hemura/ui/tasks/task_viewmodel.dart';
import 'package:hemura/utils/enums/date_operations.dart';
import 'package:intl/intl.dart';

class TodayTasks extends StatefulWidget {
  const TodayTasks({required this.sessionEntity, super.key});

  final SessionEntity sessionEntity;

  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  String weekDay = DateOperations.getWeekDayPT();
  String weekDayEng = DateOperations.getWeekDayENG();

  final _taskViewModel = TaskViewModel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              weekDay,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
          ListenableBuilder(
            listenable: _taskViewModel.getTasksByWeekday,
            builder: (context, child) {
              if (_taskViewModel.getTasksByWeekday.running) {
                return Center(child: CircularProgressIndicator());
              }
              if (_taskViewModel.getTasksByWeekday.error) {
                return Center(child: Text("Erro ao buscar tarefas"));
              }
              if (_taskViewModel.getTasksByWeekday.completed) {
                List<TaskEntity> tasks = _taskViewModel.taskList;
                final DateFormat timeFormat = DateFormat("HH:mm:ss");
                List<TaskEntity> todayTasks =
                tasks
                    .where((task) => task.weekDay == weekDayEng.toUpperCase())
                    .toList();
                todayTasks.sort((a, b) => a.time.compareTo(b.time));
                todayTasks.removeWhere((task) {
                  DateTime taskTime = timeFormat.parse(task.time);
                  DateTime now = DateTime.now();
                  DateTime taskDateTime = DateTime(now.year, now.month, now.day, taskTime.hour + 1, taskTime.minute, taskTime.second);
                  return now.isAfter(taskDateTime);
                });

                Map<String, List<TaskEntity>> groupedTasks = {};
                for (var task in todayTasks) {
                  if (!groupedTasks.containsKey(task.time)) {
                    groupedTasks[task.time] = [];
                  }
                  groupedTasks[task.time]!.add(task);
                }
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tarefas restantes",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          todayTasks.length.toString(),
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 550,
                      child: ListView.builder(
                        physics: ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: groupedTasks.length,
                        itemBuilder: (context, index) {
                          String time = groupedTasks.keys.elementAt(index);
                          List<TaskEntity> tasksAtTime = groupedTasks[time]!;
                          return Column(
                            spacing: 10,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                time.replaceRange(4, 7, ""),
                                style: Theme.of(
                                  context,
                                ).textTheme.titleLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              ...tasksAtTime.map(
                                    (task) => Container(
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.onPrimary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ListTile(
                                    title: Text(
                                      task.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleMedium!.copyWith(
                                        color: Theme.of(context).colorScheme.primary,
                                      ),
                                    ),
                                    subtitle: Text(
                                      task.description,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall!.copyWith(
                                        color:
                                        Theme.of(
                                          context,
                                        ).colorScheme.onPrimaryContainer,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(color: Theme.of(context).colorScheme.tertiary),
                              SizedBox(height: 10),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}
