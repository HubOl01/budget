// ignore_for_file: camel_case_types, file_names, sort_child_properties_last, unnecessary_new

import 'package:budget/Data/dataCategory.dart';
import 'package:budget/main/body.dart';
import 'package:flutter/material.dart';

String category = dropMin.first;

class pageMinus extends StatefulWidget {
  const pageMinus({super.key});

  @override
  State<pageMinus> createState() => _pageMinusState();
}

class _pageMinusState extends State<pageMinus> {
  final TextEditingController controllerNumber = TextEditingController();
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Расход',
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
                    "-",
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
                      // await Future.delayed(Duration(seconds: 1), () {});
                      setState(() {
                        // dataBudget = dataBudget.reversed.toList();
                      });
                      // Navigator.of(context).pop();
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => body(),
                      //     ));
                      // context.goNamed('home');
                      Navigator.pop(context);
                    },
                    child: const Text("Готово"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
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
      items: dropMin.map<DropdownMenuItem<String>>((String value) {
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
