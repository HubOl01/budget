// ignore_for_file: non_constant_identifier_names, camel_case_types, file_names

import 'package:budget/Model/Budget.dart';
import 'package:budget/main/body.dart';
import 'package:budget/main/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/formatters/formatter_utils.dart';
import 'package:flutter_multi_formatter/formatters/money_input_enums.dart';
import 'package:intl/intl.dart';

ModelBudget? list;
class infoPage extends StatefulWidget {
  final int id;

  const infoPage({required this.id, super.key});

  @override
  State<infoPage> createState() => _infoPageState();
}

class _infoPageState extends State<infoPage> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    
    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    list = await DBProvider.db.readModel(widget.id);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    // final df = DateFormat.yMMMd();

    // DateTime dateTime = df.parse(dateTimeS);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Подробная информация"),
        backgroundColor: Colors.green[800],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(children: [
              Container(
                height: size.height * 0.3,
              ),
              Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        list!.PlMin,
                        style: TextStyle(
                            fontSize: 20,
                            color:
                                list!.PlMin == "+" ? Colors.green : Colors.red),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        toCurrencyString(list!.Number.toString(),
                            thousandSeparator: ThousandSeparator.Space),
                        style: list!.PlMin == "+"
                            ? TextStyle(fontSize: 30, color: Colors.green)
                            : TextStyle(fontSize: 30, color: Colors.red),
                      ),
                    ],
                  ))
            ]),
            Table(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // mainAxisSize: MainAxisSize.min,
              children: [
                TableRow(
                  // mainAxisSize: MainAxisSize.min,
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Категория",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      softWrap: true,
                      list!.Category,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                TableRow(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  // mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Название",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      softWrap: true,
                      list!.NameNumber,
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
                TableRow(children: [
                  Text(
                    "Описание",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    list!.Description,
                    style: TextStyle(fontSize: 20),
                    // maxLines: 10,
                    softWrap: true,
                    // overflow: TextOverflow.ellipsis,
                  ),
                ]),
                TableRow(children: [
                  Text(
                    "Время",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    softWrap: true,
                    DateFormat('hh:mm (ss)').format(list!.dateTime),
                    style: const TextStyle(fontSize: 20),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    "Дата",
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text(
                    softWrap: true,
                    DateFormat('dd/MM/yyyy').format(list!.dateTime),
                    style: const TextStyle(fontSize: 20),
                  ),
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
