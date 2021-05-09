import 'package:farmtool/Global/classes/LaborsDoc.dart';
import 'package:farmtool/Global/classes/RentToolsDoc.dart';
import 'package:farmtool/Global/classes/RentVehiclesDoc.dart';
import 'package:farmtool/Global/classes/RentWarehousesDoc.dart';
import 'package:farmtool/Global/classes/SellToolsDoc.dart';
import 'package:farmtool/Global/classes/SellVehiclesDoc.dart';
import 'package:farmtool/Global/variables/Categories.dart';
import 'package:farmtool/Global/variables/ConstantsLabels.dart';
import 'package:farmtool/Global/variables/DurationTypes.dart';
import 'package:farmtool/Global/widgets/DetailItem.dart';
import 'package:farmtool/Global/widgets/DocDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class DetailsPageBuilders {
  static Future<bool?> pushLaborDetailsPage(BuildContext context, LaborsDoc item) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DocDetailsPage(
      docId: item.id, 
      title: item.uidName,
      imageUrls: null,
      buttonLabel: "CALL", 
      onButtonTap: () async => await callPhone(item.uidPhone),
      detailItems: [
        DetailItem(
          icon: Icons.attach_money_rounded,
          label: "WAGES",
          text: "Rs. "+item.wageAmount.toStringAsFixed(0),
        ),
        DetailItem(
          icon: Icons.av_timer_sharp,
          label: "WAGE PAY DURATION",
          text: LaborDurationTypes.data[item.wageDurationType]!,
        ),
        DetailItem(
          icon: Icons.category_rounded,
          label: "CATEGORY",
          text: laborsCategoriesWithAllAsEntry[item.category]!,
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: "DESCTRIPTION",
          text: item.desc,
        ),
      ], 
    )));
  }

  static Future<bool?> pushRentToolDetailsPage(BuildContext context, RentToolsDoc item) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DocDetailsPage(
      docId: item.id, 
      title: item.title,
      imageUrls: item.imageUrls,
      buttonLabel: "CALL", 
      onButtonTap: () async => await callPhone(item.uidPhone),
      detailItems: [
        DetailItem(
          icon: Icons.attach_money_rounded,
          label: RENTTOOLDETAILSPAGE.RENT_PRICE_LABEL,
          text: "Rs. "+item.rentAmount.toStringAsFixed(0),
        ),
        DetailItem(
          icon: Icons.av_timer_sharp,
          label: RENTTOOLDETAILSPAGE.RENT_DURATION_LABEL,
          text: ToolDurationTypes.data[item.rentDurationType]!,
        ),
        DetailItem(
          icon: Icons.category_rounded,
          label: RENTTOOLDETAILSPAGE.CATEGORY_LABEL,
          text: toolsCategories[item.category]!,
        ),
        DetailItem(
          icon: Icons.person,
          label: RENTTOOLDETAILSPAGE.RENTER_NAME_LABEL,
          text: item.uidName,
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: RENTTOOLDETAILSPAGE.DESCRIPTION_LABEL,
          text: item.desc,
        ),
      ], 
    )));
  }

  static Future<bool?> pushSellToolDetailsPage(BuildContext context, SellToolsDoc item) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DocDetailsPage(
      docId: item.id, 
      title: item.title,
      imageUrls: item.imageUrls,
      buttonLabel: "CALL", 
      onButtonTap: () async => await callPhone(item.uidPhone),
      detailItems: [
        DetailItem(
          icon: Icons.attach_money_rounded,
          label: SELLTOOLDETAILSPAGE.SELL_PRICE_LABEL,
          text: "Rs. "+item.sellAmount.toStringAsFixed(0),
        ),
        DetailItem(
          icon: Icons.category_rounded,
          label: SELLTOOLDETAILSPAGE.CATEGORY_LABEL,
          text: toolsCategories[item.category]!,
        ),
        DetailItem(
          icon: Icons.person,
          label: SELLTOOLDETAILSPAGE.SELLER_NAME_LABEL,
          text: item.uidName,
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: SELLTOOLDETAILSPAGE.DESCRIPTION_LABEL,
          text: item.desc,
        ),
      ], 
    )));
  }

  static Future<bool?> pushRentVehicleDetailsPage(BuildContext context, RentVehiclesDoc item) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DocDetailsPage(
      docId: item.id, 
      title: item.title,
      imageUrls: item.imageUrls,
      buttonLabel: "CALL", 
      onButtonTap: () async => await callPhone(item.uidPhone),
      detailItems: [
        DetailItem(
          icon: Icons.av_timer_sharp,
          label: RENTVEHICLEDETAILSPAGE.RENTER_NAME_LABEL,
          text: "Rs. "+item.rentAmount.toStringAsFixed(0),
        ),
        DetailItem(
          icon: Icons.av_timer_sharp,
          label: RENTVEHICLEDETAILSPAGE.RENT_DURATION_LABEL,
          text: ToolDurationTypes.data[item.rentDurationType]!,
        ),
        DetailItem(
          icon: Icons.category_rounded,
          label: RENTVEHICLEDETAILSPAGE.CATEGORY_LABEL,
          text: vehiclesCategories[item.category]!
        ),
        DetailItem(
          icon: Icons.category_rounded,
          label: RENTVEHICLEDETAILSPAGE.BRAND_LABEL,
          text: item.brand
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: RENTVEHICLEDETAILSPAGE.RENTER_NAME_LABEL,
          text: item.uidName,
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: RENTVEHICLEDETAILSPAGE.DESCRIPTION_LABEL,
          text: item.desc,
        ),
      ], 
    )));
  }

  static Future<bool?> pushSellVehicleDetailsPage(BuildContext context, SellVehiclesDoc item) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DocDetailsPage(
      docId: item.id, 
      title: item.title,
      imageUrls: item.imageUrls,
      buttonLabel: "CALL", 
      onButtonTap: () async => await callPhone(item.uidPhone),
      detailItems: [
        DetailItem(
          icon: Icons.av_timer_sharp,
          label: SELLVEHICLEDETAILSPAGE.SELL_PRICE_LABEL,
          text: "Rs. "+item.sellAmount.toStringAsFixed(0),
        ),
        DetailItem(
          icon: Icons.category_rounded,
          label: SELLVEHICLEDETAILSPAGE.CATEGORY_LABEL,
          text: vehiclesCategories[item.category]!
        ),
        DetailItem(
           icon: Icons.category_rounded,
          label: SELLVEHICLEDETAILSPAGE.BRAND_LABEL,
          text: item.brand
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: SELLVEHICLEDETAILSPAGE.SELLER_NAME_LABEL,
          text: item.uidName,
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: SELLVEHICLEDETAILSPAGE.DESCRIPTION_LABEL,
          text: item.desc,
        ),
      ], 
    )));
  }

  static Future<bool?> pushRentWarehouseDetailsPage(BuildContext context, RentWarehousesDoc item) async {
    return await Navigator.of(context).push(MaterialPageRoute(builder: (_)=> DocDetailsPage(
      docId: item.id, 
      title: item.uidName,
      imageUrls: item.imageUrls,
      buttonLabel: "CALL", 
      onButtonTap: () async => await callPhone(item.uidPhone),
      detailItems: [
        DetailItem(
          icon: Icons.attach_money_rounded,
          label: "RENT PRICE",
          text: "Rs. "+item.rentAmount.toStringAsFixed(0) + (item.rentingType==2 ? " Per Square foot" : ""),
        ),
        DetailItem(
          icon: Icons.av_timer_sharp,
          label: "FOR DURATION",
          text: WarehouseDurationTypes.data[item.rentDurationType]!,
        ),
        DetailItem(
          icon: Icons.category_rounded,
          label: "CATEGORY",
          text: warehousesCategories[item.category]!,
        ),
        DetailItem(
          icon: Icons.square_foot_rounded,
          label: "AREA (PER SQUARE FOOT)",
          text: item.area.toStringAsFixed(0),
        ),
        DetailItem(
          icon: Icons.flip_to_front_sharp,
          label: "LOCATION TYPE",
          text: warehousesLocationTypes[item.locationType]!,
        ),
        DetailItem(
          icon: Icons.person,
          label: RENTTOOLDETAILSPAGE.RENTER_NAME_LABEL,
          text: item.uidName,
        ),
        DetailItem(
          icon: Icons.indeterminate_check_box,
          label: RENTTOOLDETAILSPAGE.DESCRIPTION_LABEL,
          text: item.desc,
        ),
      ], 
    )));
  }

  static callPhone(String phoneNo) async {
    if(await UrlLauncher.canLaunch("tel:"+phoneNo)) {
      UrlLauncher.launch("tel:"+phoneNo);
    }
  }
}