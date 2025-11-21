import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(  
      title: 'Flutter Demo',
      initialBinding: BindingsBuilder(() {
        Get.put(thirdController());
      }),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    var ThirdController = Get.find<thirdController>();
    return GetBuilder<mainController>(
      init: mainController(),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text('You have pushed the button this many times:'),
                Obx(
                  () => Text( 
                  '${controller.counter2}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ),
                ElevatedButton(
                  onPressed: () => Get.to(SecondPage()), 
                  child: Text('Go to Second Page')
                ),
                Text(
                  ThirdController.label,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: controller.increment2,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        );
      }
    );
  }
}

class mainController extends GetxController {
  var counter = 0;
  var counter2 = 0.obs;

  void increment() {
    counter++;
    update();
  }

  void increment2() {
    counter2++;
  }

  
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(secondController());
    var MainController = Get.find<mainController>();
    return GetBuilder<secondController>(
      builder: (state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Second Page"),
          ),
          body: Center(
            child: Column(
              children: [
                Obx( 
                  () => Text(
                    controller.labelrx.value,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Text(MainController.counter2.toString(), style: TextStyle(fontSize: 20),
            ),
              ],
            ),
            
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.updateLabelRx("Updated Label reactive 1234");
            },
            child: Icon(Icons.arrow_back),
          ),
        );
      }
    );
  }
}

class secondController extends GetxController {
  var label = "Ini Second Page";
  var labelrx = "Ini Second Page".obs;

  updateLabel(String newLabel) {
    label = newLabel;
    update();
  }

  updateLabelRx(String newLabel) {
    labelrx.value = newLabel;
  }
  @override
  void onInit() {
    super.onInit();
    print('ini onInit mainController');
    
  }

  @override
  void onReady() {
    super.onReady();
    print('ini onReady mainController');
  }

  @override
  void onClose() {
    super.onClose();
    print('ini onClose mainController');
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class thirdController extends GetxController {
  var label = "Ini Third Page";
}