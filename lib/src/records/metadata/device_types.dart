enum DeviceTypes {
  unknown,
  watch,
  phone,
  scale,
  ring,
  headMounted,
  fitnessBand,
  chestStrap,
  smartDisplay;

  @override
  String toString() {
    switch (this) {
      case DeviceTypes.unknown:
        return 'UNKNOWN';
      case DeviceTypes.watch:
        return 'WATCH';
      case DeviceTypes.phone:
        return 'PHONE';
      case DeviceTypes.scale:
        return 'SCALE';
      case DeviceTypes.ring:
        return 'RING';
      case DeviceTypes.headMounted:
        return 'HEAD_MOUNTED';
      case DeviceTypes.fitnessBand:
        return 'FITNESS_BAND';
      case DeviceTypes.chestStrap:
        return 'CHEST_STRAP';
      case DeviceTypes.smartDisplay:
        return 'SMART_DISPLAY';
    }
  }
}
