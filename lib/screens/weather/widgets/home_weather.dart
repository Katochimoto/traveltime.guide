import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:relative_time/relative_time.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/constants/theme.dart';
import 'package:traveltime/providers/current_weather.dart';
import 'package:traveltime/providers/weather.dart';
import 'package:traveltime/widgets/card/card_horizontal.dart';

class HomeWeatherContent extends StatelessWidget {
  const HomeWeatherContent({
    super.key,
    required this.weather,
  });

  final CurrentWeather weather;

  @override
  Widget build(BuildContext context) {
    // final detailsLabel = Theme.of(context).textTheme.labelSmall;
    final detailsValue =
        Theme.of(context).textTheme.bodySmall!.copyWith(height: 1);
    final dateTimeValue =
        Theme.of(context).textTheme.bodySmall!.copyWith(height: 1, fontSize: 8);
    final mainValue =
        Theme.of(context).textTheme.headlineSmall!.copyWith(height: 1);
    return CardHorizontalContainer(
      tap: () {
        context.pushNamed(Routes.article, pathParameters: {'id': '123'});
      },
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: UIGap.g1, vertical: 2.0),
              child: Text(
                  RelativeTime(context,
                          timeUnits: [TimeUnit.hour, TimeUnit.minute])
                      .format(weather.dateTime.toLocal()),
                  style: dateTimeValue),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: UIGap.g5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(35))),
                  child:
                      Image.network(weather.weatherIcon, width: 50, height: 50),
                ),
                const SizedBox(width: UIGap.g5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      weather.address,
                      style: Theme.of(context).textTheme.titleMedium,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text('${weather.temp} ℃', style: mainValue),
                    Row(
                      children: [
                        Text(
                          weather.weatherMain,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(height: 1.2),
                        ),
                        const SizedBox(width: UIGap.g1),
                        Transform.rotate(
                          angle: weather.windDeg * pi / 180,
                          child: const Icon(Icons.arrow_right_alt, size: 20),
                        ),
                        Text(
                          '${weather.windSpeed} m/c',
                          style: detailsValue,
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeWeather extends ConsumerWidget {
  const HomeWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(currentWeatherProvider);
    if (weather == null) {
      return const CardHorizontalContainer(
          child: Center(child: CircularProgressIndicator()));
    }
    return HomeWeatherContent(weather: weather);
  }
}

// const SizedBox(width: UIGap.g2),
            // Table(
            //   defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            //   columnWidths: const <int, TableColumnWidth>{
            //     0: IntrinsicColumnWidth(),
            //     1: FixedColumnWidth(5),
            //     2: IntrinsicColumnWidth(),
            //   },
            //   children: [
            //     TableRow(
            //       children: [
            //         Text('Feels', style: detailsLabel),
            //         const SizedBox.shrink(),
            //         Text('${weather.tempFeelsLike} ℃', style: detailsValue),
            //       ],
            //     ),
            //     TableRow(
            //       children: [
            //         Text('Humidity', style: detailsLabel),
            //         const SizedBox.shrink(),
            //         Text('${weather.humidity.toInt()} %', style: detailsValue),
            //       ],
            //     ),
            //     TableRow(
            //       children: [
            //         Text('Pressure', style: detailsLabel),
            //         const SizedBox.shrink(),
            //         Text('${weather.pressure.toInt()} hPa',
            //             style: detailsValue),
            //       ],
            //     ),
            //     TableRow(
            //       children: [
            //         Text('Cloudiness', style: detailsLabel),
            //         const SizedBox.shrink(),
            //         Text('${weather.cloudiness.toInt()} %',
            //             style: detailsValue),
            //       ],
            //     ),
            //     TableRow(
            //       children: [
            //         Text('Visibility', style: detailsLabel),
            //         const SizedBox.shrink(),
            //         Text('${weather.visibility.toInt()} m',
            //             style: detailsValue),
            //       ],
            //     ),
            //   ],
            // ),

/*
const SizedBox(width: UIGap.g1),
                            Transform.rotate(
                              angle: 180 * pi / 180,
                              child:
                                  const Icon(Icons.arrow_right_alt, size: 20),
                            ),
                            Text(
                              '10m/c',
                              style: detailsValue,
                            ),
                            */