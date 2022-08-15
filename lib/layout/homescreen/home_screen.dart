import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/cubit/cubit.dart';
import 'package:to_do_list/cubit/states.dart';
import 'package:to_do_list/shared/components/components.dart';
import 'package:to_do_list/shared/components/constants.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKay = GlobalKey<ScaffoldState>();
    var formKay = GlobalKey<FormState>();
    var titleController = TextEditingController();
    var timeController = TextEditingController();
    var dateController = TextEditingController();
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (BuildContext context, AppStates state) {},
        builder: (BuildContext context, AppStates state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKay,
            appBar: AppBar(
              backgroundColor: Colors.teal,
              title: Text(
                titles[cubit.currentIndex],
              ),
            ),
            body: screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isButtonSheet) {
                  if (formKay.currentState!.validate()) {
                    cubit.insertIntoDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text,
                    );
                    Navigator.pop(context);
                    cubit.isButtonSheet = false;
                  }
                } else {
                  scaffoldKay.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          width: double.infinity,
                          height: 280,
                          color: Colors.grey[200],
                          child: Form(
                            key: formKay,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  defoultTextFormField(
                                    keyboardType: TextInputType.text,
                                    controller: titleController,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Task Title is Not Empty';
                                      }
                                      return null;
                                    },
                                    labelText: 'Enter your Task',
                                    icon: const Icon(
                                      Icons.task,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  defoultSizedBox(),
                                  defoultTextFormField(
                                    keyboardType: TextInputType.datetime,
                                    controller: timeController,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Task Time is Not Empty';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now(),
                                      ).then((value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                      });
                                    },
                                    labelText: 'Enter your Task Time',
                                    icon: const Icon(
                                      Icons.watch_later_outlined,
                                      color: Colors.black54,
                                    ),
                                  ),
                                  defoultSizedBox(),
                                  defoultTextFormField(
                                    controller: dateController,
                                    keyboardType: TextInputType.datetime,
                                    validate: (value) {
                                      if (value!.isEmpty) {
                                        return 'Task Date is Not Empty';
                                      }
                                      return null;
                                    },
                                    onTap: () {
                                      showDatePicker(
                                        context: context,
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2029),
                                        initialDate: DateTime.now(),
                                      ).then((value) {
                                        dateController.text =
                                            DateFormat.yMMMMd().format(value!);
                                      });
                                    },
                                    labelText: 'Enter your Task Date',
                                    icon: const Icon(
                                      Icons.date_range,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ).closed.then((value) {
                        cubit.changeButtonSheetState(isShow: false);
                  });
                  cubit.changeButtonSheetState(isShow: true);
                }
              },
              child: const Icon(Icons.add),
              backgroundColor: Colors.teal,
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              fixedColor: Colors.teal,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu),
                  label: 'Tasks',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.archive),
                  label: 'Archived',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
