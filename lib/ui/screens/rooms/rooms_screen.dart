import 'package:dars_81_home/bloc/room_bloc/room_bloc.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_event.dart';
import 'package:dars_81_home/bloc/room_bloc/room_bloc_state.dart';
import 'package:dars_81_home/main.dart';
import 'package:dars_81_home/ui/widgets/dashboard/custom_drawer.dart';
import 'package:dars_81_home/ui/widgets/room_scree/add_room.dart';
import 'package:dars_81_home/ui/widgets/room_scree/show_room.dart';
import 'package:dars_81_home/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class RoomsScreen extends StatefulWidget {
  const RoomsScreen({super.key});

  @override
  State<RoomsScreen> createState() => _RoomsScreenState();
}

class _RoomsScreenState extends State<RoomsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(GetAllRoomBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rooms"),
        centerTitle: true,
        actions: [
          AppUtils.userModel!.roleId == 3
              ? InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => const AddRoom(),
                      isDismissible: false,
                      isScrollControlled: true,
                    );
                  },
                  child: const Icon(Icons.add),
                )
              : const SizedBox(),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: RefreshIndicator(
        child: BlocBuilder<RoomBloc, RoomBlocState>(
          builder: (context, state) {
            if (state is LoadingRoomBlocState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      width: double.infinity,
                      height: 250,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20,
                        ),
                        color: Colors.white,
                        border: Border.all(color: Colors.black, width: 20),
                      ),
                    ),
                  );
                },
              );
            }

            if (state is LoadedRoomsRoomBlocState) {
              return state.rooms.isEmpty
                  ? const Center(
                      child: Text("Rooms not found"),
                    )
                  : ListView.builder(
                      itemCount: state.rooms.length,
                      itemBuilder: (context, index) {
                        final _room = state.rooms[index];
                        return Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: ShowRoom(room: _room),
                        );
                      },
                    );
            }

            return Container();
          },
        ),
        onRefresh: () async {
          context.read<RoomBloc>().add(GetAllServicesRoomBlocEvent());
        },
      ),
    );
  }
}
