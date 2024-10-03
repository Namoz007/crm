import 'package:dars_81_home/services/dio_file.dart';

class WorkingServices{
  final _dio = DioFile.getInstance().dio;

  Future<void> getMyWorkingHour() async{
    // final response = await _dio.get("/working-hours");
  }

  Future<void> updateWorkinHour() async{}
}