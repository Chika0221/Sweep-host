import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class WaveFrame extends HookConsumerWidget {
  const WaveFrame({
    super.key,
    required this.colors,
    required this.durations,
    required this.heightPercentages,
    required this.child,
  });

  final List<Color> colors;
  final List<int> durations;
  final List<double> heightPercentages;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Expanded(
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: WaveWidget(
                config: CustomConfig(
                  colors: colors,
                  durations: durations,
                  heightPercentages: heightPercentages,
                ),
                size: Size(double.infinity, 100),
                waveAmplitude: 0,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
