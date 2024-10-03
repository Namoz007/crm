import 'package:dars_81_home/data/model/group.dart';
import 'package:dars_81_home/data/model/room_model.dart';
import 'package:dars_81_home/services/room_services.dart';

import '../../services/room_services.dart';

class RoomRepositories{
  final RoomServices _services;

  RoomRepositories({required RoomServices services}) : _services = services;

  Future<void> updateRoom(int id,String name) async{
    await _services.updateRoom(id: id, name: name);
  }

  Future<List<Room>> getAllRooms() async{
    return await _services.getAllGroups();
  }

  Future<void> deleteRoom(int id) async{
    await _services.deleteRoom(id);
  }

  Future<void> createNewRoom(Room room) async{
    await _services.createNewRoom(room);
  }

  Future<List<Room>> getAvailableRooms(int dayId,String startTime,String endTime) async{
    return await _services.getAvailableRooms(dayId, startTime, endTime);
  }
}