class PlantTask {
  final String verb;
  final String amount;
  final String icon;
  final String effect;
  final int xp;

  PlantTask({
    required this.verb,
    required this.amount,
    required this.icon,
    required this.effect,
    required this.xp,
  });

  factory PlantTask.fromJson(Map<String, dynamic> json) {
    return PlantTask(
      verb: json['verb'],
      amount: json['amount'],
      icon: json['icon'],
      effect: json['effect'],
      xp: json['xp'],
    );
  }
}

class AnalyzePlantResponse {
  final String plantType;
  final String state;
  final List<PlantTask> tasks;

  AnalyzePlantResponse({
    required this.plantType,
    required this.state,
    required this.tasks,
  });

  factory AnalyzePlantResponse.fromJson(Map<String, dynamic> json) {
    var tasksJson = json['tasks'] as List;
    List<PlantTask> tasksList =
        tasksJson.map((e) => PlantTask.fromJson(e)).toList();

    return AnalyzePlantResponse(
      plantType: json['plant_type'],
      state: json['state'],
      tasks: tasksList,
    );
  }
}
