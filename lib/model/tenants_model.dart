import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class TenantsData extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? tenantId;
  @HiveField(2)
  String? widgetType;
  @HiveField(3)
  String? title;
  @HiveField(4)
  String? subtitle;
  @HiveField(5)
  Data? data;

  TenantsData(
      {this.id,
      this.tenantId,
      this.widgetType,
      this.title,
      this.subtitle,
      this.data});

  TenantsData.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    tenantId = json['tenantId'];
    widgetType = json['widgetType'];
    title = json['title'];
    subtitle = json['subtitle'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tenantId'] = tenantId;
    data['widgetType'] = widgetType;
    data['title'] = title;
    data['subtitle'] = subtitle;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

@HiveType(typeId: 2)
class Data {
  List<Articles>? articles;
  Map<dynamic, dynamic>? absenceData;

  Data({this.articles, this.absenceData});

  Data.fromJson(Map<dynamic, dynamic> json) {
    if (json['articles'] != null) {
      articles = <Articles>[];
      json['articles'].forEach((v) {
        articles!.add(Articles.fromJson(v));
      });
    }
    absenceData = json['absenceData'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (articles != null) {
      data['articles'] = articles!.map((v) => v.toJson()).toList();
    }
    data['absenceData'] = absenceData;
    return data;
  }
}

class Articles {
  String? name;
  num? amount;
  String? currency;

  Articles({this.name, this.amount, this.currency});

  Articles.fromJson(Map<dynamic, dynamic> json) {
    name = json['name'];
    amount = json['amount'] ?? 0.0;
    currency = json['currency'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['name'] = name;
    data['amount'] = amount;
    data['currency'] = currency;
    return data;
  }
}
