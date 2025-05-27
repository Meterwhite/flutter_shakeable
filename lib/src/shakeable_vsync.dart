import 'package:flutter/scheduler.dart';

class ShakeableVsync extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'ShakeableVsync');
  }
}
