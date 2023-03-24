// ignore_for_file: camel_case_types, file_names, sort_child_properties_last, unnecessary_new

import 'package:budget/Data/dataCategory.dart';
import 'package:budget/Data/dataValute.dart';
import 'package:budget/Model/Budget.dart';
import 'package:budget/main/body.dart';
import 'package:budget/main/database.dart';
import 'package:flutter/material.dart';

String category = dropPl.first;

class pagePlus extends StatefulWidget {
  final ModelBudget? model;
  const pagePlus({this.model, super.key});

  @override
  State<pagePlus> createState() => _pagePlusState();
}

class _pagePlusState extends State<pagePlus> {
  final TextEditingController controllerNumber = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  // List<ModelBudget> list = [];

  // @override
  // void dispose() {
  // refresh();
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Прибыль',
          ),
          backgroundColor: Colors.green[800],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _dropButton(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "+",
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 1.0, horizontal: 4.0),
                      child: TextFormField(
                        controller: controllerNumber,
                        decoration: const InputDecoration(
                            border: InputBorder.none, hintText: "0"),
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                        textAlignVertical: TextAlignVertical.bottom,
                      ),
                    ),
                  ),
                  const Text(
                    "руб.",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Flexible(
                child: SizedBox(
                  child: TextField(
                    controller: controllerName,
                    style: const TextStyle(fontSize: 20),
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Введите название оплаты",
                    ),
                  ),
                ),
              ),
              Flexible(
                child: SizedBox(
                  child: TextField(
                    controller: controllerDescription,
                    style: const TextStyle(fontSize: 20),
                    maxLines: 10,
                    // ignore: prefer_const_constructors
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Введите описание",
                    ),
                  ),
                ),
              ),
              SizedBox(
                  width: size.width,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controllerNumber.text != '' &&
                          controllerName.text != '') {
                        ModelBudget? model;
                        setState(() {
                          // final model = ModelBudget(PlMin: PlMin, Number: Number, Valute: Valute, Category: Category, NameNumber: NameNumber, Description: Description, dateTime: dateTime)
                          model = ModelBudget(
                              // id: 5,
                              PlMin: "+",
                              Number: double.parse(controllerNumber.text),
                              Valute: dataValute.first.ValuteShort,
                              Category: category,
                              NameNumber: controllerName.text,
                              Description: controllerDescription.text,
                              dateTime: DateTime.now());
                        });
                        await DBProvider.db.insert(model!);
                      }
                      refresh();
                      Navigator.pop(context);
                      // Navigator.of(context).pop();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => body(),
                      //     ));

                      // context.goNamed('home');
                    },
                    child: const Text("Готово"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  )),
            ],
          ),
        ));
  }
}

class _dropButton extends StatefulWidget {
  const _dropButton();

  @override
  State<_dropButton> createState() => _dropButtonState();
}

class _dropButtonState extends State<_dropButton> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      disabledHint: const Text(
        "Выберите категорию",
        style: TextStyle(fontSize: 20),
      ),
      hint: const Text(
        "Выберите категорию",
        style: TextStyle(fontSize: 20),
      ),
      //style: TextStyle(fontSize: 20),
      value: category,
      elevation: 16,
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          category = value!;
        });
      },
      items: dropPl.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: const TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );
  }
}
