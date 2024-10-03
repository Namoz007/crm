import 'package:dars_81_home/services/working_services.dart';

class WorkingRepositories{
  final WorkingServices _services;

  WorkingRepositories({required WorkingServices services}) : _services = services;

  Future<void> getMyWorkingHour() async{
    await _services.getMyWorkingHour();
  }

  Future<void> updateWorkingHour() async{}
}