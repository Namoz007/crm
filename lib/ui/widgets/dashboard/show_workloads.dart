import 'package:flutter/material.dart';

class ShowWorkloads extends StatefulWidget {
  const ShowWorkloads({super.key});

  @override
  State<ShowWorkloads> createState() => _ShowWorkloadsState();
}

class _ShowWorkloadsState extends State<ShowWorkloads> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        const WorkloadTitle(),
        const SizedBox(height: 17,),
        GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 6,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.5,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return Container(
              width: 200,
              height: 200,
              color: Colors.red,
            );
          },
        ),
      ],
    );
  }
}

class WorkloadTitle extends StatefulWidget {
  const WorkloadTitle({super.key});

  @override
  State<WorkloadTitle> createState() => _WorkloadTitleState();
}

class _WorkloadTitleState extends State<WorkloadTitle> {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Workload",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        InkWell(
          child: Row(
            children: [
              Text(
                "View all",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF3F8CFF)),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFF3F8CFF),
              )
            ],
          ),
        )
      ],
    );
  }
}
