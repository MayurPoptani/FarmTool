class DurationTypes {

  static const HOURLY = 1;
  static const DAILY = 2;
  static const WEEKLY = 3;
  static const MONTHLY = 4;

  static Map<int, String> get data => {
    HOURLY : "Per Hour",
    DAILY : "Per Day",
    WEEKLY : "Per Week",
    MONTHLY :  "Per Month",
  };

}