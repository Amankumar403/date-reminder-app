import 'package:birthday_reminder_app/app_ui/theme_data.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String label;
  final Function()? ontap;
  const MyButton({super.key, required this.label, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        width: 100,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: primaryCls,
        ),
        child: Center(child: Text(label,style: TextStyle(fontSize: 14,color: Colors.white),),)
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final String label;
  final Function()? ontap;
  const SaveButton({super.key, required this.label, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          width: 120,
          height: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: primaryCls,
          ),
          child: Center(child: Text(label,style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.bold),),)
      ),
    );
  }
}
