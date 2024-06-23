// ignore_for_file: use_key_in_widget_constructors, camel_case_types, unrelated_type_equality_checks

import 'package:budget/Model/Budget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:intl/intl.dart';
import 'package:budget/main/database.dart';
import '../Data/dataProfile.dart';
import '../Model/Profile.dart';
import '../MyDrawer.dart';

List<ModelBudget> list = [];
String summ = '';
Future refresh() async {
  list = await DBProvider.db.getTable();
  summ = toCurrencyString(bankOperation().toString(),
      thousandSeparator: ThousandSeparator.Space);
}

double bankOperation() {
  if (list.isNotEmpty) {
    double summ = 0;
    for (int i = 0; i < list.length; i++) {
      if (list[i].PlMin == "+") {
        summ += list[i].Number;
      } else if (list[i].PlMin == "-") {
        summ -= list[i].Number;
      }
    }
    summ += dataProfile[0].sum;
    return summ;
  } else {
    return 0;
  }
}

class body extends StatefulWidget {
  @override
  State<body> createState() => _bodyState();
}

class _bodyState extends State<body> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (isJson() == true) {
      getJson();
    } else {
      PushToJson(dataProfile[0].name, dataProfile[0].hCode, dataProfile[0].pass,
          bankOperation());
      getJson();
    }

    refreshLists();
  }

  @override
  void dispose() {
    DBProvider.db.close();

    super.dispose();
  }

  Future refreshLists() async {
    setState(() => isLoading = true);

    await refresh();
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: const MyDrawer(),
      body: SingleChildScrollView(
        child: RefreshIndicator(
          color: Colors.green[800],
          strokeWidth: 4.0,
          onRefresh: () async {
            refresh();
            return Future<void>.delayed(const Duration(seconds: 3));
            // setState(() {});
          },
          child: Column(
            children: [
              SizedBox(
                height: size.height - 50,
                child: ScrollConfiguration(
                  behavior: const ScrollBehavior(),
                  child: GlowingOverscrollIndicator(
                    axisDirection: AxisDirection.down,
                    color: Colors.green[800]!,
                    // child: widget(
                    child: CustomScrollView(
                        scrollDirection: Axis.vertical,
                        slivers: [
                          SliverAppBar(
                            backgroundColor: Colors.green[800],
                            floating: false,
                            pinned: true,
                            centerTitle: true,

                            // title: const Text('Главная'),
                            expandedHeight: size.height * 0.3,
                            flexibleSpace: FlexibleSpaceBar(
                              titlePadding: const EdgeInsets.only(top: 20),
                              centerTitle: true,
                              title: SizedBox(
                                height: size.height * 0.205,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Text(summ, textAlign: TextAlign.center),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          isLoading
                              ? SliverFillRemaining(
                                  child: Center(
                                      child: CircularProgressIndicator()))
                              : list.isEmpty
                                  ? SliverFillRemaining(
                                      child: Center(
                                        child: Text("Пусто"),
                                      ),
                                    )
                                  :

                                  // child: SizedBox(
                                  //   height: size.height,
                                  SliverList(
                                      // shrinkWrap: false,
                                      // initialItemCount:list.length,
                                      delegate: SliverChildBuilderDelegate(
                                        // childCount: ,
                                        childCount: list.length,

                                        (context, index) => Card(
                                          elevation: 10,
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, "/infoPage",
                                                  arguments: {
                                                    "id": list[index].id!
                                                  });
                                              // Navigator.of(context)
                                              //     .push(MaterialPageRoute(
                                              //   builder: (context) =>
                                              //       infoPage(id: list[index].id!),
                                              // ));
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(20),
                                              child: Row(
                                                //mainAxisAlignment: MainAxisAlignment.start,
                                                //crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        list[index].PlMin,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: list[index]
                                                                        .PlMin ==
                                                                    "+"
                                                                ? Colors.green
                                                                : Colors.red),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        list[index]
                                                            .Number
                                                            .toCurrencyString(),
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: list[index]
                                                                        .PlMin ==
                                                                    "+"
                                                                ? Colors.green
                                                                : Colors.red),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      SizedBox(
                                                        width:
                                                            size.width * 0.4 -
                                                                55,
                                                        child: Text(
                                                          list[index]
                                                              .NameNumber,
                                                          softWrap: false,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 20,
                                                                  color: Colors
                                                                      .black54),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  // ignore: prefer_const_literals_to_create_immutables
                                                  // ignore: prefer_const_constructors
                                                  SizedBox(
                                                    width: 55,
                                                    child: Text(
                                                      // "",
                                                      DateFormat('dd/MM/yyyy')
                                                          .format(list[index]
                                                              .dateTime),
                                                      style: const TextStyle(
                                                          fontSize: 10),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),

                          // SliverFillRemaining(

                          // child: Center(
                          //   child: isLoading
                          //       ? CircularProgressIndicator()
                          //       : list.isEmpty
                          //           ? Text(
                          //               'No Lists',
                          //               style:
                          //                   TextStyle(color: Colors.black, fontSize: 24),
                          //   ListView.builder(
                          //     primary: false,
                          //     shrinkWrap: true,
                          //     physics: const ClampingScrollPhysics(),
                        ]),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // context.go(context.namedLocation('pageMinus'));

                              Navigator.pushNamed(context, "/pageMinus");
                              // Navigator.push(
                              //     context,
                              //     );
                            },
                            // MaterialPageRoute(
                            //     builder: (context) => const pageMinus()));,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: const Text('-'),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                // context.go(context.namedLocation('pagePlus'));
                                // Navigator.of(context).push(MaterialPageRoute(
                                //   builder: (context) => pagePlus(),
                                // ));
                                Navigator.pushNamed(context, "/pagePlus");
                              },
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => const pagePlus()));

                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: const Text('+')),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
