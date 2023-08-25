import 'package:flutter/material.dart';

class BackgoundWidget extends StatelessWidget {
  final Widget child;
  const BackgoundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Color.fromRGBO(243, 229, 105, 0.3), Color(0xffF8F9FB)],
          center: Alignment.topCenter,
          radius: 1, // Ângulo de 360 graus (radiano: 2 * pi)
        ),
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage('assets/noise.png'),
          ),
        ),
        child: child,
      ),
    );
  }
}
