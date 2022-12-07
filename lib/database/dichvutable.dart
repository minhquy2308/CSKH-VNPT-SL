import 'package:flutter/material.dart';
import 'dichvu.dart';
import 'services.dart';

class QuanLyDichVu extends StatefulWidget {
  //
  const QuanLyDichVu({super.key});

  final String title = 'Flutter Data Table';

  @override
  QuanLyDichVuState createState() => QuanLyDichVuState();
}

// Now we will write a class that will help in searching.
// This is called a Debouncer class.
// I have made other videos explaining about the debouncer classes
// The link is provided in the description or tap the 'i' button on the right corner of the video.
// The Debouncer class helps to add a delay to the search
// that means when the class will wait for the user to stop for a defined time
// and then start searching
// So if the user is continuosly typing without any delay, it wont search
// This helps to keep the app more performant and if the search is directly hitting the server
// it keeps less hit on the server as well.
// Lets write the Debouncer class
//
// class Debouncer {
//   final int milliseconds;
//   VoidCallback action;
//   Timer _timer;
//
//   Debouncer({required this.milliseconds});
//
//   run(VoidCallback action) {
//     if (null != _timer) {
//       _timer
//           .cancel(); // when the user is continuosly typing, this cancels the timer
//     }
//     // then we will start a new timer looking for the user to stop
//     _timer = Timer(Duration(milliseconds: milliseconds), action);
//   }
// }

class QuanLyDichVuState extends State<QuanLyDichVu> {
  late List<Dichvu> _dichvu;
  // this list will hold the filtered employees
  late List<Dichvu> _filterDV;
  late GlobalKey<ScaffoldState> _scaffoldKey;
  // controller for the First Name TextField we are going to create.
  late TextEditingController _tenDV;
  // controller for the Last Name TextField we are going to create.
  late Dichvu _selectedDV;
  late bool _isUpdating;
  late String _titleProgress;
  // This will wait for 500 milliseconds after the user has stopped typing.
  // This puts less pressure on the device while searching.
  // If the search is done on the server while typing, it keeps the
  // server hit down, thereby improving the performance and conserving
  // battery life...
  // final _debouncer = Debouncer(milliseconds: 2000);
  // Lets increase the time to wait and search to 2 seconds.
  // So now its searching after 2 seconds when the user stops typing...
  // That's how we can do filtering in Flutter DataTables.

  @override
  void initState() {
    super.initState();
    _dichvu = [];
    _filterDV = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _tenDV = TextEditingController();
    _getDV();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  // Now lets add an Employee
  _themDV() {
    if (_tenDV.text.isEmpty) {
      print('Empty Fields');
      return;
    }
    _showProgress('Đang thêm dịch vụ');
    Services.themDV(_tenDV.text)
        .then((result) {
      if ('success' == result) {
        _getDV(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getDV() {
    _showProgress('Đang tải các dịch vụ...');
    Services.getDV().then((cacdichvu) {
      setState(() {
        _dichvu = cacdichvu;
        // Initialize to the list from Server when reloading...
        _filterDV = cacdichvu;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${cacdichvu.length}");
    });
  }

  _updateDV(Dichvu dichvu) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateDV(
        dichvu.id, _tenDV.text)
        .then((result) {
      if ('success' == result) {
        _getDV(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteDV(Dichvu dichvu) {
    _showProgress('Deleting Employee...');
    Services.deleteDV(dichvu.id).then((result) {
      if ('success' == result) {
        _getDV(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _tenDV.text = '';
  }

  _showValues(Dichvu dichvu) {
    _tenDV.text = dichvu.ten_dichvu;
  }

// Since the server is running locally you may not
// see the progress in the titlebar, its so fast...
// :)

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: const [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('Tên Dịch vụ'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('Xoá'),
            )
          ],
          // the list should show the filtered list now
          rows: _filterDV
              .map(
                (dichvu) => DataRow(cells: [
              DataCell(
                Text(dichvu.id),
                // Add tap in the row and populate the
                // textfields with the corresponding values to update
                onTap: () {
                  _showValues(dichvu);
                  // Set the Selected employee to Update
                  _selectedDV = dichvu;
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(
                Text(
                  dichvu.ten_dichvu.toUpperCase(),
                ),
                onTap: () {
                  _showValues(dichvu);
                  // Set the Selected employee to Update
                  _selectedDV = dichvu;
                  // Set flag updating to true to indicate in Update Mode
                  setState(() {
                    _isUpdating = true;
                  });
                },
              ),
              DataCell(IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _deleteDV(dichvu);
                },
              ))
            ]),
          )
              .toList(),
        ),
      ),
    );
  }

  // Let's add a searchfield to search in the DataTable.
  // searchField() {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: TextField(
  //       decoration: const InputDecoration(
  //         contentPadding: EdgeInsets.all(5.0),
  //         hintText: 'Filter by First name or Last name',
  //       ),
  //       onChanged: (string) {
  //         // We will start filtering when the user types in the textfield.
  //         // Run the debouncer and start searching
  //         _debouncer.run(() {
  //           // Filter the original List and update the Filter list
  //           setState(() {
  //             _filterDV = _dichvu
  //                 .where((u) => (u.ten_dichvu
  //                 .toLowerCase()
  //                 .contains(string.toLowerCase())))
  //                 .toList();
  //           });
  //         });
  //       },
  //     ),
  //   );
  // }

  // id is coming as String
  // So let's update the model...

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              _getDV();
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _tenDV,
              decoration: const InputDecoration.collapsed(
                hintText: 'Tên dịch vụ',
              ),
            ),
          ),


          // Add an update button and a Cancel Button
          // show these buttons only when updating an employee
          _isUpdating
              ? Row(
            children: <Widget>[
              OutlinedButton(
                child: const Text('UPDATE'),
                onPressed: () {
                  _updateDV(_selectedDV);
                },
              ),
              OutlinedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  setState(() {
                    _isUpdating = false;
                  });
                  _clearValues();
                },
              ),
            ],
          )
              : Container(),
          // searchField(),
          Expanded(
            child: _dataBody(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _themDV();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
