import 'dart:convert';
import 'package:http/http.dart'
as http; // add the http plugin in pubspec.yaml file.
import 'dichvu.dart';

class Services {
  static final ROOT = Uri.parse('http://localhost/database_flutter/dichvu_action.php');
  static const _CREATE_TABLE_ACTION = 'CREATE_TABLE';
  static const _GET_ALL_ACTION = 'GET_ALL';
  static const _ADD_EMP_ACTION = 'ADD_DV';
  static const _UPDATE_EMP_ACTION = 'UPDATE_DV';
  static const _DELETE_EMP_ACTION = 'DELETE_DV';

  // Method to create the table Employees.
  static Future<String> createTable() async {
    try {
      // add the parameters to pass to the request.
      var map = <String, dynamic>{};
      map['action'] = _CREATE_TABLE_ACTION;
      final response = await http.post(ROOT, body: map);
      print('Create Table Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  static Future<List<Dichvu>> getDV() async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _GET_ALL_ACTION;
      final response = await http.post(ROOT, body: map);
      print('getEmployees Response: ${response.body}');
      if (200 == response.statusCode) {
        List<Dichvu> list = parseResponse(response.body);
        return list;
      } else {
        return <Dichvu>[];
      }
    } catch (e) {
      return <Dichvu>[]; // return an empty list on exception/error
    }
  }

  static List<Dichvu> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Dichvu>((json) => Dichvu.fromJson(json)).toList();
  }

  // Method to add employee to the database...
  static Future<String> themDV(String tenDV) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _ADD_EMP_ACTION;
      map['ten_dichvu'] = tenDV;
      final response = await http.post(ROOT, body: map);
      print('addEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to update an Employee in Database...
  static Future<String> updateDV(
      String empId, String tenDV) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _UPDATE_EMP_ACTION;
      map['emp_id'] = empId;
      map['first_name'] = tenDV;
      final response = await http.post(ROOT, body: map);
      print('updateEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  // Method to Delete an Employee from Database...
  static Future<String> deleteDV(String empId) async {
    try {
      var map = <String, dynamic>{};
      map['action'] = _DELETE_EMP_ACTION;
      map['emp_id'] = empId;
      final response = await http.post(ROOT, body: map);
      print('deleteEmployee Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }
}
