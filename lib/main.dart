import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'app_ui/theme_data.dart';
import 'screen/home_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("taskBox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeMode.light,

      home: FistPage()
    );
  }
}

class FistPage extends StatelessWidget {
  const FistPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
      },
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/b3.jpg"),fit: BoxFit.cover
            )
        ),
        child: Column(
          children: [
            SizedBox(height: 100,),
            Text("Hey"),
            SizedBox(height: 400,),
            Text("WelCome"),
            SizedBox(height: 10),
            Text("to birthday reminder",style: TextStyle(fontSize: 15),),
            SizedBox(height: 10,),
            Text("tap on screen",style: TextStyle(fontSize: 10),),
          ],
        ),
      ),
    );
  }
}