import 'package:birthday_reminder_app/app_ui/button.dart';
import 'package:birthday_reminder_app/app_ui/input_file.dart';
import 'package:birthday_reminder_app/app_ui/theme_data.dart';
import 'package:birthday_reminder_app/screen/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/task_controller.dart';
import '../models/task_data.dart';


class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  String _endTime = " 12:00 pm";
  String _startTime = DateFormat("hh : mm a").format(DateTime.now()).toString();

  int _selectedReminder = 2;
  List<int> Reminder= [
    2 , 5 , 10 , 15 , 20,
  ];
  int _selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 2000,width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/b2.jpg"),fit: BoxFit.cover
          )
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 12,vertical: 10),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 65,child: GestureDetector(onTap: (){Navigator.push(context, CupertinoPageRoute(builder: (context)=>HomePage()));},child: Icon(Icons.undo,size: 30,),)),
                  Text("Add Date",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  InputData(title: "Name", hint: "Enter your name",controller: _titleController,),
                  InputData(title: "Title", hint: "Enter you title",controller: _noteController,),
                  InputData(title: "Date", hint: DateFormat.yMd().format(_selectedDate),
                    widget: IconButton(
                      onPressed: (){
                        _getDataFromUser();
                      },
                      icon: Icon(Icons.calendar_month_outlined,color: Colors.grey[700],),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InputData(
                          title: "Start Date",
                          hint: _startTime,
                          widget: IconButton(
                            onPressed: (){
                              _getTimeFromUser(isStartTime: true);
                            },
                            icon: Icon(Icons.access_time,color: Colors.grey[800],),
                          ),
                        ),
                      ),
                      SizedBox(width: 5,),
                      Expanded(
                        child: InputData(
                          title: "End Time",
                          hint: _endTime,
                          widget: IconButton(
                            onPressed: (){
                              _getTimeFromUser(isStartTime: false);
                            },
                            icon: Icon(Icons.access_time,color: Colors.grey[800],),
                          ),
                        ),
                      )
                    ],
                  ),
                  InputData(title: "reminder", hint: "$_selectedReminder  minutes early",
                    widget: DropdownButton(
                      underline: Container(height: 0,),
                      onChanged: (String? newValue){
                        setState(() {
                          _selectedReminder = int.parse(newValue!);
                        });
                      },
                      icon: Icon(Icons.arrow_drop_down_outlined,size: 35,color: Colors.grey[800],),
                      items: Reminder.map<DropdownMenuItem<String>>((int value ){
                        return DropdownMenuItem(
                          value: value.toString(),
                          child: Text(value.toString()),
                        );
                      },
                      ).toList(),
                    ),
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Color",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          SizedBox(height: 5,),
                          Wrap(
                            children: List<Widget>.generate(
                                3,
                                    (index) {
                                  return GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        _selectedColor = index;
                                      });
                                    },
                                    child: Padding(padding: EdgeInsets.only(right: 8),
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: index==0?primaryCls:index==1?Colors.cyan:Colors.green,
                                        child: _selectedColor==index?Icon(Icons.done,color: Colors.white,size: 25,):Container(),
                                      ),
                                    ),
                                  );}
                            ),
                          )
                        ],
                      ),
                      SaveButton(label: "Save", ontap: (){
                        _valideDate();
                      })
                    ],
                  )
                ]
            ),
          ),
        ),
      )
    );
  }

  _valideDate(){
    if(_titleController.text.isNotEmpty&&_noteController.text.isNotEmpty){
      _addTaskData();
      Navigator.push(context, CupertinoPageRoute(builder: (context)=>HomePage()));
       // Get.back();
    }else if(_titleController.text.isEmpty || _noteController.text.isEmpty){
      Get.snackbar("required", "all fields are required",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.black,
          colorText: Colors.blue,
          icon: Icon(Icons.warning_amber_rounded)
      );
    }
  }

  _addTaskData() async {
      var tasks  = {
        "name": _titleController.text,
        "title": _noteController.text,
        "isCompleted": 0,
        "Data": DateFormat.yMd().format(_selectedDate),
        "startTime": _startTime,
        "endTime": _endTime,
        "color": _selectedColor,
        "reminder": _selectedReminder,
      };
      createData(tasks);
  }


  _getDataFromUser() async {
    DateTime? _pickerDate = await  showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1975),
        lastDate: DateTime(2222)
    );
    if(_pickerDate!=null){
      setState(() {
        _selectedDate = _pickerDate;
      });
    }else{
      print("null");
    }
  }

  _getTimeFromUser({required bool isStartTime})async{
    var pickedTime =await _showTimePickers();
    String _formatedTime = pickedTime.format(context);
    if(pickedTime==null){
      print("Time Canceld");
    }else if(isStartTime==true){
      setState(() {
        _startTime = _formatedTime;
      });
    }else if(isStartTime==false){
      setState(() {
       _endTime = _formatedTime;
      });
    }
  }

  _showTimePickers(){
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay(
            hour: 24,
            minute: 00
        )
    );
  }

}
