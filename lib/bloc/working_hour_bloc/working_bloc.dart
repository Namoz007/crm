import 'package:bloc/bloc.dart';
import 'package:dars_81_home/bloc/working_hour_bloc/working_bloc_event.dart';
import 'package:dars_81_home/bloc/working_hour_bloc/working_bloc_state.dart';
import 'package:dars_81_home/data/repositories/working_repositories.dart';

class WorkingBloc extends Bloc<WorkingBlocEvent,WorkingBlocState>{
  final WorkingRepositories _repositories;

  WorkingBloc({required WorkingRepositories repo}) : _repositories = repo,super(InitialWorkingBlocState()){
    on<GetMyWorkingBlocEvent>(_getMyWorkingHour);
    on<UpdateWorkingBlocEvent>(_updateWorkingHour);
  }

  void _getMyWorkingHour(GetMyWorkingBlocEvent event,emit) async{
    await _repositories.getMyWorkingHour();
  }

  void _updateWorkingHour(UpdateWorkingBlocEvent event,emit) async{
    emit(LoadingWorkingBlocState());
    await _repositories.updateWorkingHour();
  }
}