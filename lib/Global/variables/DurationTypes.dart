import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:easy_localization/easy_localization.dart';

class ToolDurationTypes {

  static const HOURLY = 1;
  static const DAILY = 2;
  static const WEEKLY = 3;
  static const MONTHLY = 4;

  static Map<int, String> get data => {
    HOURLY : RENTTOOLDURATIONS.PER_HOUR.tr(),
    DAILY : RENTTOOLDURATIONS.PER_DAY.tr(),
    WEEKLY : RENTTOOLDURATIONS.PER_WEEK.tr(),
    MONTHLY : RENTTOOLDURATIONS.PER_MONTH.tr(),
  };

}

class VehicleDurationTypes {

  static const HOURLY = 1;
  static const DAILY = 2;
  static const ACRE = 3;
  
  static Map<int, String> get data => {
    HOURLY : RENTVEHICLEDURATIONS.PER_HOUR.tr(),
    DAILY : RENTVEHICLEDURATIONS.PER_DAY.tr(),
    ACRE : RENTVEHICLEDURATIONS.PER_ACRE.tr(),
  };

}

class WarehouseDurationTypes {

  static const DAILY = 1;
  static const WEEKLY = 2;
  static const MONTHLY = 3;

  static Map<int, String> get data => {
    DAILY : RENTTOOLDURATIONS.PER_DAY.tr(),
    WEEKLY : RENTTOOLDURATIONS.PER_WEEK.tr(),
    MONTHLY : RENTTOOLDURATIONS.PER_MONTH.tr(),
  };

}

class LaborDurationTypes {

  static const HOURLY = 1;
  static const DAILY = 2;
  static const WEEKLY = 3;
  static const MONTHLY = 4;

  static Map<int, String> get data => {
    HOURLY : RENTTOOLDURATIONS.PER_HOUR.tr(),
    DAILY : RENTTOOLDURATIONS.PER_DAY.tr(),
    WEEKLY : RENTTOOLDURATIONS.PER_WEEK.tr(),
    MONTHLY : RENTTOOLDURATIONS.PER_MONTH.tr(),
  };

}

