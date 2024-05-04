import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TaskScreen(),
    );
  }
}

class TaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Tasks"),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          bottom: TabBar(
            tabs: [
              Tab(text: "Backlog 3"),
              Tab(text: "Featured 3"),
              Tab(text: "In Progress 3"),
            ],
            labelColor: Colors.black,
            indicatorColor: Colors.blue,
          ),
        ),
        body: TabBarView(
          children: [
            TaskListView(tasks: [
              Task(title: "Backlog Task 1", progress: 0, days: 10),
              Task(title: "Backlog Task 2", progress: 20, days: 5),
            ]),
            TaskListView(tasks: [
              Task(title: "Featured Task 1", progress: 50, days: 3),
              Task(title: "Featured Task 2", progress: 60, days: 7),
            ]),
            TaskListView(tasks: [
              Task(title: "In Progress Task 1", progress: 70, days: 4),
              Task(title: "In Progress Task 2", progress: 80, days: 2),
            ]),
          ],
        ),
      ),
    );
  }
}

class TaskListView extends StatelessWidget {
  final List<Task> tasks;

  TaskListView({required this.tasks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(8.0),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(task: tasks[index]);
      },
    );
  }
}

class Task {
  final String title;
  final int progress;
  final int days;

  Task({required this.title, required this.progress, required this.days});
}

class TaskCard extends StatelessWidget {
  final Task task;

  TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  task.title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(Icons.more_vert),
              ],
            ),
            SizedBox(height: 10),
            LinearProgressIndicator(
              value: task.progress / 100,
              backgroundColor: Colors.grey[200],
              color: Colors.blue,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(),
                    CircleAvatar(),
                    CircleAvatar(),
                  ],
                ),
                Text("${task.days} days")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
