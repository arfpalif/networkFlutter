import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modul4/view/homepage.dart';
import 'package:modul4/controller/homepageController.dart';

class form extends StatefulWidget {
  const form({super.key});

  @override
  State<form> createState() => _formState();
}

class _formState extends State<form> {
  final textController = TextEditingController();
  final avatarController = TextEditingController();
  final addressController = TextEditingController();
  final controller = Get.find<Homepagecontroller>();

  bool isEdit = false;
  
  final user = Get.arguments;
  
  int? userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isEdit = user != null;
    if(isEdit){
      textController.text = user.name;
      avatarController.text = user.avatar;
      addressController.text = user.address;
      userId = int.parse(user.id.toString()); 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                  keyboardType: TextInputType.text,
                  controller: textController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: "Nama lengkap",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder()
                  ),
              ),
              SizedBox(height: 20,),
              TextField(
                  keyboardType: TextInputType.text,
                  controller: avatarController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: "Url foto",
                    prefixIcon: Icon(Icons.web),
                    border: OutlineInputBorder()
                  ),
              ),
              SizedBox(height: 20,),
              TextField(
                  keyboardType: TextInputType.text,
                  controller: addressController,
                  obscureText: false,
                  decoration: InputDecoration(
                    labelText: "Alamat lengkap",
                    prefixIcon: Icon(Icons.map),
                    border: OutlineInputBorder()
                  ),
              ),
              ElevatedButton(
                onPressed: (){
                  if(isEdit){
                    controller.updateData(userId!, textController.text, avatarController.text, addressController.text);
                  }
                  else{
                    controller.postData(textController.text, avatarController.text, addressController.text);
                  }
                  Get.back();
                }, 
                child: Text("Submit")
              )
            ],
          ),
        ),
      ),
    );
  }
}