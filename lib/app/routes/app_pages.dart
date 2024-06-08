import 'package:get/get.dart';

import '../modules/absen_page/bindings/absen_page_binding.dart';
import '../modules/absen_page/views/absen_page_view.dart';
import '../modules/anggota_tim/bindings/anggota_tim_binding.dart';
import '../modules/anggota_tim/views/anggota_tim_view.dart';
import '../modules/authentication/bindings/authentication_binding.dart';
import '../modules/authentication/views/authentication_view.dart';
import '../modules/authentication/views/login_view.dart';
import '../modules/capture_attendance/bindings/capture_attendance_binding.dart';
import '../modules/capture_attendance/views/capture_attendance_view.dart';
import '../modules/cuti_page/bindings/cuti_page_binding.dart';
import '../modules/cuti_page/views/cuti_page_view.dart';
import '../modules/daftar_absensi_page/bindings/daftar_absensi_page_binding.dart';
import '../modules/daftar_absensi_page/views/daftar_absensi_page_view.dart';
import '../modules/daftar_absensi_page/views/pengajuan_absensi_view.dart';
import '../modules/detail_karyawan/bindings/detail_karyawan_binding.dart';
import '../modules/detail_karyawan/views/detail_karyawan_view.dart';
import '../modules/detail_pengumuman/bindings/detail_pengumuman_binding.dart';
import '../modules/detail_pengumuman/views/detail_pengumuman_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/izin_kembali_page/bindings/izin_kembali_page_binding.dart';
import '../modules/izin_kembali_page/views/izin_kembali_page_view.dart';
import '../modules/locations/bindings/locations_page_binding.dart';
import '../modules/locations/views/locations_page_view.dart';
import '../modules/persetujuan_page/bindings/persetujuan_page_binding.dart';
import '../modules/persetujuan_page/views/persetujuan_page_view.dart';
import '../modules/reimbursement_page/bindings/reimbursement_page_binding.dart';
import '../modules/reimbursement_page/views/reimbursement_page_view.dart';
import '../modules/slip_gaji_page/bindings/slip_gaji_page_binding.dart';
import '../modules/slip_gaji_page/views/slip_gaji_page_view.dart';
import '../modules/telat_masuk_page/bindings/telat_masuk_page_binding.dart';
import '../modules/telat_masuk_page/views/telat_masuk_page_view.dart';
import '../modules/validator_pin/bindings/validator_pin_binding.dart';
import '../modules/validator_pin/views/validator_pin_view.dart';
import '../shared/detail_info_absensi_view.dart';
import '../shared/splash.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SLIDER_PAGE;
  // static const INITIAL = "/splash-page";

  static final routes = [
    GetPage(
      name: '/pengajuan-absensi',
      page: () => PengajuanAbsensiView(),
    ),
    GetPage(
      name: "/splash-page",
      page: () => SplashPageView(),
    ),
    GetPage(
      name: "/detail-info-absensi-view",
      page: () => DetailInfoAbsensiView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_PAGE,
      page: () => const AbsenPageView(),
      binding: AbsenPageBinding(),
    ),
    GetPage(
      name: _Paths.DAFTAR_ABSENSI_PAGE,
      page: () => DaftarAbsensiPageView(),
      binding: DaftarAbsensiPageBinding(),
    ),
    GetPage(
      name: _Paths.CUTI_PAGE,
      page: () => CutiPageView(),
      binding: CutiPageBinding(),
    ),
    GetPage(
      name: _Paths.VALIDATOR_PIN,
      page: () => ValidatorPinView(),
      binding: ValidatorPinBinding(),
    ),
    GetPage(
      name: _Paths.SLIP_GAJI_PAGE,
      page: () => SlipGajiPageView(),
      binding: SlipGajiPageBinding(),
    ),
    GetPage(
      name: _Paths.PERSETUJUAN_PAGE,
      page: () => const PersetujuanPageView(),
      binding: PersetujuanPageBinding(),
    ),
    GetPage(
      name: _Paths.TELAT_MASUK_PAGE,
      page: () => TelatMasukPageView(),
      binding: TelatMasukPageBinding(),
    ),
    GetPage(
      name: _Paths.REIMBURSEMENT_PAGE,
      page: () => const ReimbursementPageView(),
      binding: ReimbursementPageBinding(),
    ),
    GetPage(
      name: _Paths.ANGGOTA_TIM,
      page: () => const AnggotaTimView(),
      binding: AnggotaTimBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PENGUMUMAN,
      page: () => const DetailPengumumanView(),
      binding: DetailPengumumanBinding(),
    ),
    GetPage(
      name: _Paths.IZIN_KEMBALI_PAGE,
      page: () => IzinKembaliPageView(),
      binding: IzinKembaliPageBinding(),
    ),
    GetPage(
      name: _Paths.LOCATIONS_PAGE,
      page: () => const LocationsPageView(),
      binding: LocationsPageBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_KARYAWAN,
      page: () => const DetailKaryawanView(),
      binding: DetailKaryawanBinding(),
    ),
    GetPage(
      name: _Paths.AUTHENTICATION,
      page: () => const AuthenticationView(),
      binding: AuthenticationBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CAPTURE_ATTENDANCE,
      page: () => const CaptureAttendanceView(),
      binding: CaptureAttendanceBinding(),
    ),
  ];
}
