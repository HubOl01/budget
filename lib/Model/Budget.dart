// ignore_for_file: unnecessary_this, non_constant_identifier_names, file_names

class BudgetID {
  static final List<String> values = [
    /// Add all fields
    id, plmin, number, valute, category, nameNumber, description, datetime
  ];

  static final String id = 'id';
  static final String plmin = 'PlMin';
  static final String number = 'Number';
  static final String valute = 'Valute';
  static final String category = 'Category';
  static final String nameNumber = 'NameNumber';
  static final String description = 'Description';
  static final String datetime = 'Datetime';
}

class ModelBudget {
  final int? id; // id для базы данных
  final String PlMin; // знак расхода / дохода
  final double Number; // сумма для расхода / дохода
  final String Valute; // валюта
  final String Category; // Категория
  final String NameNumber; // название расхода / дохода
  final String Description; // Описание на что потратил или получил сумму
  final DateTime dateTime; // дата публикации

  ModelBudget({
    this.id,
    required this.PlMin,
    required this.Number,
    required this.Valute,
    required this.Category,
    required this.NameNumber,
    required this.Description,
    required this.dateTime,
  });

  ModelBudget copy({
    int? id,
    String? PlMin, // знак расхода / дохода
    double? Number, // сумма для расхода / дохода
    String? Valute, // валюта
    String? Category, // Категория
    String? NameNumber, // название расхода / дохода
    String? Description, // Описание на что потратил или получил сумму
    DateTime? dateTime,
  }) =>
      ModelBudget(
          id: id ?? this.id,
          PlMin: PlMin ?? this.PlMin,
          Number: Number ?? this.Number,
          Valute: Valute ?? this.Valute,
          Category: Category ?? this.Category,
          NameNumber: NameNumber ?? this.NameNumber,
          Description: Description ?? this.Description,
          dateTime: dateTime ?? this.dateTime);

  static ModelBudget fromJson(Map<String, Object?> json) => ModelBudget(
      id: json[BudgetID.id] as int?,
      PlMin: json[BudgetID.plmin] as String,
      Number: json[BudgetID.number] as double,
      Valute: json[BudgetID.valute] as String,
      Category: json[BudgetID.category] as String,
      NameNumber: json[BudgetID.nameNumber] as String,
      Description: json[BudgetID.description] as String,
      dateTime: DateTime.parse(json[BudgetID.datetime] as String),
      );

  Map<String, dynamic> toJson() {
    return {
      BudgetID.id: id,
      BudgetID.plmin: PlMin,
      BudgetID.number: Number,
      BudgetID.valute: Valute,
      BudgetID.category: Category,
      BudgetID.nameNumber: NameNumber,
      BudgetID.description: Description,
      BudgetID.datetime: dateTime.toIso8601String(),
    };
  }
  // static Future addBudget({
  //   int? id,
  //   required String PlMin,
  //   required double Number,
  //   required String Valute,
  //   required String Category,
  //   required String NameNumber,
  //   required String Description,
  //   required DateTime dateTime,
  // })async {

  // }
}
