import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends StatefulWidget {
  const AppLogo({super.key});

  @override
  State<AppLogo> createState() => _AppLogoState();
}

class _AppLogoState extends State<AppLogo> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset("assets/svgs/logo.svg"),
        const SizedBox(
          width: 10,
        ),
        const Text(
          "Workroom",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(
              0xFF3A89FF,
            ),
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
