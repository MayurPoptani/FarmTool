import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:easy_localization/easy_localization.dart';

Map<int, String> get toolsCategories => <int, String>{
  1 : TOOLCATEGORIES.WATER_SPRINKLERS.tr(),
  2 : TOOLCATEGORIES.GARDENING_TOOLS.tr(),
  3 : TOOLCATEGORIES.LAWN_MOVERS.tr(),
  4 : TOOLCATEGORIES.SPRAYERS.tr(),
  5 : TOOLCATEGORIES.WATER_PUMP.tr(),
  6 : TOOLCATEGORIES.DIGGING_TOOLS.tr(),
};

Map<int, String> get toolCategoriesWithAllAsEntry => toolsCategories..addAll({
  0 : TOOLCATEGORIES.ALL_TOOLS.tr(),
});

Map<int, String> get vehiclesCategories => <int,String>{
  1 : VEHICLECATEGORIES.TRACTOR.tr(),
  2 : VEHICLECATEGORIES.HARVESTOR.tr(),
  3 : VEHICLECATEGORIES.JCB.tr(),
  4 : VEHICLECATEGORIES.TEMPO_AND_TRUCK.tr(),
  5 : VEHICLECATEGORIES.CULTIVATOR.tr(),
  6 : VEHICLECATEGORIES.THRESHER.tr(),
  7 : VEHICLECATEGORIES.TROLLEY.tr(),
  8 : VEHICLECATEGORIES.PLOUGH_MACHINE.tr(),
};

Map<int, String> get vehiclesCategoriesWithAllAsEntry => vehiclesCategories..addAll({
  0 : VEHICLECATEGORIES.ALL_VEHICLES.tr(),
});

Map<int, String> get warehousesCategories => <int,String>{
  1 : "Warehouse",
  2 : "Warehouse with Cold Storage",
};

Map<int, String> get warehousesCategoriesWithAllAsEntry => warehousesCategories..addAll({
  0 : "All Warehouses",
});

Map<int, String> get warehousesRentCategories => <int,String>{
  1 : "Whole Warehouse",
  2 : "Per Square Foot",
};

Map<int, String> get warehousesLocationTypes => <int,String>{
  1 : "Above Ground",
  2 : "Under Ground",
};

Map<int, String> get laborsCategories => <int,String>{
  1 : "Working on fields",
  2 : "Handling Cows, Buffalo, etc",
  3 : "Heavy Lifting",
  4 : "Driving",
  5 : "Multiple Tasks"
};

Map<int, String> get laborsCategoriesWithAllAsEntry => laborsCategories..addAll({
  0 : "All Labors",
});