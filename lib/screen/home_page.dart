import 'package:birthday_reminder_app/screen/add_date_screen.dart';
import 'package:birthday_reminder_app/app_ui/theme_data.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/task_controller.dart';
import '../models/task_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Task? task;
  int page = 0;
  DateTime selectedData = DateTime.now();
  //final _taskController = Get.put(TaskController());

  // var notifyHelper;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   notifyHelper = NotifyHelper();
  //   notifyHelper.requestIOSPermissions();
  //
  // }

  get key => readData();
  get data => readData();

  List<Map<String ,dynamic>> ourData = [];

  readData()async{
    var data = taskBox.keys.map((key){
      final items =taskBox.get(key);
      return {"key" : key,
        "name" : items["name"], "title" : items["title"],"Data":items["Data"],
        "startTime":items["startTime"],
        "endTime":items["endTime"],
        "color":items["color"]
      };
    }).toList();
    setState(() {
      ourData = data.reversed.cast<Map<String, dynamic>>().toList();
      print(ourData);
      print(ourData.length);
    });

  }

  @override
  void initState() {
    readData();
    super.initState();
  }


  deletData(Key)async{
    await taskBox.delete(Key);
    readData();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  Container(
        height: double.infinity,width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/b5.jpg"),fit: BoxFit.cover,
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30,),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12,vertical: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat.yMMMMd().format(DateTime.now()),style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.grey[800]),),
                      SizedBox(height: 10,),
                      Text("Today",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)
                    ],
                  ),
                  // MyButton(label: "+Add Date", ontap: (){
                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData()));
                  // })
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: DatePicker(
                DateTime.now(),
                height: 100,
                width: 70,
                initialSelectedDate: DateTime.now(),
                selectionColor: primaryCls,
                selectedTextColor: Colors.white,
                dateTextStyle: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54
                ),
                dayTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800
                ),
                monthTextStyle: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800
                ),
                onDateChange: (date){
                  selectedData = date;
                },
              ),
            ),

           SizedBox(height: 10,),

           //dummy widget ,,replace on task_tile widget
            Expanded(
                child: ListView.builder(
                  itemCount: ourData.length,
                  itemBuilder: (_ , index){
                    var currentItem  = ourData[index];
                    return Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 15,),
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 10),
                      child: Container(
                        padding: EdgeInsets.only(top: 12,bottom: 12,left: 15,right: 15),
                        //  width: SizeConfig.screenWidth * 0.78,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: _getBGClr(currentItem["color"]??0),
                        ),
                        child: Row(children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentItem["name"],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30),
                                  child: Text(
                                   "BirthDay Reminder Date",
                                    style: TextStyle(fontSize: 10, color: Colors.grey[300],fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  currentItem["Data"],
                                  style: TextStyle(fontSize: 18, color: Colors.grey[100],fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.access_time_rounded,
                                      color: Colors.grey[300],
                                      size: 18,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      "${currentItem!["startTime"]} <=> ${currentItem! ["endTime"]}",
                                      style: TextStyle(fontSize: 13, color: Colors.grey[100]),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20,right: 10),
                            height: 60,
                            width: 0.9,
                            color: Colors.grey[200]!.withOpacity(0.7),
                          ),
                          InkWell(
                            onTap: (){
                              deletData(ourData[index]["key"]);
                            },
                            child: Icon(Icons.delete_forever_outlined,size: 30,color: Colors.red,),)
                          ///delete file
                          // RotatedBox(
                          //   quarterTurns: 3,
                          //   child: Text(
                          //     task!.isCompleted == 1 ? "COMPLETED" : "TODO",
                          //     style: TextStyle(
                          //         fontSize: 10,
                          //         fontWeight: FontWeight.bold,
                          //         color: Colors.white),
                          //   ),
                          // ),
                        ]),
                      ),
                    );
                  },
                ),
            )
          ],
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        animationDuration: Duration(milliseconds: 00),
        height: 60,
        backgroundColor: Colors.blue.shade900,
        color: Colors.blueAccent,
        onTap: (index){
          setState(() {
            page = index;
           if(index==1){
             Navigator.push(context, MaterialPageRoute(builder: (context)=>AddData()));
           }else{
             Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
           }
          });
        },
        items: [
          Icon(Icons.home,color: Colors.white,size: 35,),
          Icon(Icons.add,color: Colors.white,size: 35,),
          Icon(Icons.notification_add_outlined,color: Colors.white,size: 25,),
        ],
      )
    );
  }

  _getBGClr(int no) {
    switch (no) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.pinkAccent;
      case 2:
        return Colors.green;
      default:
        return Colors.blueGrey;
    }
  }

}
