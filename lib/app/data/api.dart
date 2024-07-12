import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_homework_8910/app/model/category.dart';
import 'package:flutter_homework_8910/app/model/history_order.dart';
import 'package:flutter_homework_8910/app/model/order.dart';
import 'package:flutter_homework_8910/app/model/product.dart';
import 'package:flutter_homework_8910/app/model/register.dart';
import 'package:flutter_homework_8910/app/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class API {
  final Dio _dio = Dio();
  String baseUrl = "https://huflit.id.vn:4321";

  API() {
    _dio.options.baseUrl = "$baseUrl/api";
  }

  Dio get sendRequest => _dio;
}

class APIRepository {
  API api = API();

  Map<String, dynamic> header(String token) {
    return {
      "Access-Control-Allow-Origin": "*",
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token'
    };
  }

  Future<String> updateProfile(String token, User user) async {
    try {
      final body = FormData.fromMap({
        'NumberID': user.idNumber,
        'FullName': user.fullName,
        'PhoneNumber': user.phoneNumber,
        'Gender': user.gender,
        'BirthDay': user.birthDay,
        'SchoolYear': user.schoolYear,
        'SchoolKey': user.schoolKey,
        'ImageURL': user.imageURL,
      });
      Response res = await api.sendRequest.put(
        '/Auth/updateProfile',
        options: Options(headers: header(token)),
        data: body,
      );
      if (res.statusCode == 200) {
        print("update profile success");
        return res.statusCode.toString();
      } else {
        print("update fail");
        return res.statusCode.toString();
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> register(Signup user) async {
    try {
      final body = FormData.fromMap({
        "numberID": user.numberID,
        "accountID": user.accountID,
        "fullName": user.fullName,
        "phoneNumber": user.phoneNumber,
        "imageURL": user.imageUrl,
        "birthDay": user.birthDay,
        "gender": user.gender,
        "schoolYear": user.schoolYear,
        "schoolKey": user.schoolKey,
        "password": user.password,
        "confirmPassword": user.confirmPassword
      });
      Response res = await api.sendRequest.post('/Student/signUp',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        print("ok");
        return "ok";
      } else {
        print("fail");
        return "signup fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<User> current(String token) async {
    try {
      Response res = await api.sendRequest
          .get('/Auth/current', options: Options(headers: header(token)));
      return User.fromJson(res.data);
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> fogetPass(
      String accountID, String numberID, String newPass) async {
    try {
      final body = FormData.fromMap(
          {'accountID': accountID, 'numberID': numberID, 'newPass': newPass});
      Response response = await api.sendRequest.put('/Auth/forgetPass',
          options: Options(headers: header('no token')), data: body);
      if (response.statusCode == 200) {
        return "success";
      } else {
        return "fail in change";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> login(String accountID, String password) async {
    try {
      final body =
          FormData.fromMap({'AccountID': accountID, 'Password': password});
      Response res = await api.sendRequest.post('/Auth/login',
          options: Options(headers: header('no token')), data: body);
      if (res.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.setString("pass", password);

        final tokenData = res.data['data']['token'];
        await preferences.setString("token", tokenData);
        print("ok login");
        return tokenData;
      } else {
        return "login fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

//------------------GET FUTURE------------------
  Future<List<Product>> getProductByIdCategory(
      String idCate, String token, String accountID) async {
    try {
      Response response = await api.sendRequest.get('/Product/getList',
          options: Options(headers: header(token)),
          queryParameters: {'accountID': accountID});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        // print("truoc khi vao fromJSon: $data");
        // print(
        //     "sau khi vao from json: ${data.map((item) => Product.fromJson(item)).toList()}");
        final transformed = data
            .map((item) => Product.fromJson(item))
            .where((item) => item.idCategory.toString() == idCate)
            .toList();
        print("day la danh sach giay sap theo loai: $transformed");
        return transformed;
      } else {
        return [];
      }
    } catch (ex) {
      print("da bi loi: ${ex}");
      rethrow;
    }
  }

  Future<List<Product>> getProduct(String accountID, String token) async {
    try {
      Response response = await api.sendRequest.get('/Product/getList',
          options: Options(headers: header(token)),
          queryParameters: {'accountID': accountID});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        print("truoc khi vao fromJSon: $data");
        print(
            "sau khi vao from json: ${data.map((item) => Product.fromJson(item)).toList()}");
        return data.map((item) => Product.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      print("da bi loi: ${ex}");
      rethrow;
    }
  }

  Future<List<Category>> getCates(String accountID, String token) async {
    try {
      Response response = await api.sendRequest.get('/Category/getList',
          options: Options(headers: header(token)),
          queryParameters: {'accountID': accountID});
      if (response.statusCode == 200) {
        List<dynamic> data = response.data;
        return data.map((item) => Category.fromJson(item)).toList();
      } else {
        return [];
      }
    } catch (ex) {
      print("da bi loi: ${ex}");
      rethrow;
    }
  }

  Future<List<HistoryOrder>> getHistoryOrder(String token, User user) async {
    try {
      Response response = await api.sendRequest
          .get('/Bill/getHistory', options: Options(headers: header(token)));
      if (response.statusCode == 200) {
        print("get data thanh cong");
        print("Day la data ${response.data}");
        List<dynamic> encode = response.data;
        final transformed =
            encode.map((e) => HistoryOrder.fromJson(e)).toList();
        // print("sau khi da stranformed: $transformed");
        return transformed;
      } else {
        throw Exception("Failed to load history orders");
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

//------------------UPDATE FUTURE------------------
  Future<String> updateCate(
      Category cate, String acountID, String token) async {
    try {
      final body = FormData.fromMap({
        'AccountID': acountID,
        'id': cate.idCategory,
        'Name': cate.name,
        'Description': cate.description,
        'ImageURL': cate.imageURL
      });
      print(cate.name);
      Response response = await api.sendRequest.put(
        '/updateCategory',
        options: Options(headers: header(token)),
        data: body,
      );
      if (response.statusCode == 200) {
        print("category id: ${cate.idCategory}");
        return "update success";
      } else {
        return "update fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> updatePro(
      Product product, String acountID, String token) async {
    try {
      final body = FormData.fromMap({
        'id': product.idProduct,
        'Name': product.nameProduct,
        'Description': product.description,
        'ImageURL': product.imageUrl,
        'Price': product.price,
        'CategoryID': product.idCategory,
        'accountID': acountID,
      });
      Response response = await api.sendRequest.put('/updateProduct',
          options: Options(headers: header(token)), data: body);
      if (response.statusCode == 200) {
        return "update pro success";
      } else {
        return "update pro fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

//------------------PAYMENT FUTURE------------------
  Future<String> paymentCart(List<Order> order, String token) async {
    try {
      List<Map<String, dynamic>> oderMap =
          order.map((e) => e.toJson()).toList();
      print("truoc khi jsonEncode: $oderMap");

      final body = jsonEncode(oderMap);
      print("this is body of paymentCart: $body");
      Response response = await api.sendRequest.post('/Order/addBill',
          options: Options(headers: header(token)), data: body);
      if (response.statusCode == 200) {
        return "payment success";
      } else {
        return "payment fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  // Future<String> getHistoryOrder(String token, User user) async {
  //   try {
  //     // final body = FormData.fromMap({
  //     //   'id': listOrder.id,
  //     //   'fullName': user.fullName,
  //     //   'dateCreated': user.dateCreated
  //     // });
  //     Response response = await api.sendRequest
  //         .get('/Bill/getHistory', options: Options(headers: header(token)));
  //     if (response.statusCode == 200) {
  //       print("get data success");
  //       final transformed = jsonDecode(response.data);
  //       // print(transformed);

  //       return "Danh sach :${transformed[0]['id']}";
  //     } else {
  //       return "fail";
  //     }
  //   } catch (ex) {
  //     print(ex);
  //     rethrow;
  //   }
  // }

//------------------INSERT FUTURE------------------

  Future<String> insertCate(
      Category cate, String accountID, String token) async {
    try {
      final body = FormData.fromMap({
        'AccountID': accountID,
        'Name': cate.name,
        'Description': cate.description,
        'ImageURL': cate.imageURL
      });
      print(cate.name);
      Response response = await api.sendRequest.post(
        '/addCategory',
        options: Options(headers: header(token)),
        data: body,
      );
      if (response.statusCode == 200) {
        // print("category id: ${cate.idCategory}");
        return "add success";
      } else {
        return "add fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> insertProduct(
      Product product, String accountID, String token) async {
    try {
      final body = FormData.fromMap({
        "Name": product.nameProduct,
        'Description': product.description,
        'ImageURL': product.imageUrl,
        'Price': product.price,
        'CategoryID': product.idCategory
      });
      Response response = await api.sendRequest.post('/addProduct',
          options: Options(headers: header(token)), data: body);
      if (response.statusCode == 200) {
        return "add pro success";
      } else {
        return "add pro fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

//------------------DELETE FUTURE------------------

  Future<String> deleteCategory(
      Category cate, String accountID, String token) async {
    try {
      final body = FormData.fromMap({
        "categoryID": cate.idCategory,
        "accountID": accountID,
      });
      Response response = await api.sendRequest.delete(
        '/removeCategory',
        options: Options(headers: header(token)),
        data: body,
      );
      if (response.statusCode == 200) {
        return "delete cate success";
      } else {
        return "delete cate fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> deleteProduct(
      Product pro, String accountID, String token) async {
    try {
      final body = FormData.fromMap(
          {"productID": pro.idProduct, "accountID": accountID});
      Response response = await api.sendRequest.delete("/removeProduct",
          options: Options(headers: header(token)), data: body);
      if (response.statusCode == 200) {
        return "delete product success";
      } else {
        return "delete product fail";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }

  Future<String> removeHistory(String idHis, String token) async {
    try {
      Response response = await api.sendRequest.delete('/Bill/remove',
          options: Options(headers: header(token)),
          queryParameters: {'billID': idHis});
      if (response.statusCode == 200) {
        print("id cua item: $idHis");
        return "xoa thanh cong";
      } else {
        return "xoa faied";
      }
    } catch (ex) {
      print(ex);
      rethrow;
    }
  }
}
