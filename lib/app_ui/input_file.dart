import 'package:flutter/material.dart';


class InputData extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  const InputData({super.key, required this.title, required this.hint,  this.controller,  this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,style: TextStyle(fontSize: 20),),
          Container(
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 12),
            height: 55,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.black54,
                width: 1.0
              )
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    readOnly: widget==null?false:true,
                    autofocus: false,
                    decoration: InputDecoration(
                      hintText: hint,hintStyle: TextStyle(color: Colors.grey[850]),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                widget==null?Container():Container(child: widget,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
