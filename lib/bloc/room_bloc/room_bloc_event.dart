import 'package:dars_81_home/data/model/room_model.dart';

sealed class RoomBlocEvent {}

final class GetAllRoomBlocEvent extends RoomBlocEvent {}

final class GetAllServicesRoomBlocEvent extends RoomBlocEvent {}

final class DeleteRoomBlocEvent extends RoomBlocEvent {
  int id;

  DeleteRoomBlocEvent(this.id);
}

final class UpdateRoomBlocEvent extends RoomBlocEvent {
  int id;
  String name;

  UpdateRoomBlocEvent({
    required this.id,
    required this.name,
  });
}

final class CreateNewRoomBlocEvent extends RoomBlocEvent{
  Room room;

  CreateNewRoomBlocEvent(this.room);
}

final class GetAllAvailableRoomBlocEvent extends RoomBlocEvent{
  int dayId;
  String startTime;
  String endTime;

  GetAllAvailableRoomBlocEvent({required this.dayId,required this.startTime,required this.endTime,});
}