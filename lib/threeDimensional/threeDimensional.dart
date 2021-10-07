import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ThreeDimensional extends StatefulWidget {
  ThreeDimensional({Key key}) : super(key: key);

  @override
  _ThreeDimensionalState createState() => _ThreeDimensionalState();
}

class _ThreeDimensionalState extends State<ThreeDimensional> {
  var gridState = false;
  var stateFirst = true;
  var controllerVelocityX = TextEditingController(
    text: "1.0",
  ); // vx // скорость, позже будет как массив
  var controllerVelocityY = TextEditingController(
    text: "1.0",
  ); // vy // скорость, позже будет как массив
  var controllerVelocityZ = TextEditingController(
    text: "1.0",
  ); // vz // скорость, позже будет как массив
  var controllerPor = TextEditingController(
    text: "0.3",
  );

  // эффективная пористость
  final controllerMassPar =
      TextEditingController(text: "1000"); // Масса частицы
  final controllerAl =
      TextEditingController(text: "1.0"); // Дистерсивность горизонтальная
  final controllerAt =
      TextEditingController(text: "1.0"); // Дистерсивность вертикальная
  final controllerMass = TextEditingController(text: "10"); // масса вещества
  final controlleXRange =
      TextEditingController(text: "100"); // длина расчетной области по X
  final controlleYRange =
      TextEditingController(text: "100"); // длина расчетной области по Y
  final controlleZRange =
      TextEditingController(text: "100"); // длина расчетной области по Z
  final controllerNumberCellX =
      TextEditingController(text: "10"); // количество ячеек по X
  final controllerNumberCellY =
      TextEditingController(text: "10"); // количество ячеек по Y
  final controllerNumberCellZ =
      TextEditingController(text: "10"); // количество ячеек по Z
  final controllerStepTime =
      TextEditingController(text: "100"); // величина временого шага
  final controllerQuantityTimeStep =
      TextEditingController(text: "10"); // количество временных шагов
  final controllerNumberTimeStep =
      TextEditingController(text: "5"); // номер временого шага
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Введите параметры",
              style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                color: Colors.blue,
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height -
                AppBar().preferredSize.height -
                97,
            width: MediaQuery.of(context).size.width - 20,
            child: SingleChildScrollView(
              // clipBehavior: Clip.antiAlias,
              child: Padding(
                padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      if (stateFirst)
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25.0, top: 10.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Скорость фильтрации должна быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerVelocityX,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите скорость фильтрации Vx',
                                    labelText: "Скорость фильтрации Vx [м/сут]",
                                    labelStyle: TextStyle(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))
                                    // errorText: "Пусто или через запятую"
                                    ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25.0, top: 10.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Скорость фильтрации должна быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerVelocityY,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите скорость фильтрации Vy',
                                    labelText: "Скорость фильтрации Vy [м/сут]",
                                    labelStyle: TextStyle(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))
                                    // errorText: "Пусто или через запятую"
                                    ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 25.0, top: 10.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Скорость фильтрации должна быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerVelocityZ,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите скорость фильтрации Vz',
                                    labelText: "Скорость фильтрации Vz [м/сут]",
                                    labelStyle: TextStyle(),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))
                                    // errorText: "Пусто или через запятую"
                                    ),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Эффективная пористость должна быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerPor,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText:
                                        'Введите эффективную пористость [-]',
                                    labelText: "Эффективная пористость [-]",
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(bottom: 25.0),
                            //   child: TextFormField(
                            //     validator: (String value) {
                            //       if (value.isEmpty) {
                            //         return 'Значение не может быть пустым';
                            //       }
                            //       if (double.tryParse(value) == null) {
                            //         return 'Введите число double через точку';
                            //       }
                            //       if (double.parse(value) < 0) {
                            //         return 'Мощность должна быть больше 0';
                            //       }
                            //       return null;
                            //     },
                            //     controller: controllerM,
                            //     textAlign: TextAlign.center,
                            //     decoration: InputDecoration(
                            //         hintText: 'Введите мощность слоя',
                            //         labelText: 'Мощность слоя [м]',
                            //         border: OutlineInputBorder(
                            //             borderRadius:
                            //                 BorderRadius.circular(20.0))),
                            //     keyboardType: TextInputType.numberWithOptions(
                            //         decimal: true),
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Концентрация должна быть меньше 0';
                                  }
                                  return null;
                                },
                                controller: controllerMass,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText:
                                        'Введите начальную концентрацию вещества',
                                    labelText: 'Концентрация вещества [кг/м^3]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }

                                  if (int.parse(value) <= 0) {
                                    return 'Масса частицы должна быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerMassPar,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите массу частицы',
                                    labelText: 'масса частицы частиц [кг/м^3]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: false),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Диспресивность должна быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerAl,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText:
                                        'Введите горизонтальную диспресивность',
                                    labelText:
                                        'Горизоньальная дисперсивность [м]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Диспресивность должна быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerAt,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText:
                                        'Введите вертикальную диспресивность',
                                    labelText:
                                        'Вертикальная дисперсивность [м]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Размер модели должен быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controlleXRange,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите размер модели по X',
                                    labelText: 'Размер модели по X [м]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Размер модели должен быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controlleYRange,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите размер модели по Y',
                                    labelText: 'Размер модели по Y [м]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Размер модели должен быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controlleZRange,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите размер модели по Z',
                                    labelText: 'Размер модели по Z[м]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Введите целое число';
                                  }
                                  if (int.parse(value) < 1) {
                                    return 'Количество количество ячеек должно быть больше 1';
                                  }
                                  return null;
                                },
                                controller: controllerNumberCellX,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите количество ячеек по X',
                                    labelText: 'Количество ячеек по X[-]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Введите целое число';
                                  }
                                  if (int.parse(value) < 1) {
                                    return 'Количество количество ячеек должно быть больше 1';
                                  }
                                  return null;
                                },
                                controller: controllerNumberCellY,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите количество ячеек по Y',
                                    labelText: 'Количество ячеек по Y[-]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Введите целое число';
                                  }
                                  if (int.parse(value) < 1) {
                                    return 'Количество количество ячеек должно быть больше 1';
                                  }
                                  return null;
                                },
                                controller: controllerNumberCellZ,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите количество ячеек по Z',
                                    labelText: 'Количество ячеек по Z [-]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (double.tryParse(value) == null) {
                                    return 'Введите число double через точку';
                                  }
                                  if (double.parse(value) <= 0) {
                                    return 'Временной шаг должен быть больше 0';
                                  }
                                  return null;
                                },
                                controller: controllerStepTime,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите временной шаг',
                                    labelText: 'Временной шаг [сутки]',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                  validator: (String value) {
                                    if (value.isEmpty) {
                                      return 'Значение не может быть пустым';
                                    }
                                    if (int.tryParse(value) == null) {
                                      return 'Введите целое число';
                                    }
                                    if (int.parse(value) < 0) {
                                      return 'Количество временных шагов должно быть больше 0';
                                    }
                                    return null;
                                  },
                                  controller: controllerQuantityTimeStep,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                      hintText:
                                          'Введите количество временных шагов',
                                      labelText:
                                          'Количество временных шагов [-]',
                                      border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 25.0),
                              child: TextFormField(
                                validator: (String value) {
                                  if (value.isEmpty) {
                                    return 'Значение не может быть пустым';
                                  }
                                  if (int.tryParse(value) == null) {
                                    return 'Введите целое число';
                                  }
                                  if (int.parse(value) >=
                                          int.parse(controllerQuantityTimeStep
                                              .text) ||
                                      int.parse(value) < 0) {
                                    return 'Действующий временной шаг должен быть больше нуля и меньше общего количества временных';
                                  }
                                  return null;
                                },
                                controller: controllerNumberTimeStep,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                    hintText: 'Введите номер временного шага',
                                    labelText: 'Номер временного шага ',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0))),
                              ),
                            ),
                          ],
                        ),
                      TextButton(
                        onPressed: () {
                          _formKey.currentState.validate();
                          // firstDimensional();
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              gridState = true;
                              stateFirst = false;
                            });
                          }
                        },
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          side: BorderSide(
                            color: Colors.red,
                            style: BorderStyle.solid,
                          ),
                        ))),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Расчитать трехмерный",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              // fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      if (gridState)
                        Container(
                            child: Column(children: [
                          TextButton(
                            onPressed: () {
                              _formKey.currentState.validate();
                              // firstDimensional();
                              setState(() {
                                gridState = false;
                                stateFirst = true;
                              });
                              print("f");
                            },
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              side: BorderSide(
                                color: Colors.red,
                                style: BorderStyle.solid,
                              ),
                            ))),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(
                                "Ввести параметры еще раз",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  // fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridPaper(
                              child: Container(
                                width: MediaQuery.of(context).size.width - 200,
                                height: ((MediaQuery.of(context).size.width -
                                        200)) /
                                    int.parse(controllerNumberCellX.text) *
                                    int.parse(controllerNumberCellY.text),
                                child: CustomPaint(
                                  painter: OpenPainter(),
                                ),
                              ),
                              interval:
                                  ((MediaQuery.of(context).size.width - 200)) /
                                      int.parse(controllerNumberCellX.text) *
                                      10, //Понадобиться для рисовки

                              // subdivisions: 1,
                              color: Colors.black,
                            ),
                          ),
                        ])),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void threeDimensional() {
    final quantityTimeStep =
        int.parse(controllerQuantityTimeStep.text); // количество шагов
    final timeStep = double.parse(controllerStepTime.text); // временной шаг
    final timeNumberStep =
        int.parse(controllerNumberTimeStep.text); //номер шага временного

    final al = double.parse(controllerAl.text); // дисперсивность горизонтальная
    final at = double.parse(controllerAt.text); // дисперсивность вертикальная

    final rangeX =
        double.parse(controlleXRange.text); // длина расчетной области по X
    final rangeY =
        double.parse(controlleYRange.text); // длина расчетной области по Y
    final rangeZ =
        double.parse(controlleZRange.text); // длина расчетной области по Z

    final sellNumberX =
        int.parse(controllerNumberCellX.text); // количество ячеек по X
    final sellNumberY =
        int.parse(controllerNumberCellY.text); // количество ячеек по Y
    final sellNumberZ =
        int.parse(controllerNumberCellZ.text); // количество ячеек по Z

    final dx = rangeX / sellNumberX; // размер ячейки по X
    final dy = rangeY / sellNumberY; // размер ячейки по X
    final dz = rangeZ / sellNumberZ; // размер ячейки по X

    final porEf = double.parse(controllerPor.text); // эффективная пористость

    final velocityX =
        double.parse(controllerVelocityX.text) / porEf; // скорость фильтрации X
    final velocityY =
        double.parse(controllerVelocityY.text) / porEf; // скорость фильтрации Y
    final velocityZ =
        double.parse(controllerVelocityZ.text) / porEf; // скорость фильтрации Z
    var x = ((MediaQuery.of(context).size.width - 200)) /
        int.parse(controllerNumberCellX.text) *
        10 *
        5;
    var y = ((MediaQuery.of(context).size.width - 200)) /
        int.parse(controllerNumberCellX.text) *
        10 *
        5;
    //пористость
    var time = 0.0;

    final mass = double.parse(controllerMass.text); // масса вещества
    final massPar = int.parse(controllerMassPar.text);
    final numPas = (mass / massPar).toInt();

    var datX = List.generate(
        quantityTimeStep,
        (t) => List.generate(
            sellNumberY,
            (y) => List.generate(
                sellNumberX, (x) => List.generate(numPas, (p) => 0.0))));
    var datY = List.generate(
        quantityTimeStep,
        (t) => List.generate(
            sellNumberY,
            (y) => List.generate(
                sellNumberX, (x) => List.generate(numPas, (p) => 0.0))));

    List<List<double>> dxx = [
      [],
      []
    ]; //at*sqrt(velocityX*velocityX + velocityY*velocityY+velocityZ*velocityZ);
    List<List<double>> dxy = [[], []];
    List<List<double>> dyx = [[], []];
    List<List<double>> dyy = [[], []];
    List<List<double>> dyz = [[], []];
    List<List<double>> dzy = [[], []];
    List<List<double>> dzz = [[], []];
    List<List<double>> dxz = [[], []];
    List<List<double>> dzx = [[], []];

    var xstart = ((MediaQuery.of(context).size.width - 200)) /
        int.parse(controllerNumberCellX.text) *
        10 *
        5;
    var ystart = ((MediaQuery.of(context).size.width - 200)) /
        int.parse(controllerNumberCellX.text) *
        10 *
        5;

    // List<double> ux = [];
    // List<double> uy = [];
    // List<double> uz = [];
    for (var i = 1; i < quantityTimeStep; i++) {
      time = time + timeStep; // действующее время
      OpenPainter.points = [];
      x = xstart - 0.5 * dx;
      y = xstart - 0.5 * dy;
      for (var j = 0; j < sellNumberY; j++) {
        //цикл по y
        for (var k = 0; j < sellNumberY; j++) {
          //цикл по x
          dxx[j][k] =
              // at * sqrt(velocityX * velocityX + velocityY * velocityY + velocityZ * velocityZ)
              (al + at) *
                  velocityX *
                  velocityX /
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ);
          dxy[j][k] = at *
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ) +
              (al + at) *
                  velocityX *
                  velocityY /
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ);

          dyx[j][k] = at *
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ) +
              (al + at) *
                  velocityY *
                  velocityX /
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ);

          dyy[j][k] = (al + at) *
              velocityY *
              velocityY /
              sqrt(velocityX * velocityX +
                  velocityY * velocityY +
                  velocityZ * velocityZ);

          dzz[j][k] = (al + at) *
              velocityZ *
              velocityZ /
              sqrt(velocityX * velocityX +
                  velocityY * velocityY +
                  velocityZ * velocityZ);

          dzy[j][k] = at *
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ) +
              (al + at) *
                  velocityZ *
                  velocityY /
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ);

          dyz[j][k] = at *
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ) +
              (al + at) *
                  velocityZ *
                  velocityY /
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ);

          dzx[j][k] = at *
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ) +
              (al + at) *
                  velocityZ *
                  velocityX /
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ);

          dxz[j][k] = at *
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ) +
              (al + at) *
                  velocityZ *
                  velocityX /
                  sqrt(velocityX * velocityX +
                      velocityY * velocityY +
                      velocityZ * velocityZ);

          for (var l = 0; l < sellNumberY; l++) {
            var ux = velocityX + (dxx[j][k] - dxx[j][k - 1]);
            //цикл по частице
          }
        }
      }
    }
  }
}

class OpenPainter extends CustomPainter {
  static List<Offset> points = [
    Offset(0, 0),
    Offset(1, 0),
    Offset(10, 10),
    Offset(100, 100),
  ];
  void paint(Canvas canvas, Size size) {
    var paint1 = Paint()
      ..color = Color(0xff63aa65)
      ..strokeWidth = 10;
    //list of points
    //draw points on canvas
    canvas.drawPoints(PointMode.points, points, paint1);
    print(points);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
/* var Vx = [][][];
Vy = [][][];
Vy = [][][];
}
if(x!=y)
Dxx = at*sqrt(Vx*Vx+Vy*Vy+Vz*Vz) + (al-at)Vx*Vx/sqrt(Vx*Vx+Vy*Vy+Vz*Vz);*/
