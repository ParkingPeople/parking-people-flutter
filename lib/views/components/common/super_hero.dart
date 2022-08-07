import 'package:flutter/material.dart';
import 'package:parking_people_flutter/views/components/common/empty.view.dart';

class SuperHero extends StatelessWidget {
  const SuperHero({
    required this.tag,
    required this.child,
    this.fade = true,
    super.key,
  });

  final String tag;
  final Widget child;
  final bool fade;

  // ignore: long-parameter-list, long-method
  Widget _flightShuttleBuilder(
    BuildContext flightContext,
    Animation<double> animation,
    HeroFlightDirection flightDirection,
    BuildContext fromHeroContext,
    BuildContext toHeroContext,
  ) {
    final fromWidget = (fromHeroContext.widget as Hero).child;
    final toWidget = (toHeroContext.widget as Hero).child;

    final duration =
        MaterialPageRoute(builder: (_) => const Empty()).transitionDuration;
    Widget stackBuilder() => fade
        ? Stack(
            children: [
              if (flightDirection == HeroFlightDirection.push) ...[
                fromWidget,
                Positioned.fill(
                  child: Center(
                    child: SizedBox.expand(
                      child: fade
                          ? AnimatedOpacity(
                              duration: duration,
                              opacity: animation.value,
                              child: toWidget,
                            )
                          : toWidget,
                    ),
                  ),
                ),
              ],
              if (flightDirection == HeroFlightDirection.pop) ...[
                toWidget,
                Positioned.fill(
                  child: Center(
                    child: SizedBox.expand(
                      child: fade
                          ? AnimatedOpacity(
                              duration: duration,
                              opacity: animation.value,
                              child: fromWidget,
                            )
                          : fromWidget,
                    ),
                  ),
                ),
              ],
            ],
          )
        : toWidget;

    return DefaultTextStyle(
      style: DefaultTextStyle.of(toHeroContext).style,
      child: fade
          ? AnimatedBuilder(
              animation: animation,
              builder: (context, _) => stackBuilder(),
            )
          : stackBuilder(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      flightShuttleBuilder: _flightShuttleBuilder,
      child: child,
    );
  }
}
