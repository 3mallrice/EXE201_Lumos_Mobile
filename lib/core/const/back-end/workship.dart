class Workshift {
  static const int morningBeginTime = 6;
  static const int morningEndTime = 12;
  static const int afternoonBeginTime = 12;
  static const int afternoonEndTime = 18;
  static const int eveningBeginTime = 18;
  static const int eveningEndTime = 22;

  static final Map<int, String> workshiftTime = {
    // 1: '6:00 - 12:00',
    // 2: '12:00 - 18:00',
    // 3: '18:00 - 22:00',
    1: '0$morningBeginTime:00 - $morningEndTime:00',
    2: '$afternoonBeginTime:00 - $afternoonEndTime:00',
    3: '$eveningBeginTime:00 - $eveningEndTime:00',
  };
}
