import 'package:flutter/material.dart';

import '../../../domain/models/time_span.dart';
import '../../../l10n/app_localizations.dart';
import '../../theme/theme_context.dart';
import '../../utils/formatters.dart';
import '../group_card.dart';
import '../pill_button.dart';
import '../sheet_header.dart';
import 'time_wheel.dart';

class TimePickerSheet extends StatefulWidget {
  const TimePickerSheet({required this.title, required this.initialMinute, super.key});

  final String title;
  final int initialMinute;

  @override
  State<TimePickerSheet> createState() {
    return _TimePickerSheetState();
  }
}

class _TimePickerSheetState extends State<TimePickerSheet> {
  static const _wheelsHeight = 220.0;
  static const _minutes = 60;
  static const _hours = 24;
  static const _halfDay = 12;

  late int _hour = widget.initialMinute ~/ _minutes % _hours;
  late int _minute = widget.initialMinute % _minutes;
  late final _hour24Controller = FixedExtentScrollController(initialItem: _hour);
  late final _hour12Controller = FixedExtentScrollController(initialItem: _hour12 - 1);
  late final _minuteController = FixedExtentScrollController(initialItem: _minute);
  late final _periodController = FixedExtentScrollController(initialItem: _isPm ? 1 : 0);

  int get _hour12 => _hour % _halfDay == 0 ? _halfDay : _hour % _halfDay;

  bool get _isPm => _hour >= _halfDay;

  int get _value => _hour * _minutes + _minute;

  @override
  void dispose() {
    _hour24Controller.dispose();
    _hour12Controller.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  void _setHour12(int hour12, {required bool pm}) {
    setState(() {
      _hour = hour12 % _halfDay + (pm ? _halfDay : 0);
    });
  }

  String _twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);
    final p = context.palette;
    final use24h = uses24HourFormat(context);

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SheetHeader(widget.title),
            Text(
              formatTime(context, _value % minutesPerDay),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w800, color: p.text),
            ),
            const SizedBox(height: 12),
            GroupCard(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                SizedBox(
                  height: _wheelsHeight,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: TimeWheel.itemExtent,
                        decoration: BoxDecoration(color: p.selected, borderRadius: BorderRadius.circular(12)),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: use24h
                                ? TimeWheel(
                                    controller: _hour24Controller,
                                    labels: [for (var h = 0; h < _hours; h++) _twoDigits(h)],
                                    onChanged: (index) {
                                      setState(() {
                                        _hour = index;
                                      });
                                    },
                                  )
                                : TimeWheel(
                                    controller: _hour12Controller,
                                    labels: [for (var h = 1; h <= _halfDay; h++) '$h'],
                                    onChanged: (index) {
                                      _setHour12(index + 1, pm: _isPm);
                                    },
                                  ),
                          ),
                          Text(
                            ':',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: p.text),
                          ),
                          Expanded(
                            child: TimeWheel(
                              controller: _minuteController,
                              labels: [for (var m = 0; m < _minutes; m++) _twoDigits(m)],
                              onChanged: (index) {
                                setState(() {
                                  _minute = index;
                                });
                              },
                            ),
                          ),
                          if (!use24h)
                            Expanded(
                              child: TimeWheel(
                                controller: _periodController,
                                looping: false,
                                labels: [formatDayPeriod(context, pm: false), formatDayPeriod(context, pm: true)],
                                onChanged: (index) {
                                  _setHour12(_hour12, pm: index == 1);
                                },
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            PillButton(
              label: l.done,
              onTap: () {
                Navigator.of(context).pop(_value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
