import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/id.dart';
import '../../core/logger.dart';
import '../../core/utils/dates.dart';
import '../../data/data_providers.dart';
import '../../domain/models/pay.dart';
import '../../domain/models/shift.dart';
import '../../domain/models/shift_template.dart';
import '../../domain/repositories/schedule_repository.dart';

final scheduleActionsProvider = Provider<ScheduleActions>(ScheduleActions.new);

class ScheduleActions {
  ScheduleActions(this._ref);

  final Ref _ref;

  ScheduleRepository get _repository => _ref.read(scheduleRepositoryProvider);

  Future<Pay> suggestedShiftPay(ShiftTemplate template) async {
    final recent = await _repository.recentShiftPays(template.id, limit: 1);

    return recent.isNotEmpty ? recent.first : template.defaultPay;
  }

  Future<Shift> addShift(ShiftTemplate template, DateTime day) async {
    final shift = Shift(
      id: newId(),
      templateId: template.id,
      day: dateOnly(day),
      allDay: template.allDay,
      startMinute: template.startMinute,
      endMinute: template.endMinute,
      breakMinutes: template.breakMinutes,
      location: template.location,
      pay: await suggestedShiftPay(template),
      updatedAt: DateTime.now(),
    );

    await _repository.upsertShift(shift);
    talker.info('Shift added: ${template.title} on ${dayKey(day)} ${shift.pay}');

    return shift;
  }

  Future<void> toggleShift(ShiftTemplate template, DateTime day) async {
    final date = dateOnly(day);
    final existing = await _repository.getShifts(date, addDays(date, 1));
    final sameType = existing.where((s) => s.templateId == template.id).toList();

    if (sameType.isEmpty) {
      await addShift(template, date);
      return;
    }

    for (final shift in sameType) {
      await _repository.deleteShift(shift.id);
    }

    talker.info('Shift removed: ${template.title} on ${dayKey(date)}');
  }
}
