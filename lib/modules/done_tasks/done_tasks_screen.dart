import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/cubit/cubit.dart';
import 'package:to_do_list/cubit/states.dart';
import 'package:to_do_list/shared/components/components.dart';
class DoneTasksScreen extends StatelessWidget
{
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AppCubit,AppStates>(
          listener: (context, state){} ,
          builder: (context, state)
          {
            var tasks = AppCubit.get(context).doneTasks;
            return defaultConditionalBuilder(tasks: tasks);
          }
      ),
    );
  }
}

