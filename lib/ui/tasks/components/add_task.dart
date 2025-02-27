import 'package:flutter/material.dart';
import 'package:hemura/ui/tasks/task_viewmodel.dart';
import 'package:hemura/utils/enums/date_operations.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key, required this.weekday});

  final String weekday;

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final _taskViewModel = TaskViewModel();

  final Map<String, String> weekMap = {
    "Segunda-Feira": "monday",
    "Terça-Feira": "tuesday",
    "Quarta-Feira": "wednesday",
    "Quinta-Feira": "thursday",
    "Sexta-Feira": "friday",
    "Sábado": "saturday",
    "Domingo": "sunday",
  };

  List<String> weekList = [
    "Segunda-Feira",
    "Terça-Feira",
    "Quarta-Feira",
    "Quinta-Feira",
    "Sexta-Feira",
    "Sábado",
    "Domingo",
  ];

  final today = DateOperations.getWeekDayPT();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedDay = DateOperations.getWeekDayPT();
  var _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    String time = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(_selectedTime, alwaysUse24HourFormat: true);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          spacing: 20,
          children: [
            Text(
              "Adicionar tarefa",
              style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: "Título",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: "Descrição",
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Dia da semana",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: DropdownButtonFormField(
                    value: today,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    items:
                        weekList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDay = value!;
                      });
                    },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Horário",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    side: WidgetStateProperty.all(
                      BorderSide(color: Theme.of(context).colorScheme.tertiary),
                    ),
                    minimumSize: WidgetStateProperty.all(Size(210, 50)),
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    TimeOfDay? newTime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                      initialEntryMode: TimePickerEntryMode.inputOnly,
                      helpText: "Selecione o horário",
                      orientation: Orientation.landscape,
                      builder: (context, child) {
                        return MediaQuery(
                          data: MediaQuery.of(
                            context,
                          ).copyWith(alwaysUse24HourFormat: true),
                          child: child!,
                        );
                      },
                    );
                    if (newTime != null) {
                      setState(() {
                        _selectedTime = newTime;
                      });
                    }
                  },
                  child: Text(
                    time,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
              onPressed: () async {
                await _taskViewModel.createTask.execute((
                  _titleController.text,
                  _descriptionController.text,
                  weekMap[_selectedDay]!.toUpperCase(),
                  time,
                ));
              },
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text("Adicionar", textAlign: TextAlign.center),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
