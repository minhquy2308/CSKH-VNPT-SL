import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'remote_service.dart';

List<Ketqua>? ketquas;

List<Ketqua> ketquaFromJson(String str) =>
    List<Ketqua>.from(json.decode(str).map((x) => Ketqua.fromJson(x)));

String ketquaToJson(List<Ketqua> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ketqua {
  Ketqua({
    required this.tenKhachhang,
    required this.tenCoquan,
    required this.tenDichvu,
    required this.name,
    required this.trangthai,
    required this.createdAt,
    required this.ketqua,
    required this.ketqua2,
    required this.lydo,
    required this.lydo2,
  });

  String tenKhachhang;
  String tenCoquan;
  String tenDichvu;
  String name;
  String trangthai;
  DateTime createdAt;
  String ketqua;
  String ketqua2;
  String lydo;
  String lydo2;

  factory Ketqua.fromJson(Map<String, dynamic> json) => Ketqua(
        tenKhachhang: json["ten_khachhang"],
        tenCoquan: json["ten_coquan"],
        tenDichvu: json["ten_dichvu"],
        name: json["name"],
        trangthai: json["trangthai"],
        createdAt: DateTime.parse(json["created_at"]),
        ketqua: json["ketqua"],
        ketqua2: json["ketqua2"],
        lydo: json["lydo"],
        lydo2: json["lydo2"],
      );

  Map<String, dynamic> toJson() => {
        "ten_khachhang": tenKhachhang,
        "ten_coquan": tenCoquan,
        "ten_dichvu": tenDichvu,
        "name": name,
        "trangthai": trangthai,
        "created_at": createdAt.toIso8601String(),
        "ketqua": ketqua,
        "ketqua2": ketqua2,
        "lydo": lydo,
        "lydo2": lydo2,
      };
}

getKetqua() async {
  ketquas = await RemoteServiceKetQua().getKetQua();
}

class KetQuaSection extends StatefulWidget {
  const KetQuaSection({super.key});

  @override
  State<KetQuaSection> createState() => _KetQuaSectionState();
}

class _KetQuaSectionState extends State<KetQuaSection> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(16),
      child: DataTable2(
          columnSpacing: 6,
          horizontalMargin: 6,
          // minWidth: 600,
          columns: const [
            DataColumn2(label: Text('#'), fixedWidth: 20),
            DataColumn2(label: Text('H??? t??n'), fixedWidth: 80),
            DataColumn2(
              label: Text('C?? quan'),
              size: ColumnSize.L,
            ),
            DataColumn2(label: Text('D???ch\nv???'), fixedWidth: 50),
            DataColumn2(
              label: Text('Ng?????i\nh??? tr???'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('V??o l??c'),
              size: ColumnSize.M,
            ),
            DataColumn2(
              label: Text('G???i \nki???m'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('H??? tr???'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('D???ch v???'),
              size: ColumnSize.S,
            ),
            DataColumn2(
              label: Text('Ghi ch??'),
              size: ColumnSize.L,
            ),
          ],
          rows: List<DataRow>.generate(
              ketquas!.length,
              (index) => DataRow(cells: [
                    DataCell(Text((index + 1).toString())),
                    DataCell(Text(ketquas![index].tenKhachhang)),
                    DataCell(Text(ketquas![index].tenCoquan)),
                    DataCell(Text(ketquas![index].tenDichvu)),
                    DataCell(Text(ketquas![index].name)),
                    DataCell(Text(DateFormat('dd/MM/yyyy HH:mm')
                        .format(ketquas![index].createdAt))),
                    if (ketquas![index].trangthai.toString() == '1')
                      // const DataCell(Text('Nghe m??y')),
                      const DataCell(Icon(Icons.done_all)),
                    if (ketquas![index].trangthai.toString() == '2')
                      // const DataCell(Text('Kh??ng nghe m??y')),
                      const DataCell(Icon(Icons.call_missed)),
                    if (ketquas![index].trangthai.toString() == '3')
                      // const DataCell(Text('Kh??ng th??nh c??ng')),
                      const DataCell(Icon(Icons.close)),
                    ketquas![index].ketqua == '1'
                        ? const DataCell(Text('H??i\nL??ng'))
                        : const DataCell(Text('')),
                    ketquas![index].ketqua2 == '1'
                        ? const DataCell(Text('H??i\nL??ng'))
                        : const DataCell(Text('')),
                    DataCell(Text(
                        'H??? tr???: ${ketquas![index].lydo}\nD???ch v???: ${ketquas![index].lydo2}')),
                  ]))),
    ));
  }
}
