import 'dart:async';

import 'package:mysql1/mysql1.dart';

Future main() async {
  // Open a connection (testdb should already exist)
  final conn = await MySqlConnection.connect(ConnectionSettings(
      host: '10.0.2.2',
      port: 8889,
      user: 'root',
      db: 'cskh',
      password: 'root'));

  // Create a table
  // await conn.query(
  //     'CREATE TABLE dichvu (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, tenDichVu varchar(255))');

  // Insert some data
  // var result = await conn.query(
  //     'insert into dichvu (tenDichVu) values (?)',
  //     ['IOFFICE']);
  // print('Inserted row id=${result.insertId}');

  // Query the database using a parameterized query
  var results = await conn.query(
      'select tenDichVu from `dichvu`', [1]);
  for (var row in results) {
    print('Dịch vụ: ${row[0]}');
  }

  // Update some data
  // await conn.query('update users set age=? where name=?', [26, 'Bob']);
  //
  // // Query again database using a parameterized query
  // var results2 = await conn.query(
  //     'select name, email, age from users where id = ?', [result.insertId]);
  // for (var row in results2) {
  //   print('Name: ${row[0]}, email: ${row[1]} age: ${row[2]}');
  // }

  // Finally, close the connection
  await conn.close();
}