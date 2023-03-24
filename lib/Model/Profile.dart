// ignore_for_file: file_names, prefer_interpolation_to_compose_strings, avoid_print, non_constant_identifier_names
import 'dart:convert';

import 'package:path_provider/path_provider.dart' as pathProvider;
import 'dart:io';

class ModelProfile {
  String name; // Имя профиля
  String hCode; // хеш
  double sum; // Общий итог бюджета
  String pass;

  ModelProfile({
    required this.name,
    required this.hCode,
    required this.sum,
    required this.pass,
  });
  Map<String, dynamic> toJson() => {
        'name': name,
        'hCode': hCode,
        'SUM': sum,
        'password': pass,
      };

  static ModelProfile fromJson(Map<String, dynamic> json) => ModelProfile(
      name: json['name'],
      hCode: json['hCode'],
      sum: json['SUM'],
      pass: json['password']);
}

Future isJson() async {
  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/data.json';
  final file = File(fileDirectory);
  print(fileDirectory + '/=/' + file.path);
  final isExist = await file.exists();
  print("file found: $isExist");
  final res = await file.readAsString();
  print(res);
  return isExist;
}

void getJson() async {
  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/data.json';
  final file = File(fileDirectory);

  final json = jsonDecode(await file.readAsString());

  print(json);
  ModelProfile profile = ModelProfile.fromJson(json['user']);
  print("code = ${profile.hCode}");
}

void PushToJson(String name, String hCode, String pass, double sum) async {
  final directory = await pathProvider.getApplicationSupportDirectory();
  final fileDirectory = directory.path + '/data.json';
  final file = File(fileDirectory);
  String profileJson =
      '"user" : {"name" : "${name}", "hCode" : "${hCode}", "SUM" : "${sum}", "password" : "${pass}"';
  await file.writeAsString(profileJson);
  final res = await file.readAsString();
  print("created json: $res");
}
