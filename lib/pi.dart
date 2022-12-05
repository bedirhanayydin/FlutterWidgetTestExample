// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

import 'calculator.dart';

class Pi extends StatelessWidget {
  final Calculator calculator;
  const Pi({
    super.key,
    required this.calculator,
  });
  @override
  Widget build(BuildContext context) {
    String? result;
    return StreamBuilder(
      stream: calculator.pi(),
      initialData: null,
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          result = snapshot.data.toString();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              result != null ? 'The latest known value of pi is $result' : 'Calculating pi...',
              key: const Key('StreamText'),
            )
          ],
        );
      },
    );
  }
}
