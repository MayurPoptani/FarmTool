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
  0 : TOOLCATEGORIES.ALL_TOOLS.tr() 
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
  0 : VEHICLECATEGORIES.ALL_VEHICLES.tr()
});