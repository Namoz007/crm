import 'package:dars_81_home/data/model/room_model.dart';
import 'package:dars_81_home/services/dio_file.dart';
import 'package:dio/dio.dart';

class RoomServices{

  final _dio = DioFile.getInstance().dio;

  Future<void> updateRoom({required int id, required String name}) async{
    await _dio.put("/rooms/$id",data: {
      "name": name,
    });
  }

  Future<void> createNewRoom(Room room) async {
    final response = await _dio.post("/rooms", data: room.toJson());
  }

  Future<List<Room>> getAllGroups() async{
    List<Room> _rooms = [];
    final response = await _dio.get("/rooms");
    List<dynamic> datas = response.data['data'];
    for(int i = 0;i < datas.length;i++)
      _rooms.add(Room.fromJson(datas[i]));

    return _rooms;
  }
  
  Future<void> deleteRoom(int id) async{
    final response = await _dio.delete("/rooms/$id");
  }

  Future<List<Room>> getAvailableRooms(int dayId,String startTime,String endTime) async{
    try{
      final response = await _dio.get("/available-rooms?day_id=1&start_time=09:00&end_time=12:00",
        queryParameters: {
          "day_id": dayId,
          "start_time": startTime,
          "end_time": endTime,
        },);
      return [for(int i = 0;i < response.data['data'].length;i++) Room.fromJson(response.data['data'][i])];
    }on DioException catch(e){
      print('bu dio xatosi ${e.response?.data}');
      return [];
    }catch(e){
      print("bu oddiy xato ${e}");
      return [];
    }
  }

}
