import 'package:flutter/material.dart';
import '../models/task_model.dart';
import '../services/api_service.dart';

class TaskView extends StatefulWidget {
  const TaskView({super.key});

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late Future<List<TaskModel>> futureTasks;

  @override
  void initState() {
    super.initState();
    futureTasks = ApiService().fetchTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.deepPurple,

        title: const Text(
          "Task Manager",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        centerTitle: true,
      ),

      body: FutureBuilder<List<TaskModel>>(
        future: futureTasks,

        builder: (context, snapshot) {
          if (snapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
              ),
            );
          }

          final tasks = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(15),

            itemCount: tasks.length,

            itemBuilder: (context, index) {
              final task = tasks[index];

              return Container(
                margin: const EdgeInsets.only(
                  bottom: 15,
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.circular(20),

                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),

                child: ListTile(
                  contentPadding:
                      const EdgeInsets.all(18),

                  leading: CircleAvatar(
                    radius: 28,
                    backgroundColor: task.completed
                        ? Colors.green
                        : Colors.orange,

                    child: Icon(
                      task.completed
                          ? Icons.check
                          : Icons.pending,
                      color: Colors.white,
                    ),
                  ),

                  title: Text(
                    task.title,

                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  subtitle: Padding(
                    padding:
                        const EdgeInsets.only(top: 8),

                    child: Text(
                      task.completed
                          ? "Completed"
                          : "Pending",

                      style: TextStyle(
                        color: task.completed
                            ? Colors.green
                            : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  trailing: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),

                    decoration: BoxDecoration(
                      color: Colors.deepPurple
                          .withOpacity(0.1),

                      borderRadius:
                          BorderRadius.circular(12),
                    ),

                    child: Text(
                      "#${task.id}",

                      style: const TextStyle(
                        color: Colors.deepPurple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}