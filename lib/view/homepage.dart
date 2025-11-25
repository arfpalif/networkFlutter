import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modul4/view/form.dart';
import 'package:modul4/controller/homepageController.dart';
import 'package:modul4/model/userResponseModel.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
    var controller = Get.put(Homepagecontroller());

    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f4),
                appBar: AppBar(
                  backgroundColor: Colors.white,
                    title: Text("TaskFlow", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff0D9488)),),
                    centerTitle: true,
                ),
                body: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Text("Your Task", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
                          SizedBox(height: 10,),
                          Expanded(child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Obx(() => ListView.builder(
                              itemCount: controller.dataUser.length,
                              itemBuilder: (context, index){
                                  final user = controller.dataUser[index];
                                  return Card(
                                    color: Colors.white,
                                    margin: EdgeInsets.only(bottom: 15),
                                    elevation: 2,
                                    child: Padding(
                                       padding: const EdgeInsets.all(8.0),
                                       child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            ListTile(
                                              leading: Image.network(user.avatar),
                                              title: Text(user.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                                              subtitle: Text(user.createdAt.toString(), style: TextStyle(color: Color(0xff14B8A6)),),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: <Widget>[
                                                ElevatedButton(
                                                  onPressed: (){Get.to(form(), arguments: user);}, 
                                                  child: Text("Edit", style: TextStyle(color: Colors.white),), 
                                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xff14B8A6)),
                                                ),
                                                const SizedBox(width: 8),
                                                ElevatedButton(
                                                  onPressed: (){controller.deleteData(int.parse(user.id));}, 
                                                  child: Text("Delete", style: TextStyle(color: Colors.white),), 
                                                  style: ElevatedButton.styleFrom(backgroundColor: Color(0xffEF4444)),
                                                ),
                                                const SizedBox(width: 8),
                                              ],
                                            ),
                                          ],
                                        ),
                                     ), 
                                  );
                              }),)
                          ))
                      ],
                  ),
                ),
                floatingActionButton: FloatingActionButton(
                  onPressed: (){
                    Get.to(form());
                  },
                  child: const Icon(Icons.add),
                ),
            );
  }
}