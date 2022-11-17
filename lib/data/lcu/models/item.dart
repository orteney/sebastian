// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

/// Example
/// {
///     "id": 1001,
///     "name": "Ботинки",
///     "description": "<mainText><stats><attention> 25</attention> скорости передвижения</stats></mainText><br>",
///     "active": false,
///     "inStore": true,
///     "from": [],
///     "to": [
///         3110,
///         3004,
///         3006,
///         3011,
///         3046,
///         3116,
///         3157
///     ],
///     "categories": [
///         "Boots"
///     ],
///     "maxStacks": 1,
///     "requiredChampion": "",
///     "requiredAlly": "",
///     "requiredBuffCurrencyName": "",
///     "requiredBuffCurrencyCost": 0,
///     "specialRecipe": 0,
///     "isEnchantment": false,
///     "price": 300,
///     "priceTotal": 300,
///     "iconPath": "/lol-game-data/assets/ASSETS/Items/Icons2D/1001_Class_T1_BootsofSpeed.png"
/// }
@JsonSerializable(createToJson: false)
class Item {
  final int id;
  final String name;
  final String iconPath;

  const Item(
    this.id,
    this.name,
    this.iconPath,
  );

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
