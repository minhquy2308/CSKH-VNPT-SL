import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vnptsl/dich_vu.dart';
import 'package:vnptsl/ho_tro.dart';
import 'package:vnptsl/ketqua.dart';
import 'login.dart';
import 'screen.dart';
import 'user.dart';
// Uncomment lines 3 and 6 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;
final List<String> dv = [];

Future main() async {
  getDichVu();
  getUser();
  getHotros();
  getKetqua();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft
  ]).then((value) => runApp(
        MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'CSKH VNPT',
          initialRoute: '/',
          routes: {
            '/': (context) => const LoginScreen(),
            '/home': (context) => const HomeScreen(),
            '/BaoCaoTongHop': (context) => const BaoCaoTongHopScreen(),
            '/BaoCaoChiTiet': (context) => const BaoCaoChiTietScreen(),
            '/CuocGoiHoTro': (context) => const CuocGoiHoTroScreen(),
            '/GoiKiem': (context) => const GoiKiemScreen(),
            '/DanhSachCuocGoi': (context) => const DanhSachCuocGoiScreen(),
            '/KetQua': (context) => const KetQuaScreen(),
            '/DanhMucDV': (context) => const DanhMucDVScreen(),
            '/ThemDV': (context) => const ThemDVScreen(),
            '/NHCauHoi': (context) => const NHCauHoiScreen(),
            '/Admin': (context) => const AdminScreen(),
            '/ThemUser': (context) => const ThemUserScreen(),
          },
        ),
      ));
}


