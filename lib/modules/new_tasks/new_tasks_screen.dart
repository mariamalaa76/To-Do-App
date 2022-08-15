import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/cubit/cubit.dart';
import 'package:to_do_list/cubit/states.dart';
import 'package:to_do_list/shared/components/components.dart';

class NewTasksScreen extends StatelessWidget
{
  const NewTasksScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){} ,
        builder: (context, state)
        {
          var tasks = AppCubit.get(context).newTasks;
          return defaultConditionalBuilder(tasks: tasks);
        }
      ),
    );
  }
}