enum BodyTemperatureMeasurementLocation {
  unknown('unknown'),
  armpit('armpit'),
  finger('finger'),
  forehead('forehead'),
  mouth('mouth'),
  rectum('rectum'),
  temporalArtery('temporal_artery'),
  toe('toe'),
  ear('ear'),
  wrist('wrist'),
  vagina('vagina');

  final String measurementLocation;

  const BodyTemperatureMeasurementLocation(this.measurementLocation);

  @override
  String toString() {
    return measurementLocation;
  }
}
