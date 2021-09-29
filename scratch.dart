import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String data = await task2();
  task3(data);
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future task2() async {
  Duration obj = Duration(seconds: 10);
  String result;
  await Future.delayed(obj, () {
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String data) {
  String result = 'task 3 data';
  print('Task 3 complete $data');
}
