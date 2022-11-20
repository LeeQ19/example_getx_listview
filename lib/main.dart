import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Getx Listview Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GetXListviewPage('Getx Listview Example'),
    );
  }
}

class ListContoller extends GetxController {
  RxList<int> numbers = List<int>.from([0]).obs;

  void httpCall() async {
    await Future.delayed(const Duration(milliseconds: 1), () => numbers.add(numbers.last + 1));
  }

  void reset() {
    numbers.removeRange(1, numbers.length);
  }
}

class GetXListviewPage extends StatelessWidget {
  const GetXListviewPage(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    ListContoller controller = Get.put(ListContoller());
    print('Page ** rebuilt');
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: Obx(
                () => ListView.builder(
                    itemCount: controller.numbers.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text('Number: ${controller.numbers[index]}'),
                      );
                    }),
              ),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: controller.httpCall,
                      child: const Text('Http Request'),
                    ),
                    ElevatedButton(
                      onPressed: controller.reset,
                      child: const Text('Reset'),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
