final class Workshift {
  final int id;
  final String name;

  const Workshift(this.id, this.name);

  static const Workshift morning = Workshift(1, '06:00 - 12:00');
  static const Workshift afternoon = Workshift(2, '12:00 - 18:00');
  static const Workshift night = Workshift(3, '18:00 - 22:00');
}
