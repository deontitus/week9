import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkService {
  final String apiUrl =
      "https://jsonplaceholder.typicode.com/todos";

  Future<void> fetchTasks() async {
    try {
      final response = await http.get(
        Uri.parse(apiUrl),

        headers: {
          "Content-Type": "application/json",
        },
      );

      print("Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        print("Raw JSON Response:");
        print(data);
      } else {
        print("Failed to fetch tasks");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
