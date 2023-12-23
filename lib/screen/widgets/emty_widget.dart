import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/empty.svg',
          width: 170,
        ),
        const SizedBox(
          height: 22,
        ),
        const Text(
          'هیچ یادداشتی ثبت نشده است',
        ),
      ],
    );
  }
}
