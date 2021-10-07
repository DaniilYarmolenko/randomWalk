// import 'dart:math';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class OneDimensional extends StatefulWidget {
  OneDimensional({Key key}) : super(key: key);

  @override
  _OneDimensionalState createState() => _OneDimensionalState();
}

class _OneDimensionalState extends State<OneDimensional> {
  final cal = Colors.amber[400];
  var countGrid = 1;
  var solution = false;
  var cu1 = false;
  var cu2 = false;
  var textState = false;
  var controllerVelocity = TextEditingController(
    text: "1.0",
  ); // vx // скорость, позже будет как массив
  var controllerPor = TextEditingController(
    text: "0.3",
  );
  // эффективная пористость
  var controllerM = TextEditingController(text: "1.0"); // мощность пласта
  final controllerNumberPar =
      TextEditingController(text: "1000"); // масса частиц
  final controllerAl = TextEditingController(text: "1.0");
  final controllerMass = TextEditingController(); // масса вещества
  final controllerRange = TextEditingController(); // длина расчетной области
  final controllerNumberCellX =
      TextEditingController(); // количество ячеек по X
  final controllerStepTime = TextEditingController(); // величина временого шага
  final controllerQuantityTimeStep =
      TextEditingController(); // количество временных шагов
  final controllerNumberTimeStep =
      TextEditingController(); // номер временого шага
  var _formKey = GlobalKey<FormState>();
  var velocity;
  List<DataFirstDimensional> randomWalkData = [
    DataFirstDimensional(0, 0, 0)
  ]; //x, t, c
  List<DataFirstDimensional> analitcData = [DataFirstDimensional(0, 0, 0)];
  List<DataFirstDimensional> finiteDifferenceData = [
    DataFirstDimensional(0, 0, 0)
  ];
  List<DataFirstDimensional> tvdData = [DataFirstDimensional(0, 0, 0)];

  List<DataTimeDimensional> analiticTimeData = [DataTimeDimensional(0, 0)];
  List<DataTimeDimensional> randomWalkTimeData = [DataTimeDimensional(0, 0)];
  List<DataTimeDimensional> fd_1 = [DataTimeDimensional(0, 0)];
  List<DataTimeDimensional> fd_2 = [DataTimeDimensional(0, 0)];
  // List<DataRandom> fD = [DataRandom(0, 0)];
  // var random = false;
  @override
  Widget build(BuildContext context) {
    return Center(
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
        Expanded(
          // flex: 1,
          child: GridView.count(
            crossAxisCount: countGrid,
            children: [
              Container(
                height: MediaQuery.of(context).size.height,
                width: 0.5 * MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  // clipBehavior: Clip.antiAlias,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 25.0, top: 10.0),
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
                              controller: controllerVelocity,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Введите скорость фильтрации',
                                  labelText: "Скорость фильтрации [м/сут]",
                                  labelStyle: TextStyle(),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20.0))
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
                                if (double.parse(value) < 0) {
                                  return 'Мощность должна быть больше 0';
                                }
                                return null;
                              },
                              controller: controllerM,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Введите мощность слоя',
                                  labelText: 'Мощность слоя [м]',
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
                                if (int.tryParse(value) == null) {
                                  return 'Введите целое число';
                                }
                                if (int.parse(value) <= 1) {
                                  return 'Количество частиц должно быть больше 1';
                                }
                                return null;
                              },
                              controller: controllerNumberPar,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Введите количество частиц',
                                  labelText: 'Количество частиц [-]',
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
                                  hintText: 'Введите диспресивность',
                                  labelText: 'Дисперсивность [м]',
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
                              controller: controllerRange,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                  hintText: 'Введите размер модели',
                                  labelText: 'Размер модели [м]',
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
                                  hintText: 'Введите количество ячеек',
                                  labelText: 'Количество ячеек [-]',
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
                                    labelText: 'Количество временных шагов [-]',
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
                                        int.parse(
                                            controllerQuantityTimeStep.text) ||
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
                    ),
                  ),
                ),
              ),
              if (textState)
                Center(
                  child: Container(
                    child: Text("Cu1 = $textState"),
                    color: Colors.redAccent[400],
                    // height: 0.5 * MediaQuery.of(context).size.height,
                    // height
                  ),
                ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            _formKey.currentState.validate();
            countGrid = 2;
            firstDimensional();
          },
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
              "Расчитать одномерный",
              style: TextStyle(
                fontWeight: FontWeight.w500,
                // fontSize: 16,
              ),
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 0.5 * MediaQuery.of(context).size.height,
          child: SfCartesianChart(
            legend: Legend(
              isVisible: true,
            ),
            // backgroundColor: Colors.black12,
            primaryXAxis: NumericAxis(),
            tooltipBehavior: TooltipBehavior(enable: true),
            series: <ChartSeries<DataTimeDimensional, double>>[
              SplineSeries<DataTimeDimensional, double>(
                dataSource: randomWalkTimeData,
                xValueMapper: (DataTimeDimensional randomWalkTimeData, _) =>
                    randomWalkTimeData.x,
                yValueMapper: (DataTimeDimensional randomWalkTimeData, _) =>
                    randomWalkTimeData.c,
                legendItemText: 'RW',
                name: "Random Walk",
              ),
              SplineSeries<DataTimeDimensional, double>(
                dataSource: analiticTimeData,
                xValueMapper: (DataTimeDimensional analiticTimeData, _) =>
                    analiticTimeData.x,
                yValueMapper: (DataTimeDimensional analiticTimeData, _) =>
                    analiticTimeData.c,
                legendItemText: 'Analitic solution',
                name: "Analitic",
              ),
              SplineSeries<DataTimeDimensional, double>(
                dataSource: fd_1,
                xValueMapper: (DataTimeDimensional fd_1, _) => fd_1.x,
                yValueMapper: (DataTimeDimensional fd_1, _) => fd_1.c,
                legendItemText: 'finite-difference (1)',
                name: "FD(1)",
                isVisible: cu1,
              ),
              SplineSeries<DataTimeDimensional, double>(
                dataSource: fd_2,
                xValueMapper: (DataTimeDimensional fd_2, _) => fd_2.x,
                yValueMapper: (DataTimeDimensional fd_2, _) => fd_2.c,
                isVisible: cu2,
                legendItemText: 'finite-difference (2)',
                name: "FD(2)",
              ),
            ],
            borderColor: Colors.red,
            enableAxisAnimation: true,
            primaryYAxis: NumericAxis(),
          ),
        ),
      ],
    ));
  }

  void firstDimensional() {
    final quantityTimeStep =
        int.parse(controllerQuantityTimeStep.text); // количество шагов
    final timeStep = double.parse(controllerStepTime.text); // временной шаг
    final timeNumberStep =
        int.parse(controllerNumberTimeStep.text); //номер шага временного
    final velocity =
        double.parse(controllerVelocity.text); // скорость фильтрации
    final al = double.parse(controllerAl.text); // дисперсивность
    final porEf = double.parse(controllerPor.text); // дисперсивность

    //пористость

    final m = double.parse(controllerM.text);
    //мощность пласта
    final mass = double.parse(controllerMass.text); // масса вещества
    final rangeX =
        double.parse(controllerRange.text); // общая длина расчетной области
    final sellNumberX = int.parse(controllerNumberCellX.text); // размер ячейки
    final dx = rangeX / sellNumberX; //размер ячейки
    final numPar = int.parse(controllerNumberPar.text); // масса частиц
    //порядок точности
    rWanal(quantityTimeStep, timeStep, timeNumberStep, velocity, al, porEf,
        mass, sellNumberX, dx, numPar, m);
    fd(timeNumberStep, sellNumberX, quantityTimeStep, dx, timeStep, velocity,
        porEf, al, mass);
  }

  void fd(timeNumberStep, sellNumberX, quantityTimeStep, dx, timeStep, velocity,
      porEf, dispers, cgr) {
    List<DataTimeDimensional> graphFD_1time = [];
    List<DataTimeDimensional> graphFD_2time = [];
    double u = velocity / porEf;
    double pe = dx / dispers;
    double cuFun = timeStep * u / dx;
    double cu2Fun = timeStep * u / (dx * dx);
    double cFD1 = cgr;
    double cFD2 = cgr;
    double xc = 0.0;
    var cFD_1 = List.generate(sellNumberX, (t) => 0.0);
    var cFD_2 = List.generate(sellNumberX, (t) => 0.0);
    var x = List.generate(sellNumberX, (t) => 0.0);
    cFD_1[0] = cgr;
    cFD_1[1] = 0.0;
    cFD_1[2] = 0.0;
    cFD_2[0] = cgr;
    cFD_2[1] = 0.0;
    cFD_2[2] = 0.0;
    var value = 0.0;
    double time = 0.0;
    double xFD, x1, x2, a1, a2, b1, b2, c1, c2;
    if (cuFun < 1) {
      setState(() {
        cu1 = false;
        textState = true;
      });
    } else {
      setState(() {
        cu1 = true;
        textState = true;
      });
    }
    if (cu2Fun < 1) {
      setState(() {
        cu2 = false;
        textState = true;
      });
    } else {
      setState(() {
        cu2 = true;
        textState = true;
      });
    }
    if (cuFun > 1 && cu2Fun > 1) {
      return;
    }
    if (timeNumberStep == 0) {
      graphFD_1time.add(DataTimeDimensional(xc, cgr));
      graphFD_2time.add(DataTimeDimensional(xc, cgr));
    }
    if (timeNumberStep >= 1) {
      graphFD_1time.add(DataTimeDimensional(xc, 0));
      graphFD_2time.add(DataTimeDimensional(xc, 0));
      print('Прошло3');
      for (var i = 1; i <= quantityTimeStep; i++) {
        print('Прошло4');
        time = time + timeStep;
        xc = time * u;
        for (var j = 1; j < sellNumberX - 1; j++) {
          // print('Прошло + $j');
          x[j] = (xc - u * time) / (2 * sqrt(dispers * velocity * time));
          x[j + 1] = (xc + u * time) / (2 * sqrt(dispers * velocity * time));
          if (xc * u / (dispers * velocity) <= 30) {
            value = 0.5 *
                (erfc(x[j]) +
                    exp(xc * u / (velocity * dispers)) * erfc(x[j + 1]));
          }
          if (xc * u / (dispers * velocity) > 30) {
            value = 0.5 * (erfc(x[j])); // 0.5*erfc(x1)
          }
          a1 = time / (porEf * dx) * (dispers * velocity / dx) + velocity * 0.5;
          b1 = time / (porEf * dx) * (dispers * velocity / dx - 0.5 * velocity);
          c1 = time /
                  (porEf * dx) *
                  (0.5 * velocity - dispers * velocity / (dx)) -
              velocity * dispers / (dx) -
              (1 - 0.5) * velocity +
              1.0;
          a2 = time / (porEf * dx) * (dispers * velocity / dx + velocity);
          b2 = time / (porEf * dx) * (dispers * velocity / dx);
          c2 = time /
                  (porEf * dx) *
                  (dispers * velocity / dx -
                      velocity * dispers / dx -
                      velocity) +
              1.0;
          print('a1 = $a1, a2 = $a2, b1 = $b1, b2 = $b2, c1 = $c1, c2 = $c2');
          cFD1 = cFD_1[j - 1] * a1 + cFD_1[j] * c1 + cFD_1[j + 1] * b1;
          cFD_1[j] = cFD1;
          cFD2 = cFD_2[j - 1] * a2 + cFD_2[j] * c2 + cFD_2[j + 1] * b2;
          cFD_2[j] = cFD2;
          if (cFD2 < 0) {
            cFD2 = 0.0;
          }
          if (cFD1 < 0) {
            cFD1 = 0.0;
          }
          if (i == timeNumberStep) {
            graphFD_1time.add(DataTimeDimensional(xc, cFD1));
            graphFD_2time.add(DataTimeDimensional(xc, cFD2));
            print(
                "xFD = $xFD, cFD1 = $cFD1, cFD2 = $cFD2, xc = $xc, x[$j] = ${x[j]}");
          }
          print("cu = $cuFun, cu1 = $cu2Fun , pe = $pe");
          xc = xc + dx;
        }
      }
    }
    setState(() {
      fd_1 = graphFD_1time;
      fd_2 = graphFD_2time;
    });
    // return graphFD_2time;
  }

  void rWanal(quantityTimeStep, timeStep, timeNumberStep, velocity, al, porEf,
      mass, sellNumberX, dx, nPas, m) {
    var cAn = mass; //концентрация аналитически
    // var gam1 = 0.5;
    // var gam2 = 0;
    // var xAn = 0.0;
    // var xRw = 0.0;
    var z = 0.0;
    var cRw = mass; // концентрация Random walk
    // var cFD = mass; // концентрация FD
    var nPasVar = 0;
    // считаю количество частиц - целое округленное
    var u = velocity / porEf; // действительная скорость
    // final pe = dx / al;
    // final cu = timeStep * velocity / (dx * porEf);
    // final cu1 = al * u / (dx * dx);
    // var xU = timeStep * u;
    // List<DataFirstDimensional> graphRW = [];
    // List<DataFirstDimensional> graphAN = [];
    List<DataTimeDimensional> graphRWtime = [];
    List<DataTimeDimensional> graphANtime = [];

    // List<DataTimeDimensional> graphFDtime = [];
    var time = 0.0;
    var x = 0.0;
    var datX = List.generate(
        quantityTimeStep,
        (t) =>
            List.generate(sellNumberX, (x) => List.generate(nPas, (p) => 0.0)));
    // var datFD1 = List.generate(
    //     quantityTimeStep, (t) => List.generate(sellNumberX, (x) => 0.0));
    // var datFD2 = List.generate(
    //     quantityTimeStep, (t) => List.generate(sellNumberX, (x) => 0.0));
    // graphAN.add(DataFirstDimensional(xAn, 0, cAn));
    // graphRW.add(DataFirstDimensional(xRw, 0, cRw));
    if (timeNumberStep == 0) {
      graphRWtime.add(DataTimeDimensional(x, cRw));
      graphANtime.add(DataTimeDimensional(x, cAn));
    }
    print('Прошло1');
    // fd(timeNumberStep, sellNumberX, quantityTimeStep, dx, timeStep, velocity,
    //     porEf, al, mass);
    print('Прошло2');
    if (quantityTimeStep >= 1) {
      graphRWtime.add(DataTimeDimensional(0, 0));
      graphANtime.add(DataTimeDimensional(0, 0));
      for (var i = 1; i < quantityTimeStep; i++) {
        // print('$cRw  $cAn');
        time = time + timeStep; // действующее время
        x = 0.5 * dx; // координата центра первой ячейки
        // xU = time * u; //- фактическое растояние пройденное
        for (var j = 0; j < sellNumberX; j++) {
          nPasVar = 0;
          for (var k = 0; k < nPas; k++) {
            Random random = new Random();
            z = 2 * random.nextDouble() - 1; // рандом
            // z = random.nextDouble();
            datX[i][j][k] = datX[i - 1][j][k] +
                u * timeStep +
                z *
                    sqrt(2 *
                        al *
                        timeStep *
                        u); // частица со временем i, ячейкой j, и номером k
            if (datX[i][j][k] < x + 0.5 * (dx) &&
                datX[i][j][k] > x - 0.5 * (dx)) {
              nPasVar++;
            }
          } // цикл частиц

          // if (x < time * u) {
          cAn = (mass /
              (2 * m * porEf * sqrt(pi * al * u * time)) *
              exp(-(x - u * time) *
                  (x - u * time) /
                  (4 * al * u * time))); // концентрация частиц

          cRw = mass *
              nPasVar /
              (nPas *
                  m *
                  porEf *
                  dx); // концентрация randomWalk на момент времени и в определенной ячейке
          if (i == timeNumberStep) {
            graphRWtime.add(DataTimeDimensional(x, cRw));
            graphANtime.add(DataTimeDimensional(x, cAn));
            //записываю результат
          }
          x = x + dx; // увеличиваем координату ячейки до следующей
        }
      }
    }
    setState(() {
      // randomWalkData = graphAN;
      // analitcData = graphRW;
      analiticTimeData = graphANtime;
      randomWalkTimeData = graphRWtime;
      solution = true;
    });
  }

  double erfc(double x) {
    final z = x.abs();
    final t = 1.0 / (1.0 + 0.5 * z);

    // Approximate the complementary error function
    var erfc = t *
        exp(-z * z -
            1.26551223 +
            t *
                (1.00002368 +
                    t *
                        (0.37409196 +
                            t *
                                (0.09678418 +
                                    t *
                                        (-0.18628806 +
                                            t *
                                                (0.27886807 +
                                                    t *
                                                        (-1.13520398 +
                                                            t *
                                                                (1.48851587 +
                                                                    t *
                                                                        (-0.82215223 +
                                                                            t * 0.17087277)))))))));

    return erfc;
  }
  // написать функцию для рассчета коэффициентов
}

class DataFirstDimensional {
  DataFirstDimensional(this.x, this.t, this.c);
  final double x;
  final double t;
  final double c;
}

class DataTimeDimensional {
  DataTimeDimensional(this.x, this.c);
  final double x;
  final double c;
}
// Сделать в ближайшее время
//TODO: Разделить все функции // Почти, надо разделить fd1 и fd 2
//TODO: Сделать TVD //
//TODO: Сделать валидацию для всех textfield // почти сделано, но хоть понятно как
//TODO: Сделать вывод CU2 CU1 Пекле с разным цветом // понятно как + добавить формулу ?
//TODO: Нужно ли добавлять разные конпки ? // да не, расчитываем все
// TODO: Сделать ChildScrollView и настроить // вроде сделано
