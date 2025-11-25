import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modul4/view/homepage.dart';
import 'package:modul4/model/userResponseModel.dart';

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
      home: const Homepage(),
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

  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://6923efb13ad095fb847214b6.mockapi.io",
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      sendTimeout: const Duration(seconds: 5),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        "Accept": "application/json",
        "Connection": "keep-alive",
        "Authorization": "Bearer 123123123"
      }
    )
  );
  List<UserResponseModel> dataUser = []; 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print("=========on request======");
        print(options.uri.toString()  );
        print(options.headers.toString());
        print("=========end on request======");
        return handler.next(options);
      },
      onError: (error, handler) {
        print("=========on error======");
        print(error.message);
        print("=========end on error======");
        return handler.next(error);
      },
      onResponse: (response, handler) {
        print("=========on response======");
        print(response.statusCode);
        print(response.data);
        print("=========end on response======");
        return handler.next(response);
      },
    ));
  }

  Future<void> getData() async {
    try {
      final response = await dio.get('/users',
      options: Options(
        headers: {
          'Custom-Header': 'CustomHeaderValue',
        },
      ),
      );

      if(response.statusCode == 200 || response.statusCode == 201){
        var data = response.data as List;
        var dataList = data.map((e) => UserResponseModel.fromJson(e)).toList();

        setState(() {
          dataUser = dataList;
        });
        
      }
      
    } on DioException catch(e){
      print('Dio error: ${e.message}');
    }
    catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future <void> postData() async {
    try {
      final response = await dio.post(
        '/users',
        data: {
          "name": "Alif",
          "avatar": "https://images.unsplash.com/photo-1761839256791-6a93f89fb8b0?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "address" : "Malang"
        },
        options: Options(
          headers: {
            'Custom-Header': 'CustomHeaderValue',
          },
        ),
      );
      getData();
      print(response.data);
      print(response.data.length);
      print(response.requestOptions.headers.toString());
      print(response.realUri.host);
    } on DioException catch(e){
      print('Dio error: ${e.message}');
    }
    catch (e) {
      print('Error posting data: $e');
    }
  }

  Future <void> updateData() async {
    try {
      final response = await dio.put(
        '/users/26',
        data: {
          "name": "Jaka sembung",
          "avatar": "https://images.unsplash.com/photo-1761839256791-6a93f89fb8b0?q=80&w=2071&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
          "address" : "Malang"
        },
        options: Options(
          headers: {
            'Custom-Header': 'CustomHeaderValue',
          },
        ),
      );
      print(response.data);
      print(response.data.length);
      print(response.requestOptions.headers.toString());
      print(response.realUri.host);
    } on DioException catch(e){
      print('Dio error: ${e.message}');
    }
    catch (e) {
      print('Error posting data: $e');
    }
  }

  Future <void> deleteData() async {
    try {
      final response = await dio.delete(
        '/users/26',
        options: Options(
          headers: {
            'Custom-Header': 'CustomHeaderValue',
          },
        ),
      );
      print(response.data);
      print(response.data.length);
      print(response.requestOptions.headers.toString());
      print(response.realUri.host);
    } on DioException catch(e){
      print('Dio error: ${e.message}');
    }
    catch (e) {
      print('Error posting data: $e');
    }
  }

  Future <void> updateDataPatch() async {
    try {
      final response = await dio.patch(
        '/users/26',
        data: {
          "name": "Jaka was"
        },
        options: Options(
          headers: {
            'Custom-Header': 'CustomHeaderValue',
          },
        ),
      );
      print(response.data);
      print(response.requestOptions.headers.toString());
      print(response.realUri.host);
    } on DioException catch(e){
      print('Dio error: ${e.message}');
    }
    catch (e) {
      print('Error posting data: $e');
    }
  }
  

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
                Expanded(child: ListView.builder(
                  itemCount: dataUser.length,
                  itemBuilder: (context, index){
                    UserResponseModel user = dataUser[index];
                      return ListTile(
                        title: Text(user.name?? "no name"),
                        leading: Image.network(user.avatar ?? ""),
                        subtitle: Text(user.address ?? "No address"),
                      );
                  }
                )
                ),
                
                const Text('You have pushed the button this many times:'),
                Obx(
                  () => Text( 
                  '${controller.counter2}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                ),
                
                ElevatedButton(
                  onPressed: (){
                    Get.to(Homepage());
                  }, 
                  child: Text('Go to Second Page')
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: updateData, 
                  child: Text('Update data')
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: updateDataPatch, 
                  child: Text('Update data')
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: deleteData, 
                  child: Text('Delete data')
                ),
                SizedBox(height: 10),
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
              children: <Widget>[

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

  void updateLabel(String newLabel) {
    label = newLabel;
    update();
  }

  void updateLabelRx(String newLabel) {
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