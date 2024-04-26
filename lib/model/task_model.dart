class TaskModel {
  final String? title;
  final String? time;
  final String? date;
  final String? note;
  final String? iconName;
  final int? id;

  TaskModel(
      {required this.iconName,
      this.title,
      this.time,
      this.date,
      this.note,
      this.id});

  static Map<String, dynamic> toJson(TaskModel task) {
    Map<String, dynamic> taskAsMap = {
      'time': task.time,
      'date': task.date,
      'note': task.note,
      'title': task.title,
      'iconName': task.iconName,
      'id': task.id
    };

    return taskAsMap;
  }

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
      iconName: json['iconName'],
      title: json['title'],
      time: json['time'],
      note: json['note'],
      date: json['date'],
      id: json['id']);
}
