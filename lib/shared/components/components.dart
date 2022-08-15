import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/cubit/cubit.dart';

Widget defoultTextFormField({
  required TextInputType keyboardType,
  required String labelText,
  required Widget icon,
  void Function()? onTap,
  required var controller,
  String? Function(String?)? validate,
})
{
  return TextFormField(
    keyboardType: keyboardType,
    cursorColor: Colors.black54,
    onTap: onTap,
    validator: validate,
    controller: controller,
    decoration: InputDecoration(
      labelText:labelText,
      prefixIcon: icon,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(20),
        ),
      ),
    ),
  );
}

Widget defoultSizedBox()
{
  return const SizedBox(
    height: 10,
  );
}

Widget defaultTaskItem(Map model,context)
{
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children:[
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.teal,
            child: Text('${model['time']}',
              style: const TextStyle(
                fontWeight: FontWeight.bold
              ),
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: const TextStyle(
                      color: Colors.grey
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          IconButton(onPressed: ()
          {
            AppCubit.get(context).updateData(status: 'done', id:model['id']);
          },
              icon: const Icon(Icons.check_circle_outline,
                color: Colors.teal,
              ),
          ),
          IconButton(onPressed: ()
          {
            AppCubit.get(context).updateData(status: 'archived', id:model['id']);
          },
            icon: const Icon(Icons.archive,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),
    onDismissed: (direction)
    {
      AppCubit.get(context).deleteData(id: model['id']);
    },
  );
}

Widget defaultConditionalBuilder({
  required List<Map> tasks
})
{
  return ConditionalBuilder(
    condition: tasks.isEmpty,
    builder: (context)=> Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.menu,
            size: 150,
            color: Colors.black54,
          ),
          Text('No Tasks Yet , Please Add Some Tasks',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    ),
    fallback:(context) => ListView.separated(
      itemBuilder: (context,index) => defaultTaskItem(tasks[index], context),
      separatorBuilder: (context,index) => Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey,
      ),
      itemCount: tasks.length,
    ),

  );
}
