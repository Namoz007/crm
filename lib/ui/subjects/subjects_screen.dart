import 'package:dars_81_home/bloc/subject_bloc/subject_bloc.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc_event.dart';
import 'package:dars_81_home/bloc/subject_bloc/subject_bloc_state.dart';
import 'package:dars_81_home/ui/widgets/dashboard/custom_drawer.dart';
import 'package:dars_81_home/ui/widgets/subjects/edit_subject.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class SubjectsScreen extends StatefulWidget {
  const SubjectsScreen({super.key});

  @override
  State<SubjectsScreen> createState() => _SubjectsScreenState();
}

class _SubjectsScreenState extends State<SubjectsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectBloc>().add(GetAllSubjectBlocEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: const Text("Subjects"),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => EditSubject(
                        isUpdate: false,
                      ),
                  barrierDismissible: false);
            },
            child: const Icon(
              Icons.add,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: RefreshIndicator(
        child: BlocBuilder<SubjectBloc, SubjectBlocState>(
          builder: (context, state) {
            if (state is LoadingSubjectBlocState) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return Shimmer.fromColors(
                    direction: ShimmerDirection.rtl,
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    child: Container(
                      width: double.infinity,
                      height: 60,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      color: Colors.red,
                    ),
                  );
                },
              );
            }

            if (state is LoadedAllSubjectsSubjectBlocState) {
              return state.subjects.length == 0
                  ? const Center(
                      child: Text(
                        "Subjects not found!",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.subjects.length,
                      itemBuilder: (context, index) {
                        final _subject = state.subjects[index];
                        return ListTile(
                          title: Text(
                            "${_subject.name}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => EditSubject(
                                            isUpdate: true,
                                            subjectModel: _subject,
                                          ),
                                      barrierDismissible: false,);
                                },
                                child: const Icon(
                                  Icons.edit,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              InkWell(
                                onTap: () {
                                  context.read<SubjectBloc>().add(DeleteSubjectBlocEvent(id: _subject.id,),);
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
            }

            if (state is ErrorSubjectBlocState) {
              return Center(
                child: Text(
                  "${state.message}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }

            return Container();
          },
        ),
        onRefresh: () async {
          context
              .read<SubjectBloc>()
              .add(GetAllSubjectsFromServicesSubjectBlocEvent());
        },
      ),
    );
  }
}
