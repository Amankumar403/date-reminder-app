import 'package:hive/hive.dart';

var taskBox = Hive.box("taskBox");


createData (Map<String , dynamic> task )async{
  await taskBox.add(task);
  print(taskBox.length);
}


