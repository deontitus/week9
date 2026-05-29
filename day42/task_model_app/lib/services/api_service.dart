import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task_model.dart';

class ApiService {
  final String apiUrl =
      "https://jsonplaceholder.typicode.com/todos";

  Future<List<TaskModel>> fetchTasks() async {
    final response = await http.get(
      Uri.parse(apiUrl),
    );

    if (response.statusCode == 200) {
      List jsonData = jsonDecode(response.body);

      return jsonData
          .map((task) => TaskModel.fromJson(task))
          .toList();
    } else {
      throw Exception("Failed to load tasks");
    }
  }
}