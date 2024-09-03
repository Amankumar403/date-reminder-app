
class Task{
  int? id;
  String? name;
  String? title;
  int? isCompleted;
  String? Data;
  String? startTime;
  String? endTime;
  int? color;
  int? reminder;

  Task({
    this.id,
    this.name,
    this.title,
    this.isCompleted,
    this.Data,
    this.startTime,
    this.endTime,
    this.color,
    this.reminder

  });
  Task.fromJson(Map<String, dynamic> json){
    id = json["id"];
    name = json["name"];
    title = json["title"];
    isCompleted = json["isCompleted"];
    Data = json["Data"];
    startTime = json["startTime"];
    endTime = json["endTime"];
    color = json["color"];
    reminder = json["reminder"];
  }

  Map<String , dynamic> toJson(){
    final Map<String , dynamic> data = new Map<String , dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["title"] = this.title;
    data["isCompleted"] = this.isCompleted;
    data["Data"] = this.Data;
    data["startTime"] = this.startTime;
    data["endTime"] = this.endTime;
    data["color"] = this.color;
    data["reminder"] = this.reminder;
    return data;
  }
}
