import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AnimationWithLottie extends StatefulWidget {
  const AnimationWithLottie({super.key});

  @override
  State<AnimationWithLottie> createState() => _AnimationWithLottieState();
}

class _AnimationWithLottieState extends State<AnimationWithLottie>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
// @override 
// void initState(){
//  // _animationController =AnimationController(vsync: this._animationController)
// }

  @override
  Widget build(BuildContext context) {
    const Color color = Color.fromARGB(255, 0, 0, 0);
    const String assetUrl = '';
    return Column(children: [
      Lottie.network(assetUrl, controller: _animationController,
          onLoaded: (composition) {
        _animationController
          ..duration = composition.duration
          ..forward()
          ..repeat();
      }),
    ]);
  }
}