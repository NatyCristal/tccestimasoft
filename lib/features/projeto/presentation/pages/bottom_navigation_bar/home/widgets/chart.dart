import 'package:estimasoft/features/login/data/models/login_usuario_firebase_model.dart';
import 'package:estimasoft/features/login/domain/entities/login_entitie.dart';
import 'package:estimasoft/features/projeto/presentation/pages/widgets/components/membros/avatar_membros.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class BarChartSample7 extends StatefulWidget {
  const BarChartSample7({Key? key}) : super(key: key);

  static const Color shadowColor = Colors.transparent;

  static var dataList = [
    _BarData(
      const Color(0xFFecb206),
      200,
      200,
      LoginUsuarioFirebaseModel(
          email: "adsdadasd Asdasdsa",
          nome: "A ASdad",
          uid: "sdkfhsdjk",
          urlFoto: ""),
    ),
    _BarData(
        const Color(0xFF17987b),
        150,
        150,
        LoginUsuarioFirebaseModel(
            email: "adsdadasd Asdasdsa",
            nome: "N S",
            uid: "sdkfhsdjk",
            urlFoto: "")),
    _BarData(
        const Color(0xFF17987b),
        250,
        250,
        LoginUsuarioFirebaseModel(
            email: "adsdadasd Asdasdsa",
            nome: "C A",
            uid: "sdkfhsdjk",
            urlFoto: ""))
  ];

//  static const dataList = [
  // _BarData(
  //     const Color(0xFFecb206),
  //     18,
  //     18,
  //     LoginUsuarioFirebaseModel(
  //         email: "adsdadasd asdasdsa",
  //         nome: "alksdajka",
  //         uid: "sdkfhsdjk",
  //         urlFoto: ""),),
  // _BarData(const Color(0xFFa8bd1a), 17, 8, ),
  // _BarData(Color(0xFF17987b), 10, 15),
  // _BarData(Color(0xFFb87d46), 2.5, 5),
  // _BarData(Color(0xFF295ab5), 2, 2.5),
  // _BarData(Color(0xFFea0107), 2, 2),
  // ];

  @override
  State<BarChartSample7> createState() => _BarChartSample7State();
}

class _BarChartSample7State extends State<BarChartSample7> {
  BarChartGroupData generateBarGroup(
    int x,
    Color color,
    double value,
    double shadowValue,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: value,
          color: color,
          width: 8,
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.4,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceBetween,
                  borderData: FlBorderData(
                    show: true,
                    border: const Border.symmetric(
                      horizontal: BorderSide(
                        color: Color(0xFFececec),
                      ),
                    ),
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    leftTitles: AxisTitles(
                      drawBehindEverything: true,
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(
                              color: Color(0xFF606060),
                            ),
                            textAlign: TextAlign.left,
                          );
                        },
                      ),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 36,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: _IconWidget(
                              membro: BarChartSample7.dataList[index].membro,
                              color: BarChartSample7.dataList[index].color,
                              isSelected: touchedGroupIndex == index,
                            ),
                          );
                        },
                      ),
                    ),
                    rightTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                  ),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: const Color(0xFFececec),
                      dashArray: null,
                      strokeWidth: 1,
                    ),
                  ),
                  barGroups: BarChartSample7.dataList.asMap().entries.map((e) {
                    final index = e.key;
                    final data = e.value;
                    return generateBarGroup(
                        index, data.color, data.value, data.shadowValue);
                  }).toList(),
                  // maxY: 200,

                  barTouchData: BarTouchData(
                    enabled: true,
                    handleBuiltInTouches: false,
                    touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipMargin: 0,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.toY.toString(),
                            TextStyle(
                              fontWeight: FontWeight.bold,
                              color: rod.color!,
                              fontSize: 12,
                            ),
                          );
                        }),
                    touchCallback: (event, response) {
                      if (event.isInterestedForInteractions &&
                          response != null &&
                          response.spot != null) {
                        setState(() {
                          touchedGroupIndex =
                              response.spot!.touchedBarGroupIndex;
                        });
                      } else {
                        setState(() {
                          touchedGroupIndex = -1;
                        });
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BarData {
  final UsuarioEntitie membro;
  final Color color;
  final double value;
  final double shadowValue;

  const _BarData(this.color, this.value, this.shadowValue, this.membro);
}

class _IconWidget extends ImplicitlyAnimatedWidget {
  final UsuarioEntitie membro;
  final Color color;
  final bool isSelected;

  const _IconWidget({
    required this.membro,
    required this.color,
    required this.isSelected,
  }) : super(duration: const Duration(milliseconds: 300));

  @override
  ImplicitlyAnimatedWidgetState<ImplicitlyAnimatedWidget> createState() =>
      _IconWidgetState();
}

class _IconWidgetState extends AnimatedWidgetBaseState<_IconWidget> {
  Tween<double>? _rotationTween;

  @override
  Widget build(BuildContext context) {
    final rotation = math.pi * 4 * _rotationTween!.evaluate(animation);
    final scale = 1 + _rotationTween!.evaluate(animation) * 0.5;
    return Transform(
      transform: Matrix4.rotationZ(rotation).scaled(scale, scale),
      origin: const Offset(14, 14),
      child: widget.isSelected
          ? AvatarMembro(
              membro: widget.membro,
              altura: 20,
              largura: 20,
            )
          : AvatarMembro(
              membro: widget.membro,
              altura: 20,
              largura: 20,
            ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _rotationTween = visitor(
      _rotationTween,
      widget.isSelected ? 1.0 : 0.0,
      (dynamic value) => Tween<double>(
        begin: value,
        end: widget.isSelected ? 1.0 : 0.0,
      ),
    ) as Tween<double>;
  }
}
