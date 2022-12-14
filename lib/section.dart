import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:vnptsl/user.dart';
import 'dich_vu.dart';
import 'package:http/http.dart' as http;
import 'login.dart';

var iddichvu = "";
var trangthai = "";
var idhotro = "";
var noidungid = "";
var khachhangid = "";
String dropdownTrangThaiValue="";
List<String> listDV = [];
TextEditingController hotenKHctl = TextEditingController();
TextEditingController sdtctl = TextEditingController();
TextEditingController accountctl = TextEditingController();
TextEditingController donVictl = TextEditingController();
TextEditingController noiDungctl = TextEditingController();
TextEditingController ghiChuctl = TextEditingController();
TextEditingController khaosatctl = TextEditingController();
TextEditingController lydoctl = TextEditingController();
TextEditingController khaosat2ctl = TextEditingController();
TextEditingController lydo2ctl = TextEditingController();

class DropdownListDV extends StatefulWidget {
  const DropdownListDV({super.key});

  @override
  State<DropdownListDV> createState() => _DropdownListDVState();
}

class _DropdownListDVState extends State<DropdownListDV> {
  @override
  Widget build(BuildContext context) {
    String dropdownValue = listDV.first;
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.black),
      underline: Container(
        height: 2,
        color: Colors.black,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },
      items: listDV.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

class CreditSection extends StatefulWidget {
  const CreditSection({super.key});

  @override
  State<CreditSection> createState() => _CreditSectionState();
}

class _CreditSectionState extends State<CreditSection> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: const <Widget>[
          Text(
              'H??? th???ng H??? tr??? & G???i ki???m m???c ????? h??i l??ng\nkh??ch h??ng c??c h??? th???ng CNTT - VNPT S??n La',
              textAlign: TextAlign.center),
          Text('Copyright ?? VNPT S??n La'),
        ]),
      ),
    );
  }
}

class WelcomeSection extends StatefulWidget {
  const WelcomeSection({super.key});

  @override
  State<WelcomeSection> createState() => _WelcomeSectionState();
}

class _WelcomeSectionState extends State<WelcomeSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Column(children: const <Widget>[
            SizedBox(height: 20),
            Text(
                'Ch???c n??ng c???a Nh??n vi??n h??? tr???:\nL??u l???i th??ng tin v??? cu???c g???i ???? h??? tr??? kh??ch h??ng g???m: H??? v?? t??n, s??? ??i???n tho???i, d???ch v??? h??? tr???, t??n ????n v??? c???a kh??ch h??ng.', textAlign: TextAlign.justify),
            SizedBox(height: 20),
            Text(
                'Ch???c n??ng c???a Nh??n vi??n ch??m s??c kh??ch h??ng: \nG???i ki???m ????? h??i l??ng c???a kh??ch h??ng d???a tr??n c??c cu???c g???i c???a nh??n vi??n h??? tr???.', textAlign: TextAlign.justify),
            SizedBox(height: 20),
            Text('Xin m???i ch???n c??c ch???c n??ng b??n tr??i m??n h??nh!'),
          ]),
        ));
  }
}


TextEditingController userNameCtl = TextEditingController();
TextEditingController passWordCtl = TextEditingController();

field(TextEditingController controller, Icon icon, String label) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blue)),
    child: TextField(
        controller: controller,
        //onChanged: onchange,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, left: 20),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          suffixIcon: icon,
          labelText: label,
          labelStyle:
              const TextStyle(fontSize: 14, decoration: TextDecoration.none),
        )),
  );
}

fieldpw(TextEditingController controller, Icon icon, String label) {
  return Container(
    decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 5.0,
          ),
        ],
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.blue)),
    child: TextField(
        controller: controller,
        //onChanged: onchange,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(top: 8, left: 20),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          border: InputBorder.none,
          suffixIcon: icon,
          labelText: label,
          labelStyle:
              const TextStyle(fontSize: 14, decoration: TextDecoration.none),
        )),
  );
}

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        // const SizedBox(height: 10),
        field(userNameCtl, const Icon(Icons.email_outlined),
            "T??n ????ng nh???p (Email t???p ??o??n b??? @vnpt.vn)"),
        const SizedBox(
          height: 10,
        ),
        fieldpw(passWordCtl, const Icon(Icons.lock), "M???t kh???u"),
      ]),
    );
  }
}

class ImageSection extends StatefulWidget {
  const ImageSection({super.key});

  @override
  State<ImageSection> createState() => _ImageSectionState();
}

class _ImageSectionState extends State<ImageSection> {
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/vnpt.jpg',
      width: 400,
      height: 240,
      fit: BoxFit.cover,
    );
  }
}

class CuocGoiHoTroSection extends StatefulWidget {
  const CuocGoiHoTroSection({super.key});

  @override
  State<CuocGoiHoTroSection> createState() => _CuocGoiHoTroSectionState();
}

class _CuocGoiHoTroSectionState extends State<CuocGoiHoTroSection> {
  late bool error, sending, success;
  late String msg;

  String phpurlcreatehotro = "${phpurl}createhotro.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = true;
    msg = "";
    getDichVu();
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurlcreatehotro), body: {
      "dichvu_id": iddichvu,
      "ten_khachhang": hotenKHctl.text,
      "sodienthoai": sdtctl.text,
      "account": accountctl.text,
      "ten_donvi": donVictl.text,
      "noidung": noiDungctl.text,
      "ghichu": ghiChuctl.text,
      "trangthai": trangthai,
      "user_id": uid,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      var data = json.decode(res.body);
      //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        hotenKHctl.clear();
        accountctl.clear();
        sdtctl.clear();
        donVictl.clear();
        noiDungctl.clear();
        ghiChuctl.clear();
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "C?? l???i khi th???c hi???n g???i d??? li???u.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Visibility(
    //     visible: isLoaded,
    //     replacement: const Center(child: CircularProgressIndicator()),
    // child:
    return Column(children: <Widget>[
      const Text(''),
      Column(
        children: <Widget>[
          const DanhMucDichVuDropdown(),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: hotenKHctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'H??? v?? t??n *',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: sdtctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'S??? ??i???n tho???i *',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: accountctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Account',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: donVictl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: '????n v??? *',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: noiDungctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'N???i dung h??? tr??? *',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.done,
            controller: ghiChuctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Ghi ch??',
            ),
          ),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: Table(
              columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(100),
                1: FixedColumnWidth(20),
                2: FixedColumnWidth(130),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(
                  children: <Widget>[
                    ElevatedButton(
                      // Within the `FirstScreen` widget
                      onPressed: () {
                        trangthai = "1";
                        validate(context);
                        setState(() {
                          sending = true;
                        });
                        sendData();
                        if (success) {
                          const snackBar = SnackBar(
                            content: Text('Th??m th??nh c??ng cu???c g???i'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child:
                          const Text('Ho??n th??nh', textAlign: TextAlign.center),
                    ),
                    const Text(''),
                    ElevatedButton(
                      // Within the `FirstScreen` widget
                      onPressed: () {
                        trangthai = "2";
                        validate(context);
                        setState(() {
                          sending = true;
                        });
                        sendData();
                        if (success) {
                          const snackBar = SnackBar(
                            content: Text('Th??m th??nh c??ng cu???c g???i'),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: const Text(
                        'Ch??a ho??n th??nh',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Column(
            children: const [
              Text('* l?? tr?????ng th??ng tin b???t bu???c'),
              Text('- Ho??n th??nh: L??u cu???c g???i & K???t th??c'),
              Text('- Ch??a ho??n th??nh: L??u cu???c g???i & Ho??n th??nh sau'),
              Text(
                  '- L??u ??: Ng?????i h??? tr??? b??o tr?????c v???i kh??ch h??ng s??? c?? nh??n vi??n g???i ki???m ????? ch??? ?????ng')
            ],
          )
        ],
      )
    ]);
  }
}

class GoiKiemSection extends StatefulWidget {
  const GoiKiemSection({super.key});

  @override
  State<GoiKiemSection> createState() => _GoiKiemSectionState();
}

class _GoiKiemSectionState extends State<GoiKiemSection> {
  late bool error, sending, success;
  late String msg;

  String phpurlcreatehotro = "${phpurl}createhotro.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = true;
    msg = "";
    super.initState();
  }

  Future<void> sendDataKQ() async {
    var res = await http.post(Uri.parse("${phpurl}createketqua.php"), body: {
      "hotro_id": idhotro,
      "khachhang_id": khachhangid,
      "noidung_id": noidungid,
      "dichvu_id": iddichvu,
      "trangthai": trangthai,
      "ketqua": khaosatctl.text,
      "lydo": lydoctl.text,
      "ketqua2": khaosat2ctl.text,
      "lydo2": lydo2ctl.text,
      "user_id": uid,
    }); //sending post request with header data
    if (res.statusCode == 200) {
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        khaosatctl.clear();
        khaosat2ctl.clear();
        lydoctl.clear();
        lydo2ctl.clear();
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "C?? l???i khi th???c hi???n g???i d??? li???u.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Visibility(
    //     visible: isLoaded,
    //     replacement: const Center(child: CircularProgressIndicator()),
    // child:
    return Column(children: <Widget>[
      const Text(''),
      Column(
        children: <Widget>[
          const TrangThaiDropdown(),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: khaosatctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Kh???o s??t Nh??n vi??n h??? tr??? *',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: lydoctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Ghi ch?? Nh??n vi??n h??? tr???',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: khaosat2ctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Kh???o s??t Ch???t l?????ng d???ch v??? *',
            ),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: lydo2ctl,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Ghi ch?? Ch???t l?????ng d???ch v???',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text("* ??i???n s??? 1 n???u KH H??i l??ng, kh??ng th?? b??? tr???ng"),
          Container(
            padding: const EdgeInsets.all(15.0),
            child: ElevatedButton(
              // Within the `FirstScreen` widget
              onPressed: () {
                validateGoiKiem(context);
                setState(() {
                  sending = true;
                });
                sendDataKQ();
                if (success) {
                  Navigator.pop(context);
                  const snackBar = SnackBar(
                    content: Text('G???i ki???m th??nh c??ng'),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('G???i', textAlign: TextAlign.center),
            ),
          ),
        ],
      ),
    ]);
  }
}

class TrangThaiDropdown extends StatefulWidget {
  const TrangThaiDropdown({super.key});

  @override
  State<TrangThaiDropdown> createState() => _TrangThaiDropdownState();
}

class _TrangThaiDropdownState extends State<TrangThaiDropdown> {


  @override
  void initState() {
   dropdownTrangThaiValue = listTrangThaiNgheMay.first;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownTrangThaiValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownTrangThaiValue = value!;
        });
      },
      items: listTrangThaiNgheMay.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}

validate(BuildContext context) {
  iddichvu =
      dropdownValue.toString().replaceAll(RegExp(r'[^0-9]'), '');
  if (hotenKHctl.text.isEmpty ||
      sdtctl.text.isEmpty ||
      donVictl.toString().isEmpty ||
      noiDungctl.toString().isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 16,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(child: Text('Th??ng b??o')),
              const SizedBox(height: 10),
              const Center(child: Text("Ch??a nh???p ????? th??ng tin!")),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK")))
            ],
          ),
        );
      },
    );
  }
}

validateGoiKiem(BuildContext context) {
  trangthai = dropdownTrangThaiValue.toString().replaceAll(RegExp(r'[^0-9]'), '');
  if (lydo2ctl.text.isEmpty ||
      lydoctl.text.isEmpty ||
      khaosat2ctl.text.isEmpty ||
      khaosatctl.text.isEmpty) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          elevation: 16,
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              const SizedBox(height: 20),
              const Center(child: Text('Th??ng b??o')),
              const SizedBox(height: 10),
              const Center(child: Text("Ch??a nh???p ????? th??ng tin!")),
              Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("OK")))
            ],
          ),
        );
      },
    );
  }
}

class BaoCaoTongHopSection extends StatefulWidget {
  const BaoCaoTongHopSection({super.key});

  @override
  State<BaoCaoTongHopSection> createState() => _BaoCaoTongHopSectionState();
}

class _BaoCaoTongHopSectionState extends State<BaoCaoTongHopSection> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(50),
            1: FixedColumnWidth(50),
            2: FixedColumnWidth(50),
            3: FlexColumnWidth(),
            4: FixedColumnWidth(50),
            5: FixedColumnWidth(50),
            6: FixedColumnWidth(50),
            7: FixedColumnWidth(50),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const <TableRow>[
            TableRow(
              children: <Widget>[
                Text('D???ch v???', textAlign: TextAlign.center),
                Text('Cu???c g???i h??? tr???', textAlign: TextAlign.center),
                Text('Cu???c g???i kh???o s??t', textAlign: TextAlign.center),
                Text('Tr???ng th??i', textAlign: TextAlign.center),
                Text('H??i l??ng h??? tr???', textAlign: TextAlign.center),
                Text('Kh??ng H??i l??ng h??? tr???', textAlign: TextAlign.center),
                Text('H??i l??ng d???ch v???', textAlign: TextAlign.center),
                Text('Kh??ng H??i l??ng d???ch v???', textAlign: TextAlign.center)
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('T???t c???', textAlign: TextAlign.center),
                Text('11', textAlign: TextAlign.center),
                Text('14', textAlign: TextAlign.center),
                Text('Nghe m??y: 5, Kh??ng nghe m??y: 8, Kh??ng th??nh c??ng: 1',
                    textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center)
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('VNPT iOffice', textAlign: TextAlign.center),
                Text('11', textAlign: TextAlign.center),
                Text('14', textAlign: TextAlign.center),
                Text('Nghe m??y: 5, Kh??ng nghe m??y: 8, Kh??ng th??nh c??ng: 1',
                    textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center)
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('VNPT HIS', textAlign: TextAlign.center),
                Text('11', textAlign: TextAlign.center),
                Text('14', textAlign: TextAlign.center),
                Text('Nghe m??y: 5, Kh??ng nghe m??y: 8, Kh??ng th??nh c??ng: 1',
                    textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center)
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('VNPT Portal', textAlign: TextAlign.center),
                Text('11', textAlign: TextAlign.center),
                Text('14', textAlign: TextAlign.center),
                Text('Nghe m??y: 5, Kh??ng nghe m??y: 8, Kh??ng th??nh c??ng: 1',
                    textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center)
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('VNPT Edu', textAlign: TextAlign.center),
                Text('11', textAlign: TextAlign.center),
                Text('14', textAlign: TextAlign.center),
                Text('Nghe m??y: 5, Kh??ng nghe m??y: 8, Kh??ng th??nh c??ng: 1',
                    textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center)
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('VNPT Invoice', textAlign: TextAlign.center),
                Text('11', textAlign: TextAlign.center),
                Text('14', textAlign: TextAlign.center),
                Text('Nghe m??y: 5, Kh??ng nghe m??y: 8, Kh??ng th??nh c??ng: 1',
                    textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center),
                Text('5', textAlign: TextAlign.center),
                Text('0', textAlign: TextAlign.center)
              ],
            ),
          ])
    ]);
  }
}

class BaoCaoChiTietSection extends StatefulWidget {
  const BaoCaoChiTietSection({super.key});

  @override
  State<BaoCaoChiTietSection> createState() => _BaoCaoChiTietSectionState();
}

class _BaoCaoChiTietSectionState extends State<BaoCaoChiTietSection> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(30),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(100),
            3: FixedColumnWidth(100),
            4: FixedColumnWidth(150),
            5: FixedColumnWidth(100),
            6: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const <TableRow>[
            TableRow(
              children: <Widget>[
                Text('STT', textAlign: TextAlign.center),
                Text('Nh??n vi??n g???i ki???m', textAlign: TextAlign.center),
                Text('Kh??ch h??ng', textAlign: TextAlign.center),
                Text('D???ch v???', textAlign: TextAlign.center),
                Text('Tr???ng th??i', textAlign: TextAlign.center),
                Text('????n v???', textAlign: TextAlign.center),
                Text('Th???i gian', textAlign: TextAlign.center),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('1', textAlign: TextAlign.center),
                Text('Qu??ng Th??? Qu???nh', textAlign: TextAlign.center),
                Text('Ch??? D???t', textAlign: TextAlign.center),
                Text('VNPT HIS', textAlign: TextAlign.center),
                Text('NGHE MAY', textAlign: TextAlign.center),
                Text('TYT x?? Bon Ph???ng', textAlign: TextAlign.center),
                Text('17:16:30 05/10/2022', textAlign: TextAlign.center),
              ],
            ),
          ])
    ]);
  }
}

class ThemDVSection extends StatefulWidget {
  const ThemDVSection({super.key});

  @override
  State<ThemDVSection> createState() => _ThemDVSectionState();
}

class _ThemDVSectionState extends State<ThemDVSection> {
  TextEditingController tenDichVuctl = TextEditingController();
  late bool error, sending, success;
  late String msg;

  String phpurlcreate = "${phpurl}createdichvu.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = true;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurlcreate), body: {
      "ten_dichvu": tenDichVuctl.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        tenDichVuctl.text = "";
        //after write success, make fields empty
        getDichVu();
        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "C?? l???i khi th???c hi???n g???i d??? li???u.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //enable scrolling, when keyboard appears,
        // hight becomes small, so prevent overflow
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(error ? msg : "Nh???p t??n d???ch v???"),

                // Text(success ? "Th??m th??nh c??ng" : ""),

                TextField(
                  controller: tenDichVuctl,
                  decoration: const InputDecoration(
                    labelText: "T??n d???ch v???:",
                  ),
                ), //text input for name
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            if (tenDichVuctl.text.isNotEmpty) {
                              //if button is pressed, setstate sending = true, so that we can show "sending..."
                              setState(() {
                                sending = true;
                              });
                              sendData();
                              if (success) {
                                getDichVu();
                                Timer(const Duration(seconds: 1), () {
                                  Navigator.pushNamed(context, '/DanhMucDV');
                                  const snackBar = SnackBar(
                                    content: Text('Th??m th??nh c??ng d???ch v???'),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                });
                              }
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Kh??ng ???????c ????? n???i dung tr???ng!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            sending ? "??ang th???c hi???n..." : "Th??m",
                            //if sending == true then show "Sending" else show "SEND DATA";
                          ),
                          //background of button is darker color, so set brightness to dark
                        ))))
              ],
            )));
  }
}

class ThemUserSection extends StatefulWidget {
  const ThemUserSection({super.key});

  @override
  State<ThemUserSection> createState() => _ThemUserSectionState();
}

class _ThemUserSectionState extends State<ThemUserSection> {
  TextEditingController tenUserCtl = TextEditingController();
  TextEditingController emailUserCtl = TextEditingController();
  TextEditingController pwUserCtl = TextEditingController();
  late bool error, sending, success;
  late String msg;

  String phpurlcreate = "${phpurl}createuser.php";

  @override
  void initState() {
    error = false;
    sending = false;
    success = true;
    msg = "";
    super.initState();
  }

  Future<void> sendData() async {
    var res = await http.post(Uri.parse(phpurlcreate), body: {
      "name": tenUserCtl.text,
      "email": emailUserCtl.text,
      "password": pwUserCtl.text,
    }); //sending post request with header data

    if (res.statusCode == 200) {
      var data = json.decode(res.body); //decoding json to array
      if (data["error"]) {
        setState(() {
          //refresh the UI when error is recieved from server
          sending = false;
          error = true;
          msg = data["message"]; //error message from server
        });
      } else {
        tenUserCtl.text = "";
        emailUserCtl.text = "";
        pwUserCtl.text = "";
        getUser();
        //after write success, make fields empty

        setState(() {
          sending = false;
          success = true; //mark success and refresh UI with setState
        });
      }
    } else {
      //there is error
      setState(() {
        error = true;
        msg = "C?? l???i khi th???c hi???n g???i d??? li???u.";
        sending = false;
        //mark error and refresh UI with setState
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        //enable scrolling, when keyboard appears,
        // hight becomes small, so prevent overflow
        child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Text(error ? msg : "T???o ng?????i d??ng m???i"),
                // Text(success ? "Th??m th??nh c??ng" : ""),
                TextField(
                  controller: tenUserCtl,
                  decoration: const InputDecoration(
                    labelText: "T??n ng?????i d??ng:",
                  ),
                ), //text input for name
                TextField(
                  controller: emailUserCtl,
                  decoration: const InputDecoration(
                    labelText: "Email:",
                  ),
                ),
                TextField(
                  controller: pwUserCtl,
                  decoration: const InputDecoration(
                    labelText: "M???t kh???u:",
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                        width: double.infinity,
                        child: Center(
                            child: ElevatedButton(
                          onPressed: () {
                            if (tenUserCtl.text.isNotEmpty ||
                                emailUserCtl.text.isNotEmpty ||
                                pwUserCtl.text.isNotEmpty) {
                              //if button is pressed, setstate sending = true, so that we can show "sending..."
                              setState(() {
                                sending = true;
                              });
                              sendData();
                              if (success) {
                                getDichVu();
                                Navigator.pushNamed(context, '/Admin');
                                const snackBar = SnackBar(
                                  content: Text('Th??m th??nh c??ng ng?????i d??ng'),
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            } else {
                              const snackBar = SnackBar(
                                content: Text('Kh??ng ???????c ????? n???i dung tr???ng!'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            sending ? "??ang th???c hi???n..." : "Th??m",
                            //if sending == true then show "Sending" else show "SEND DATA";
                          ),
                          //background of button is darker color, so set brightness to dark
                        ))))
              ],
            )));
  }
}

class NHCauHoiSection extends StatefulWidget {
  const NHCauHoiSection({super.key});

  @override
  State<NHCauHoiSection> createState() => _NHCauHoiSectionState();
}

class _NHCauHoiSectionState extends State<NHCauHoiSection> {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Table(
          border: TableBorder.all(),
          columnWidths: const <int, TableColumnWidth>{
            0: FixedColumnWidth(30),
            1: FixedColumnWidth(120),
            2: FixedColumnWidth(100),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: const <TableRow>[
            TableRow(
              children: <Widget>[
                Text('STT', textAlign: TextAlign.center),
                Text('N???i dung', textAlign: TextAlign.center),
                Text('D???ch v???', textAlign: TextAlign.center),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(
                color: Colors.grey,
              ),
              children: <Widget>[
                Text('', textAlign: TextAlign.center),
                Text('', textAlign: TextAlign.center),
                Text('', textAlign: TextAlign.center),
              ],
            ),
          ])
    ]);
  }
}
