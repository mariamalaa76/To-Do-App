import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_list/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  late Database database;
  bool isButtonSheet = false;
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavigationBarState());
  }

  void createDatabase() {
    openDatabase('todoTest.db', version: 3, onCreate: (database, version) {
      print('Database Created');
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,time TEXT,date TEXT,status TEXT)')
          .then((value) {
        print('Table Created');
      }).catchError((error) {
        print('Error When creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('Database Opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

   insertIntoDatabase(
      {
        required String title,
        required String time,
        required String date
      }) async {
     await database.transaction((txn) {
      return txn
          .rawInsert(
              'INSERT INTO tasks(title,time,date,status)VALUES("$title","$time","$date","new")')
          .then((value) {
        print('inserted successful');
        emit(AppInsertDatabase());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error When Insert ${error.toString()}');
      });
    });
  }

  void getDataFromDatabase(database)  {
     newTasks = [];
     doneTasks = [];
     archivedTasks = [];

     database.rawQuery('SELECT * FROM tasks').then((value) {

       value.forEach((element)
       {
         if(element['status']=='new')
           {
             newTasks.add(element);
           }
         else if(element['status']=='done')
           {
             doneTasks.add(element);
           }
         else if(element['status']=='archived')
         {
           archivedTasks.add(element);
         }
       });
       emit(AppGetDatabase());
     });
  }

  void updateData({
  required String status,
    required int id
}) async
  {
     database.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
      ['$status',id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabase());
     });
  }

  void deleteData({
    required int id
  }) async
  {
    database.rawDelete('DELETE FROM tasks WHERE id = ?',
        [id]
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabase());
    }).catchError((error){
      print('Error when deleting Database $error');
    });
  }
  void changeButtonSheetState({required isShow}) {
    isButtonSheet = isShow;
    emit(AppChangeBottomSheetState());
  }
}
