import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/cubit/cubit.dart';
import 'package:to_do_list/cubit/states.dart';
import 'package:to_do_list/shared/components/components.dart';
class ArchivedTasksScreen extends StatelessWidget
{
  const ArchivedTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: const [
      //       Icon(Icons.menu,
      //         size: 150,
      //         color: Colors.black54,
      //       ),
      //       Text('No Tasks Yet , Please Add Some Tasks',
      //         style: TextStyle(
      //           fontSize: 20,
      //           color: Colors.black54,
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      body: BlocConsumer<AppCubit,AppStates>(
          listener: (context, state){} ,
          builder: (context, state)
          {
            var tasks = AppCubit.get(context).archivedTasks;
            return defaultConditionalBuilder(tasks: tasks);
          }
      ),
    );
  }
}
