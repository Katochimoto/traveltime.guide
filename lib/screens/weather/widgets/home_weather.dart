import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:traveltime/constants/routes.dart';
import 'package:traveltime/constants/theme.dart';
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
    return CardHorizontalContainer(
      tap: () {
        context.pushNamed(Routes.article, pathParameters: {'id': '123'});
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: UIGap.g4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
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
                    child: Image.network(
                      'https://openweathermap.org/img/wn/10d@2x.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  const SizedBox(width: UIGap.g2),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          weather.name,
                          style: Theme.of(context).textTheme.titleMedium,
                          softWrap: true,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              '27 ℃',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            const SizedBox(width: UIGap.g1),
                            // Transform.rotate(
                            //   angle: 180 * pi / 180,
                            //   child: const Icon(Icons.arrow_right_alt, size: 20),
                            // ),
                            // Text(
                            //   '10m/c',
                            //   style: Theme.of(context).textTheme.bodySmall,
                            // ),
                            Text(
                              'Cloudy',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: UIGap.g2),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const <int, TableColumnWidth>{
                0: IntrinsicColumnWidth(),
                1: FixedColumnWidth(40),
                2: IntrinsicColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    Text('Sat', style: Theme.of(context).textTheme.labelSmall),
                    Center(
                        child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Image.network(
                        'https://openweathermap.org/img/wn/10d@2x.png',
                        width: 25,
                        height: 25,
                      ),
                    )),
                    Text('20 ℃', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Sun', style: Theme.of(context).textTheme.labelSmall),
                    Center(
                        child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Image.network(
                        'https://openweathermap.org/img/wn/10d@2x.png',
                        width: 25,
                        height: 25,
                      ),
                    )),
                    Text('20 ℃', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                TableRow(
                  children: [
                    Text('Mon', style: Theme.of(context).textTheme.labelSmall),
                    Center(
                        child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      child: Image.network(
                        'https://openweathermap.org/img/wn/10d@2x.png',
                        width: 25,
                        height: 25,
                      ),
                    )),
                    Text('20 ℃', style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class HomeWeather extends ConsumerWidget {
  const HomeWeather({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weather = ref.watch(currentWeatherProvider);
    return weather.when(
      loading: () => const CircularProgressIndicator(),
      error: (err, stack) => Text('Error $err'),
      data: (data) => HomeWeatherContent(weather: data),
    );
  }
}
