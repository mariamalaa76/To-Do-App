import 'package:flutter/cupertino.dart';
import 'package:to_do_list/modules/archived_tasks/archived_tasks_screen.dart';
import 'package:to_do_list/modules/done_tasks/done_tasks_screen.dart';
import 'package:to_do_list/modules/new_tasks/new_tasks_screen.dart';

List<Widget> screens = [
  const NewTasksScreen(),
  const DoneTasksScreen(),
  const ArchivedTasksScreen(),
];

List<String> titles =
[
  'New Tasks',
  'Done Tasks',
  'Archived Tasks'
];

