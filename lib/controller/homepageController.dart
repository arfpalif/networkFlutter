import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:modul4/model/userResponseModel.dart';

class Homepagecontroller extends GetxController {
  
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

    RxList<UserResponseModel> dataUser = <UserResponseModel>[].obs; 

    Future<void> getData() async {
    try {
      final response = await dio.get('/users');

      if(response.statusCode == 200 || response.statusCode == 201){
        var data = response.data as List;
        dataUser.assignAll(data.map((e) => UserResponseModel.fromJson(e)).toList());
        
      }
      
    } on DioException catch(e){
      print('Dio error: ${e.message}');
    }
    catch (e) {
      print('Error fetching data: $e');
    }
  }

  Future <void> updateData(int id,String name, String avatar, String address) async {
    try {
      final response = await dio.put(
        '/users/$id',
        data: {
          "id": id,
          "name": name,
          "avatar": avatar,
          "address" : address
        },
        options: Options(
          headers: {
            'Custom-Header': 'CustomHeaderValue',
          },
        ),
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        getData();
      }
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

  Future <void> postData(String name, String avatar, String address) async {
    try {
      final response = await dio.post(
        '/users',
        data: {
          "name": name,
          "avatar": avatar,
          "address" : address
        },
      );
      if(response.statusCode == 200 || response.statusCode == 201){
        
        
      }
      getData();
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

  Future <void> deleteData(int id) async {
    try {
      final response = await dio.delete(
        '/users/$id',
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
}
