import 'dart:convert';
import 'package:car_store/models/product_model.dart';
import 'package:http/http.dart' as http;

class ApiClass {
  Future<dynamic> get({required String url, String? token}) async {
    Map<String, String> headers = {};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.get(Uri.parse(url), headers: headers);
    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print('Error decoding JSON: ${response.body}');
        throw Exception('Expected JSON response but got HTML or text.');
      }
    } else {
      throw Exception(
          'Error with status code ${response.statusCode}: ${response.body}');
    }
  }

  Future<dynamic> post(
      {required String url, required Map<String,dynamic> body, String? token}) async {
    Map<String, String> headers = {"Accept": "application/json",'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.post(Uri.parse(url),
        body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print('Error decoding JSON: ${response.body}');
        throw Exception('Expected JSON response but got HTML or text.');
      }
    } else {
      throw Exception(
          'Error with status code ${response.statusCode}: ${response.body}');
    }
  }

  Future<dynamic> put(
      {required String url, required dynamic body, String? token}) async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }

    http.Response response = await http.put(Uri.parse(url),
        body: jsonEncode(body), headers: headers);

    if (response.statusCode == 200) {
      try {
        return jsonDecode(response.body);
      } catch (e) {
        print('Error decoding JSON: ${response.body}');
        throw Exception('Expected JSON response but got HTML or text.');
      }
    } else {
      throw Exception(
          'Error with status code ${response.statusCode}: ${response.body}');
    }
  }

  Future<dynamic> delete({required String url}) async {
    http.Response response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      try {
        print('Product deleted successfully');
      } catch (e) {
        print('Error decoding JSON: ${response.body}');
        throw Exception('Expected JSON response but got HTML or text.');
      }
    } else {
      throw Exception(
          'Error with status code ${response.statusCode}: ${response.body}');
    }
  }
}
