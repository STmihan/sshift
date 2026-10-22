// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ShiftTemplatesTable extends ShiftTemplates
    with TableInfo<$ShiftTemplatesTable, TemplateRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<String> icon = GeneratedColumn<String>(
    'icon',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorMeta = const VerificationMeta('color');
  @override
  late final GeneratedColumn<int> color = GeneratedColumn<int>(
    'color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinuteMeta = const VerificationMeta(
    'endMinute',
  );
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
    'end_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breakMinutesMeta = const VerificationMeta(
    'breakMinutes',
  );
  @override
  late final GeneratedColumn<int> breakMinutes = GeneratedColumn<int>(
    'break_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payTypeMeta = const VerificationMeta(
    'payType',
  );
  @override
  late final GeneratedColumn<int> payType = GeneratedColumn<int>(
    'pay_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payAmountMeta = const VerificationMeta(
    'payAmount',
  );
  @override
  late final GeneratedColumn<int> payAmount = GeneratedColumn<int>(
    'pay_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    icon,
    color,
    allDay,
    startMinute,
    endMinute,
    breakMinutes,
    payType,
    payAmount,
    location,
    sortOrder,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shift_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
        _iconMeta,
        icon.isAcceptableOrUnknown(data['icon']!, _iconMeta),
      );
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    if (data.containsKey('color')) {
      context.handle(
        _colorMeta,
        color.isAcceptableOrUnknown(data['color']!, _colorMeta),
      );
    } else if (isInserting) {
      context.missing(_colorMeta);
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    } else if (isInserting) {
      context.missing(_allDayMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('end_minute')) {
      context.handle(
        _endMinuteMeta,
        endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinuteMeta);
    }
    if (data.containsKey('break_minutes')) {
      context.handle(
        _breakMinutesMeta,
        breakMinutes.isAcceptableOrUnknown(
          data['break_minutes']!,
          _breakMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_breakMinutesMeta);
    }
    if (data.containsKey('pay_type')) {
      context.handle(
        _payTypeMeta,
        payType.isAcceptableOrUnknown(data['pay_type']!, _payTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_payTypeMeta);
    }
    if (data.containsKey('pay_amount')) {
      context.handle(
        _payAmountMeta,
        payAmount.isAcceptableOrUnknown(data['pay_amount']!, _payAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_payAmountMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      icon: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}icon'],
      )!,
      color: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}color'],
      )!,
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      )!,
      endMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minute'],
      )!,
      breakMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}break_minutes'],
      )!,
      payType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_type'],
      )!,
      payAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_amount'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShiftTemplatesTable createAlias(String alias) {
    return $ShiftTemplatesTable(attachedDatabase, alias);
  }
}

class TemplateRow extends DataClass implements Insertable<TemplateRow> {
  final String id;
  final String title;
  final String icon;
  final int color;
  final bool allDay;
  final int startMinute;
  final int endMinute;
  final int breakMinutes;
  final int payType;
  final int payAmount;
  final String location;
  final int sortOrder;
  final DateTime updatedAt;
  const TemplateRow({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.allDay,
    required this.startMinute,
    required this.endMinute,
    required this.breakMinutes,
    required this.payType,
    required this.payAmount,
    required this.location,
    required this.sortOrder,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['icon'] = Variable<String>(icon);
    map['color'] = Variable<int>(color);
    map['all_day'] = Variable<bool>(allDay);
    map['start_minute'] = Variable<int>(startMinute);
    map['end_minute'] = Variable<int>(endMinute);
    map['break_minutes'] = Variable<int>(breakMinutes);
    map['pay_type'] = Variable<int>(payType);
    map['pay_amount'] = Variable<int>(payAmount);
    map['location'] = Variable<String>(location);
    map['sort_order'] = Variable<int>(sortOrder);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShiftTemplatesCompanion toCompanion(bool nullToAbsent) {
    return ShiftTemplatesCompanion(
      id: Value(id),
      title: Value(title),
      icon: Value(icon),
      color: Value(color),
      allDay: Value(allDay),
      startMinute: Value(startMinute),
      endMinute: Value(endMinute),
      breakMinutes: Value(breakMinutes),
      payType: Value(payType),
      payAmount: Value(payAmount),
      location: Value(location),
      sortOrder: Value(sortOrder),
      updatedAt: Value(updatedAt),
    );
  }

  factory TemplateRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateRow(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      icon: serializer.fromJson<String>(json['icon']),
      color: serializer.fromJson<int>(json['color']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      endMinute: serializer.fromJson<int>(json['endMinute']),
      breakMinutes: serializer.fromJson<int>(json['breakMinutes']),
      payType: serializer.fromJson<int>(json['payType']),
      payAmount: serializer.fromJson<int>(json['payAmount']),
      location: serializer.fromJson<String>(json['location']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'icon': serializer.toJson<String>(icon),
      'color': serializer.toJson<int>(color),
      'allDay': serializer.toJson<bool>(allDay),
      'startMinute': serializer.toJson<int>(startMinute),
      'endMinute': serializer.toJson<int>(endMinute),
      'breakMinutes': serializer.toJson<int>(breakMinutes),
      'payType': serializer.toJson<int>(payType),
      'payAmount': serializer.toJson<int>(payAmount),
      'location': serializer.toJson<String>(location),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  TemplateRow copyWith({
    String? id,
    String? title,
    String? icon,
    int? color,
    bool? allDay,
    int? startMinute,
    int? endMinute,
    int? breakMinutes,
    int? payType,
    int? payAmount,
    String? location,
    int? sortOrder,
    DateTime? updatedAt,
  }) => TemplateRow(
    id: id ?? this.id,
    title: title ?? this.title,
    icon: icon ?? this.icon,
    color: color ?? this.color,
    allDay: allDay ?? this.allDay,
    startMinute: startMinute ?? this.startMinute,
    endMinute: endMinute ?? this.endMinute,
    breakMinutes: breakMinutes ?? this.breakMinutes,
    payType: payType ?? this.payType,
    payAmount: payAmount ?? this.payAmount,
    location: location ?? this.location,
    sortOrder: sortOrder ?? this.sortOrder,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  TemplateRow copyWithCompanion(ShiftTemplatesCompanion data) {
    return TemplateRow(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      icon: data.icon.present ? data.icon.value : this.icon,
      color: data.color.present ? data.color.value : this.color,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
      breakMinutes: data.breakMinutes.present
          ? data.breakMinutes.value
          : this.breakMinutes,
      payType: data.payType.present ? data.payType.value : this.payType,
      payAmount: data.payAmount.present ? data.payAmount.value : this.payAmount,
      location: data.location.present ? data.location.value : this.location,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateRow(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('allDay: $allDay, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('breakMinutes: $breakMinutes, ')
          ..write('payType: $payType, ')
          ..write('payAmount: $payAmount, ')
          ..write('location: $location, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    icon,
    color,
    allDay,
    startMinute,
    endMinute,
    breakMinutes,
    payType,
    payAmount,
    location,
    sortOrder,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateRow &&
          other.id == this.id &&
          other.title == this.title &&
          other.icon == this.icon &&
          other.color == this.color &&
          other.allDay == this.allDay &&
          other.startMinute == this.startMinute &&
          other.endMinute == this.endMinute &&
          other.breakMinutes == this.breakMinutes &&
          other.payType == this.payType &&
          other.payAmount == this.payAmount &&
          other.location == this.location &&
          other.sortOrder == this.sortOrder &&
          other.updatedAt == this.updatedAt);
}

class ShiftTemplatesCompanion extends UpdateCompanion<TemplateRow> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> icon;
  final Value<int> color;
  final Value<bool> allDay;
  final Value<int> startMinute;
  final Value<int> endMinute;
  final Value<int> breakMinutes;
  final Value<int> payType;
  final Value<int> payAmount;
  final Value<String> location;
  final Value<int> sortOrder;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ShiftTemplatesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.icon = const Value.absent(),
    this.color = const Value.absent(),
    this.allDay = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.breakMinutes = const Value.absent(),
    this.payType = const Value.absent(),
    this.payAmount = const Value.absent(),
    this.location = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftTemplatesCompanion.insert({
    required String id,
    required String title,
    required String icon,
    required int color,
    required bool allDay,
    required int startMinute,
    required int endMinute,
    required int breakMinutes,
    required int payType,
    required int payAmount,
    required String location,
    required int sortOrder,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       icon = Value(icon),
       color = Value(color),
       allDay = Value(allDay),
       startMinute = Value(startMinute),
       endMinute = Value(endMinute),
       breakMinutes = Value(breakMinutes),
       payType = Value(payType),
       payAmount = Value(payAmount),
       location = Value(location),
       sortOrder = Value(sortOrder),
       updatedAt = Value(updatedAt);
  static Insertable<TemplateRow> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? icon,
    Expression<int>? color,
    Expression<bool>? allDay,
    Expression<int>? startMinute,
    Expression<int>? endMinute,
    Expression<int>? breakMinutes,
    Expression<int>? payType,
    Expression<int>? payAmount,
    Expression<String>? location,
    Expression<int>? sortOrder,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (icon != null) 'icon': icon,
      if (color != null) 'color': color,
      if (allDay != null) 'all_day': allDay,
      if (startMinute != null) 'start_minute': startMinute,
      if (endMinute != null) 'end_minute': endMinute,
      if (breakMinutes != null) 'break_minutes': breakMinutes,
      if (payType != null) 'pay_type': payType,
      if (payAmount != null) 'pay_amount': payAmount,
      if (location != null) 'location': location,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftTemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? icon,
    Value<int>? color,
    Value<bool>? allDay,
    Value<int>? startMinute,
    Value<int>? endMinute,
    Value<int>? breakMinutes,
    Value<int>? payType,
    Value<int>? payAmount,
    Value<String>? location,
    Value<int>? sortOrder,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ShiftTemplatesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      allDay: allDay ?? this.allDay,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      payType: payType ?? this.payType,
      payAmount: payAmount ?? this.payAmount,
      location: location ?? this.location,
      sortOrder: sortOrder ?? this.sortOrder,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (icon.present) {
      map['icon'] = Variable<String>(icon.value);
    }
    if (color.present) {
      map['color'] = Variable<int>(color.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (breakMinutes.present) {
      map['break_minutes'] = Variable<int>(breakMinutes.value);
    }
    if (payType.present) {
      map['pay_type'] = Variable<int>(payType.value);
    }
    if (payAmount.present) {
      map['pay_amount'] = Variable<int>(payAmount.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftTemplatesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('icon: $icon, ')
          ..write('color: $color, ')
          ..write('allDay: $allDay, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('breakMinutes: $breakMinutes, ')
          ..write('payType: $payType, ')
          ..write('payAmount: $payAmount, ')
          ..write('location: $location, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ShiftsTable extends Shifts with TableInfo<$ShiftsTable, ShiftRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ShiftsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinuteMeta = const VerificationMeta(
    'endMinute',
  );
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
    'end_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _breakMinutesMeta = const VerificationMeta(
    'breakMinutes',
  );
  @override
  late final GeneratedColumn<int> breakMinutes = GeneratedColumn<int>(
    'break_minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payTypeMeta = const VerificationMeta(
    'payType',
  );
  @override
  late final GeneratedColumn<int> payType = GeneratedColumn<int>(
    'pay_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payAmountMeta = const VerificationMeta(
    'payAmount',
  );
  @override
  late final GeneratedColumn<int> payAmount = GeneratedColumn<int>(
    'pay_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    day,
    allDay,
    startMinute,
    endMinute,
    breakMinutes,
    notes,
    location,
    payType,
    payAmount,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'shifts';
  @override
  VerificationContext validateIntegrity(
    Insertable<ShiftRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    } else if (isInserting) {
      context.missing(_allDayMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('end_minute')) {
      context.handle(
        _endMinuteMeta,
        endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinuteMeta);
    }
    if (data.containsKey('break_minutes')) {
      context.handle(
        _breakMinutesMeta,
        breakMinutes.isAcceptableOrUnknown(
          data['break_minutes']!,
          _breakMinutesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_breakMinutesMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('pay_type')) {
      context.handle(
        _payTypeMeta,
        payType.isAcceptableOrUnknown(data['pay_type']!, _payTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_payTypeMeta);
    }
    if (data.containsKey('pay_amount')) {
      context.handle(
        _payAmountMeta,
        payAmount.isAcceptableOrUnknown(data['pay_amount']!, _payAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_payAmountMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ShiftRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ShiftRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day'],
      )!,
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      )!,
      endMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minute'],
      )!,
      breakMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}break_minutes'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      payType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_type'],
      )!,
      payAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_amount'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $ShiftsTable createAlias(String alias) {
    return $ShiftsTable(attachedDatabase, alias);
  }
}

class ShiftRow extends DataClass implements Insertable<ShiftRow> {
  final String id;
  final String templateId;
  final int day;
  final bool allDay;
  final int startMinute;
  final int endMinute;
  final int breakMinutes;
  final String notes;
  final String location;
  final int payType;
  final int payAmount;
  final DateTime updatedAt;
  const ShiftRow({
    required this.id,
    required this.templateId,
    required this.day,
    required this.allDay,
    required this.startMinute,
    required this.endMinute,
    required this.breakMinutes,
    required this.notes,
    required this.location,
    required this.payType,
    required this.payAmount,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['template_id'] = Variable<String>(templateId);
    map['day'] = Variable<int>(day);
    map['all_day'] = Variable<bool>(allDay);
    map['start_minute'] = Variable<int>(startMinute);
    map['end_minute'] = Variable<int>(endMinute);
    map['break_minutes'] = Variable<int>(breakMinutes);
    map['notes'] = Variable<String>(notes);
    map['location'] = Variable<String>(location);
    map['pay_type'] = Variable<int>(payType);
    map['pay_amount'] = Variable<int>(payAmount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  ShiftsCompanion toCompanion(bool nullToAbsent) {
    return ShiftsCompanion(
      id: Value(id),
      templateId: Value(templateId),
      day: Value(day),
      allDay: Value(allDay),
      startMinute: Value(startMinute),
      endMinute: Value(endMinute),
      breakMinutes: Value(breakMinutes),
      notes: Value(notes),
      location: Value(location),
      payType: Value(payType),
      payAmount: Value(payAmount),
      updatedAt: Value(updatedAt),
    );
  }

  factory ShiftRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ShiftRow(
      id: serializer.fromJson<String>(json['id']),
      templateId: serializer.fromJson<String>(json['templateId']),
      day: serializer.fromJson<int>(json['day']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      endMinute: serializer.fromJson<int>(json['endMinute']),
      breakMinutes: serializer.fromJson<int>(json['breakMinutes']),
      notes: serializer.fromJson<String>(json['notes']),
      location: serializer.fromJson<String>(json['location']),
      payType: serializer.fromJson<int>(json['payType']),
      payAmount: serializer.fromJson<int>(json['payAmount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'templateId': serializer.toJson<String>(templateId),
      'day': serializer.toJson<int>(day),
      'allDay': serializer.toJson<bool>(allDay),
      'startMinute': serializer.toJson<int>(startMinute),
      'endMinute': serializer.toJson<int>(endMinute),
      'breakMinutes': serializer.toJson<int>(breakMinutes),
      'notes': serializer.toJson<String>(notes),
      'location': serializer.toJson<String>(location),
      'payType': serializer.toJson<int>(payType),
      'payAmount': serializer.toJson<int>(payAmount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  ShiftRow copyWith({
    String? id,
    String? templateId,
    int? day,
    bool? allDay,
    int? startMinute,
    int? endMinute,
    int? breakMinutes,
    String? notes,
    String? location,
    int? payType,
    int? payAmount,
    DateTime? updatedAt,
  }) => ShiftRow(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    day: day ?? this.day,
    allDay: allDay ?? this.allDay,
    startMinute: startMinute ?? this.startMinute,
    endMinute: endMinute ?? this.endMinute,
    breakMinutes: breakMinutes ?? this.breakMinutes,
    notes: notes ?? this.notes,
    location: location ?? this.location,
    payType: payType ?? this.payType,
    payAmount: payAmount ?? this.payAmount,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  ShiftRow copyWithCompanion(ShiftsCompanion data) {
    return ShiftRow(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      day: data.day.present ? data.day.value : this.day,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
      breakMinutes: data.breakMinutes.present
          ? data.breakMinutes.value
          : this.breakMinutes,
      notes: data.notes.present ? data.notes.value : this.notes,
      location: data.location.present ? data.location.value : this.location,
      payType: data.payType.present ? data.payType.value : this.payType,
      payAmount: data.payAmount.present ? data.payAmount.value : this.payAmount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ShiftRow(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('day: $day, ')
          ..write('allDay: $allDay, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('breakMinutes: $breakMinutes, ')
          ..write('notes: $notes, ')
          ..write('location: $location, ')
          ..write('payType: $payType, ')
          ..write('payAmount: $payAmount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    day,
    allDay,
    startMinute,
    endMinute,
    breakMinutes,
    notes,
    location,
    payType,
    payAmount,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ShiftRow &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.day == this.day &&
          other.allDay == this.allDay &&
          other.startMinute == this.startMinute &&
          other.endMinute == this.endMinute &&
          other.breakMinutes == this.breakMinutes &&
          other.notes == this.notes &&
          other.location == this.location &&
          other.payType == this.payType &&
          other.payAmount == this.payAmount &&
          other.updatedAt == this.updatedAt);
}

class ShiftsCompanion extends UpdateCompanion<ShiftRow> {
  final Value<String> id;
  final Value<String> templateId;
  final Value<int> day;
  final Value<bool> allDay;
  final Value<int> startMinute;
  final Value<int> endMinute;
  final Value<int> breakMinutes;
  final Value<String> notes;
  final Value<String> location;
  final Value<int> payType;
  final Value<int> payAmount;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const ShiftsCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.day = const Value.absent(),
    this.allDay = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.breakMinutes = const Value.absent(),
    this.notes = const Value.absent(),
    this.location = const Value.absent(),
    this.payType = const Value.absent(),
    this.payAmount = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ShiftsCompanion.insert({
    required String id,
    required String templateId,
    required int day,
    required bool allDay,
    required int startMinute,
    required int endMinute,
    required int breakMinutes,
    required String notes,
    required String location,
    required int payType,
    required int payAmount,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       templateId = Value(templateId),
       day = Value(day),
       allDay = Value(allDay),
       startMinute = Value(startMinute),
       endMinute = Value(endMinute),
       breakMinutes = Value(breakMinutes),
       notes = Value(notes),
       location = Value(location),
       payType = Value(payType),
       payAmount = Value(payAmount),
       updatedAt = Value(updatedAt);
  static Insertable<ShiftRow> custom({
    Expression<String>? id,
    Expression<String>? templateId,
    Expression<int>? day,
    Expression<bool>? allDay,
    Expression<int>? startMinute,
    Expression<int>? endMinute,
    Expression<int>? breakMinutes,
    Expression<String>? notes,
    Expression<String>? location,
    Expression<int>? payType,
    Expression<int>? payAmount,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (day != null) 'day': day,
      if (allDay != null) 'all_day': allDay,
      if (startMinute != null) 'start_minute': startMinute,
      if (endMinute != null) 'end_minute': endMinute,
      if (breakMinutes != null) 'break_minutes': breakMinutes,
      if (notes != null) 'notes': notes,
      if (location != null) 'location': location,
      if (payType != null) 'pay_type': payType,
      if (payAmount != null) 'pay_amount': payAmount,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ShiftsCompanion copyWith({
    Value<String>? id,
    Value<String>? templateId,
    Value<int>? day,
    Value<bool>? allDay,
    Value<int>? startMinute,
    Value<int>? endMinute,
    Value<int>? breakMinutes,
    Value<String>? notes,
    Value<String>? location,
    Value<int>? payType,
    Value<int>? payAmount,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return ShiftsCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      day: day ?? this.day,
      allDay: allDay ?? this.allDay,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      breakMinutes: breakMinutes ?? this.breakMinutes,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      payType: payType ?? this.payType,
      payAmount: payAmount ?? this.payAmount,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (breakMinutes.present) {
      map['break_minutes'] = Variable<int>(breakMinutes.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (payType.present) {
      map['pay_type'] = Variable<int>(payType.value);
    }
    if (payAmount.present) {
      map['pay_amount'] = Variable<int>(payAmount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShiftsCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('day: $day, ')
          ..write('allDay: $allDay, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('breakMinutes: $breakMinutes, ')
          ..write('notes: $notes, ')
          ..write('location: $location, ')
          ..write('payType: $payType, ')
          ..write('payAmount: $payAmount, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, EventRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<int> day = GeneratedColumn<int>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _allDayMeta = const VerificationMeta('allDay');
  @override
  late final GeneratedColumn<bool> allDay = GeneratedColumn<bool>(
    'all_day',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("all_day" IN (0, 1))',
    ),
  );
  static const VerificationMeta _startMinuteMeta = const VerificationMeta(
    'startMinute',
  );
  @override
  late final GeneratedColumn<int> startMinute = GeneratedColumn<int>(
    'start_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _endMinuteMeta = const VerificationMeta(
    'endMinute',
  );
  @override
  late final GeneratedColumn<int> endMinute = GeneratedColumn<int>(
    'end_minute',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _locationMeta = const VerificationMeta(
    'location',
  );
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
    'location',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payTypeMeta = const VerificationMeta(
    'payType',
  );
  @override
  late final GeneratedColumn<int> payType = GeneratedColumn<int>(
    'pay_type',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _payAmountMeta = const VerificationMeta(
    'payAmount',
  );
  @override
  late final GeneratedColumn<int> payAmount = GeneratedColumn<int>(
    'pay_amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    day,
    title,
    allDay,
    startMinute,
    endMinute,
    notes,
    location,
    payType,
    payAmount,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(
    Insertable<EventRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('all_day')) {
      context.handle(
        _allDayMeta,
        allDay.isAcceptableOrUnknown(data['all_day']!, _allDayMeta),
      );
    } else if (isInserting) {
      context.missing(_allDayMeta);
    }
    if (data.containsKey('start_minute')) {
      context.handle(
        _startMinuteMeta,
        startMinute.isAcceptableOrUnknown(
          data['start_minute']!,
          _startMinuteMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_startMinuteMeta);
    }
    if (data.containsKey('end_minute')) {
      context.handle(
        _endMinuteMeta,
        endMinute.isAcceptableOrUnknown(data['end_minute']!, _endMinuteMeta),
      );
    } else if (isInserting) {
      context.missing(_endMinuteMeta);
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    } else if (isInserting) {
      context.missing(_notesMeta);
    }
    if (data.containsKey('location')) {
      context.handle(
        _locationMeta,
        location.isAcceptableOrUnknown(data['location']!, _locationMeta),
      );
    } else if (isInserting) {
      context.missing(_locationMeta);
    }
    if (data.containsKey('pay_type')) {
      context.handle(
        _payTypeMeta,
        payType.isAcceptableOrUnknown(data['pay_type']!, _payTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_payTypeMeta);
    }
    if (data.containsKey('pay_amount')) {
      context.handle(
        _payAmountMeta,
        payAmount.isAcceptableOrUnknown(data['pay_amount']!, _payAmountMeta),
      );
    } else if (isInserting) {
      context.missing(_payAmountMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}day'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      allDay: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}all_day'],
      )!,
      startMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_minute'],
      )!,
      endMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}end_minute'],
      )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      )!,
      location: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}location'],
      )!,
      payType: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_type'],
      )!,
      payAmount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}pay_amount'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class EventRow extends DataClass implements Insertable<EventRow> {
  final String id;
  final int day;
  final String title;
  final bool allDay;
  final int startMinute;
  final int endMinute;
  final String notes;
  final String location;
  final int payType;
  final int payAmount;
  final DateTime updatedAt;
  const EventRow({
    required this.id,
    required this.day,
    required this.title,
    required this.allDay,
    required this.startMinute,
    required this.endMinute,
    required this.notes,
    required this.location,
    required this.payType,
    required this.payAmount,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['day'] = Variable<int>(day);
    map['title'] = Variable<String>(title);
    map['all_day'] = Variable<bool>(allDay);
    map['start_minute'] = Variable<int>(startMinute);
    map['end_minute'] = Variable<int>(endMinute);
    map['notes'] = Variable<String>(notes);
    map['location'] = Variable<String>(location);
    map['pay_type'] = Variable<int>(payType);
    map['pay_amount'] = Variable<int>(payAmount);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      day: Value(day),
      title: Value(title),
      allDay: Value(allDay),
      startMinute: Value(startMinute),
      endMinute: Value(endMinute),
      notes: Value(notes),
      location: Value(location),
      payType: Value(payType),
      payAmount: Value(payAmount),
      updatedAt: Value(updatedAt),
    );
  }

  factory EventRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventRow(
      id: serializer.fromJson<String>(json['id']),
      day: serializer.fromJson<int>(json['day']),
      title: serializer.fromJson<String>(json['title']),
      allDay: serializer.fromJson<bool>(json['allDay']),
      startMinute: serializer.fromJson<int>(json['startMinute']),
      endMinute: serializer.fromJson<int>(json['endMinute']),
      notes: serializer.fromJson<String>(json['notes']),
      location: serializer.fromJson<String>(json['location']),
      payType: serializer.fromJson<int>(json['payType']),
      payAmount: serializer.fromJson<int>(json['payAmount']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'day': serializer.toJson<int>(day),
      'title': serializer.toJson<String>(title),
      'allDay': serializer.toJson<bool>(allDay),
      'startMinute': serializer.toJson<int>(startMinute),
      'endMinute': serializer.toJson<int>(endMinute),
      'notes': serializer.toJson<String>(notes),
      'location': serializer.toJson<String>(location),
      'payType': serializer.toJson<int>(payType),
      'payAmount': serializer.toJson<int>(payAmount),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  EventRow copyWith({
    String? id,
    int? day,
    String? title,
    bool? allDay,
    int? startMinute,
    int? endMinute,
    String? notes,
    String? location,
    int? payType,
    int? payAmount,
    DateTime? updatedAt,
  }) => EventRow(
    id: id ?? this.id,
    day: day ?? this.day,
    title: title ?? this.title,
    allDay: allDay ?? this.allDay,
    startMinute: startMinute ?? this.startMinute,
    endMinute: endMinute ?? this.endMinute,
    notes: notes ?? this.notes,
    location: location ?? this.location,
    payType: payType ?? this.payType,
    payAmount: payAmount ?? this.payAmount,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  EventRow copyWithCompanion(EventsCompanion data) {
    return EventRow(
      id: data.id.present ? data.id.value : this.id,
      day: data.day.present ? data.day.value : this.day,
      title: data.title.present ? data.title.value : this.title,
      allDay: data.allDay.present ? data.allDay.value : this.allDay,
      startMinute: data.startMinute.present
          ? data.startMinute.value
          : this.startMinute,
      endMinute: data.endMinute.present ? data.endMinute.value : this.endMinute,
      notes: data.notes.present ? data.notes.value : this.notes,
      location: data.location.present ? data.location.value : this.location,
      payType: data.payType.present ? data.payType.value : this.payType,
      payAmount: data.payAmount.present ? data.payAmount.value : this.payAmount,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventRow(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('title: $title, ')
          ..write('allDay: $allDay, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('notes: $notes, ')
          ..write('location: $location, ')
          ..write('payType: $payType, ')
          ..write('payAmount: $payAmount, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    day,
    title,
    allDay,
    startMinute,
    endMinute,
    notes,
    location,
    payType,
    payAmount,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventRow &&
          other.id == this.id &&
          other.day == this.day &&
          other.title == this.title &&
          other.allDay == this.allDay &&
          other.startMinute == this.startMinute &&
          other.endMinute == this.endMinute &&
          other.notes == this.notes &&
          other.location == this.location &&
          other.payType == this.payType &&
          other.payAmount == this.payAmount &&
          other.updatedAt == this.updatedAt);
}

class EventsCompanion extends UpdateCompanion<EventRow> {
  final Value<String> id;
  final Value<int> day;
  final Value<String> title;
  final Value<bool> allDay;
  final Value<int> startMinute;
  final Value<int> endMinute;
  final Value<String> notes;
  final Value<String> location;
  final Value<int> payType;
  final Value<int> payAmount;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.day = const Value.absent(),
    this.title = const Value.absent(),
    this.allDay = const Value.absent(),
    this.startMinute = const Value.absent(),
    this.endMinute = const Value.absent(),
    this.notes = const Value.absent(),
    this.location = const Value.absent(),
    this.payType = const Value.absent(),
    this.payAmount = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EventsCompanion.insert({
    required String id,
    required int day,
    required String title,
    required bool allDay,
    required int startMinute,
    required int endMinute,
    required String notes,
    required String location,
    required int payType,
    required int payAmount,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       day = Value(day),
       title = Value(title),
       allDay = Value(allDay),
       startMinute = Value(startMinute),
       endMinute = Value(endMinute),
       notes = Value(notes),
       location = Value(location),
       payType = Value(payType),
       payAmount = Value(payAmount),
       updatedAt = Value(updatedAt);
  static Insertable<EventRow> custom({
    Expression<String>? id,
    Expression<int>? day,
    Expression<String>? title,
    Expression<bool>? allDay,
    Expression<int>? startMinute,
    Expression<int>? endMinute,
    Expression<String>? notes,
    Expression<String>? location,
    Expression<int>? payType,
    Expression<int>? payAmount,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (day != null) 'day': day,
      if (title != null) 'title': title,
      if (allDay != null) 'all_day': allDay,
      if (startMinute != null) 'start_minute': startMinute,
      if (endMinute != null) 'end_minute': endMinute,
      if (notes != null) 'notes': notes,
      if (location != null) 'location': location,
      if (payType != null) 'pay_type': payType,
      if (payAmount != null) 'pay_amount': payAmount,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EventsCompanion copyWith({
    Value<String>? id,
    Value<int>? day,
    Value<String>? title,
    Value<bool>? allDay,
    Value<int>? startMinute,
    Value<int>? endMinute,
    Value<String>? notes,
    Value<String>? location,
    Value<int>? payType,
    Value<int>? payAmount,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EventsCompanion(
      id: id ?? this.id,
      day: day ?? this.day,
      title: title ?? this.title,
      allDay: allDay ?? this.allDay,
      startMinute: startMinute ?? this.startMinute,
      endMinute: endMinute ?? this.endMinute,
      notes: notes ?? this.notes,
      location: location ?? this.location,
      payType: payType ?? this.payType,
      payAmount: payAmount ?? this.payAmount,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (day.present) {
      map['day'] = Variable<int>(day.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (allDay.present) {
      map['all_day'] = Variable<bool>(allDay.value);
    }
    if (startMinute.present) {
      map['start_minute'] = Variable<int>(startMinute.value);
    }
    if (endMinute.present) {
      map['end_minute'] = Variable<int>(endMinute.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (payType.present) {
      map['pay_type'] = Variable<int>(payType.value);
    }
    if (payAmount.present) {
      map['pay_amount'] = Variable<int>(payAmount.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('day: $day, ')
          ..write('title: $title, ')
          ..write('allDay: $allDay, ')
          ..write('startMinute: $startMinute, ')
          ..write('endMinute: $endMinute, ')
          ..write('notes: $notes, ')
          ..write('location: $location, ')
          ..write('payType: $payType, ')
          ..write('payAmount: $payAmount, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AttachmentsTable extends Attachments
    with TableInfo<$AttachmentsTable, AttachmentRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AttachmentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerTypeMeta = const VerificationMeta(
    'ownerType',
  );
  @override
  late final GeneratedColumn<String> ownerType = GeneratedColumn<String>(
    'owner_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ownerIdMeta = const VerificationMeta(
    'ownerId',
  );
  @override
  late final GeneratedColumn<String> ownerId = GeneratedColumn<String>(
    'owner_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
    'path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sizeMeta = const VerificationMeta('size');
  @override
  late final GeneratedColumn<int> size = GeneratedColumn<int>(
    'size',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ownerType,
    ownerId,
    name,
    path,
    size,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<AttachmentRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('owner_type')) {
      context.handle(
        _ownerTypeMeta,
        ownerType.isAcceptableOrUnknown(data['owner_type']!, _ownerTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerTypeMeta);
    }
    if (data.containsKey('owner_id')) {
      context.handle(
        _ownerIdMeta,
        ownerId.isAcceptableOrUnknown(data['owner_id']!, _ownerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ownerIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
        _pathMeta,
        path.isAcceptableOrUnknown(data['path']!, _pathMeta),
      );
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('size')) {
      context.handle(
        _sizeMeta,
        size.isAcceptableOrUnknown(data['size']!, _sizeMeta),
      );
    } else if (isInserting) {
      context.missing(_sizeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  AttachmentRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AttachmentRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      ownerType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_type'],
      )!,
      ownerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}owner_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      path: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}path'],
      )!,
      size: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}size'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $AttachmentsTable createAlias(String alias) {
    return $AttachmentsTable(attachedDatabase, alias);
  }
}

class AttachmentRow extends DataClass implements Insertable<AttachmentRow> {
  final String id;
  final String ownerType;
  final String ownerId;
  final String name;
  final String path;
  final int size;
  final DateTime createdAt;
  const AttachmentRow({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    required this.name,
    required this.path,
    required this.size,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['owner_type'] = Variable<String>(ownerType);
    map['owner_id'] = Variable<String>(ownerId);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    map['size'] = Variable<int>(size);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  AttachmentsCompanion toCompanion(bool nullToAbsent) {
    return AttachmentsCompanion(
      id: Value(id),
      ownerType: Value(ownerType),
      ownerId: Value(ownerId),
      name: Value(name),
      path: Value(path),
      size: Value(size),
      createdAt: Value(createdAt),
    );
  }

  factory AttachmentRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AttachmentRow(
      id: serializer.fromJson<String>(json['id']),
      ownerType: serializer.fromJson<String>(json['ownerType']),
      ownerId: serializer.fromJson<String>(json['ownerId']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      size: serializer.fromJson<int>(json['size']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'ownerType': serializer.toJson<String>(ownerType),
      'ownerId': serializer.toJson<String>(ownerId),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'size': serializer.toJson<int>(size),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  AttachmentRow copyWith({
    String? id,
    String? ownerType,
    String? ownerId,
    String? name,
    String? path,
    int? size,
    DateTime? createdAt,
  }) => AttachmentRow(
    id: id ?? this.id,
    ownerType: ownerType ?? this.ownerType,
    ownerId: ownerId ?? this.ownerId,
    name: name ?? this.name,
    path: path ?? this.path,
    size: size ?? this.size,
    createdAt: createdAt ?? this.createdAt,
  );
  AttachmentRow copyWithCompanion(AttachmentsCompanion data) {
    return AttachmentRow(
      id: data.id.present ? data.id.value : this.id,
      ownerType: data.ownerType.present ? data.ownerType.value : this.ownerType,
      ownerId: data.ownerId.present ? data.ownerId.value : this.ownerId,
      name: data.name.present ? data.name.value : this.name,
      path: data.path.present ? data.path.value : this.path,
      size: data.size.present ? data.size.value : this.size,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentRow(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('size: $size, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ownerType, ownerId, name, path, size, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AttachmentRow &&
          other.id == this.id &&
          other.ownerType == this.ownerType &&
          other.ownerId == this.ownerId &&
          other.name == this.name &&
          other.path == this.path &&
          other.size == this.size &&
          other.createdAt == this.createdAt);
}

class AttachmentsCompanion extends UpdateCompanion<AttachmentRow> {
  final Value<String> id;
  final Value<String> ownerType;
  final Value<String> ownerId;
  final Value<String> name;
  final Value<String> path;
  final Value<int> size;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const AttachmentsCompanion({
    this.id = const Value.absent(),
    this.ownerType = const Value.absent(),
    this.ownerId = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.size = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AttachmentsCompanion.insert({
    required String id,
    required String ownerType,
    required String ownerId,
    required String name,
    required String path,
    required int size,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       ownerType = Value(ownerType),
       ownerId = Value(ownerId),
       name = Value(name),
       path = Value(path),
       size = Value(size),
       createdAt = Value(createdAt);
  static Insertable<AttachmentRow> custom({
    Expression<String>? id,
    Expression<String>? ownerType,
    Expression<String>? ownerId,
    Expression<String>? name,
    Expression<String>? path,
    Expression<int>? size,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ownerType != null) 'owner_type': ownerType,
      if (ownerId != null) 'owner_id': ownerId,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (size != null) 'size': size,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AttachmentsCompanion copyWith({
    Value<String>? id,
    Value<String>? ownerType,
    Value<String>? ownerId,
    Value<String>? name,
    Value<String>? path,
    Value<int>? size,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return AttachmentsCompanion(
      id: id ?? this.id,
      ownerType: ownerType ?? this.ownerType,
      ownerId: ownerId ?? this.ownerId,
      name: name ?? this.name,
      path: path ?? this.path,
      size: size ?? this.size,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (ownerType.present) {
      map['owner_type'] = Variable<String>(ownerType.value);
    }
    if (ownerId.present) {
      map['owner_id'] = Variable<String>(ownerId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (size.present) {
      map['size'] = Variable<int>(size.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('ownerType: $ownerType, ')
          ..write('ownerId: $ownerId, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('size: $size, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ShiftTemplatesTable shiftTemplates = $ShiftTemplatesTable(this);
  late final $ShiftsTable shifts = $ShiftsTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $AttachmentsTable attachments = $AttachmentsTable(this);
  late final Index shiftsDay = Index(
    'shifts_day',
    'CREATE INDEX shifts_day ON shifts (day)',
  );
  late final Index shiftsTemplate = Index(
    'shifts_template',
    'CREATE INDEX shifts_template ON shifts (template_id, day)',
  );
  late final Index eventsDay = Index(
    'events_day',
    'CREATE INDEX events_day ON events (day)',
  );
  late final Index attachmentsOwner = Index(
    'attachments_owner',
    'CREATE INDEX attachments_owner ON attachments (owner_type, owner_id)',
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    shiftTemplates,
    shifts,
    events,
    attachments,
    shiftsDay,
    shiftsTemplate,
    eventsDay,
    attachmentsOwner,
  ];
}

typedef $$ShiftTemplatesTableCreateCompanionBuilder =
    ShiftTemplatesCompanion Function({
      required String id,
      required String title,
      required String icon,
      required int color,
      required bool allDay,
      required int startMinute,
      required int endMinute,
      required int breakMinutes,
      required int payType,
      required int payAmount,
      required String location,
      required int sortOrder,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ShiftTemplatesTableUpdateCompanionBuilder =
    ShiftTemplatesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> icon,
      Value<int> color,
      Value<bool> allDay,
      Value<int> startMinute,
      Value<int> endMinute,
      Value<int> breakMinutes,
      Value<int> payType,
      Value<int> payAmount,
      Value<String> location,
      Value<int> sortOrder,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ShiftTemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payType => $composableBuilder(
    column: $table.payType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payAmount => $composableBuilder(
    column: $table.payAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShiftTemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get icon => $composableBuilder(
    column: $table.icon,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get color => $composableBuilder(
    column: $table.color,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payType => $composableBuilder(
    column: $table.payType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payAmount => $composableBuilder(
    column: $table.payAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShiftTemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftTemplatesTable> {
  $$ShiftTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get icon =>
      $composableBuilder(column: $table.icon, builder: (column) => column);

  GeneratedColumn<int> get color =>
      $composableBuilder(column: $table.color, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  GeneratedColumn<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<int> get payType =>
      $composableBuilder(column: $table.payType, builder: (column) => column);

  GeneratedColumn<int> get payAmount =>
      $composableBuilder(column: $table.payAmount, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShiftTemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftTemplatesTable,
          TemplateRow,
          $$ShiftTemplatesTableFilterComposer,
          $$ShiftTemplatesTableOrderingComposer,
          $$ShiftTemplatesTableAnnotationComposer,
          $$ShiftTemplatesTableCreateCompanionBuilder,
          $$ShiftTemplatesTableUpdateCompanionBuilder,
          (
            TemplateRow,
            BaseReferences<_$AppDatabase, $ShiftTemplatesTable, TemplateRow>,
          ),
          TemplateRow,
          PrefetchHooks Function()
        > {
  $$ShiftTemplatesTableTableManager(
    _$AppDatabase db,
    $ShiftTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftTemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftTemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftTemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> icon = const Value.absent(),
                Value<int> color = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<int> startMinute = const Value.absent(),
                Value<int> endMinute = const Value.absent(),
                Value<int> breakMinutes = const Value.absent(),
                Value<int> payType = const Value.absent(),
                Value<int> payAmount = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftTemplatesCompanion(
                id: id,
                title: title,
                icon: icon,
                color: color,
                allDay: allDay,
                startMinute: startMinute,
                endMinute: endMinute,
                breakMinutes: breakMinutes,
                payType: payType,
                payAmount: payAmount,
                location: location,
                sortOrder: sortOrder,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String icon,
                required int color,
                required bool allDay,
                required int startMinute,
                required int endMinute,
                required int breakMinutes,
                required int payType,
                required int payAmount,
                required String location,
                required int sortOrder,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ShiftTemplatesCompanion.insert(
                id: id,
                title: title,
                icon: icon,
                color: color,
                allDay: allDay,
                startMinute: startMinute,
                endMinute: endMinute,
                breakMinutes: breakMinutes,
                payType: payType,
                payAmount: payAmount,
                location: location,
                sortOrder: sortOrder,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShiftTemplatesTable, TemplateRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ShiftTemplatesTable,
                    TemplateRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShiftTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftTemplatesTable,
      TemplateRow,
      $$ShiftTemplatesTableFilterComposer,
      $$ShiftTemplatesTableOrderingComposer,
      $$ShiftTemplatesTableAnnotationComposer,
      $$ShiftTemplatesTableCreateCompanionBuilder,
      $$ShiftTemplatesTableUpdateCompanionBuilder,
      (
        TemplateRow,
        BaseReferences<_$AppDatabase, $ShiftTemplatesTable, TemplateRow>,
      ),
      TemplateRow,
      PrefetchHooks Function()
    >;
typedef $$ShiftsTableCreateCompanionBuilder =
    ShiftsCompanion Function({
      required String id,
      required String templateId,
      required int day,
      required bool allDay,
      required int startMinute,
      required int endMinute,
      required int breakMinutes,
      required String notes,
      required String location,
      required int payType,
      required int payAmount,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$ShiftsTableUpdateCompanionBuilder =
    ShiftsCompanion Function({
      Value<String> id,
      Value<String> templateId,
      Value<int> day,
      Value<bool> allDay,
      Value<int> startMinute,
      Value<int> endMinute,
      Value<int> breakMinutes,
      Value<String> notes,
      Value<String> location,
      Value<int> payType,
      Value<int> payAmount,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$ShiftsTableFilterComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payType => $composableBuilder(
    column: $table.payType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payAmount => $composableBuilder(
    column: $table.payAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ShiftsTableOrderingComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payType => $composableBuilder(
    column: $table.payType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payAmount => $composableBuilder(
    column: $table.payAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ShiftsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ShiftsTable> {
  $$ShiftsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  GeneratedColumn<int> get breakMinutes => $composableBuilder(
    column: $table.breakMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get payType =>
      $composableBuilder(column: $table.payType, builder: (column) => column);

  GeneratedColumn<int> get payAmount =>
      $composableBuilder(column: $table.payAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ShiftsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ShiftsTable,
          ShiftRow,
          $$ShiftsTableFilterComposer,
          $$ShiftsTableOrderingComposer,
          $$ShiftsTableAnnotationComposer,
          $$ShiftsTableCreateCompanionBuilder,
          $$ShiftsTableUpdateCompanionBuilder,
          (ShiftRow, BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>),
          ShiftRow,
          PrefetchHooks Function()
        > {
  $$ShiftsTableTableManager(_$AppDatabase db, $ShiftsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ShiftsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ShiftsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ShiftsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> day = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<int> startMinute = const Value.absent(),
                Value<int> endMinute = const Value.absent(),
                Value<int> breakMinutes = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<int> payType = const Value.absent(),
                Value<int> payAmount = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ShiftsCompanion(
                id: id,
                templateId: templateId,
                day: day,
                allDay: allDay,
                startMinute: startMinute,
                endMinute: endMinute,
                breakMinutes: breakMinutes,
                notes: notes,
                location: location,
                payType: payType,
                payAmount: payAmount,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String templateId,
                required int day,
                required bool allDay,
                required int startMinute,
                required int endMinute,
                required int breakMinutes,
                required String notes,
                required String location,
                required int payType,
                required int payAmount,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => ShiftsCompanion.insert(
                id: id,
                templateId: templateId,
                day: day,
                allDay: allDay,
                startMinute: startMinute,
                endMinute: endMinute,
                breakMinutes: breakMinutes,
                notes: notes,
                location: location,
                payType: payType,
                payAmount: payAmount,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ShiftsTable, ShiftRow>(table),
                  BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ShiftsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ShiftsTable,
      ShiftRow,
      $$ShiftsTableFilterComposer,
      $$ShiftsTableOrderingComposer,
      $$ShiftsTableAnnotationComposer,
      $$ShiftsTableCreateCompanionBuilder,
      $$ShiftsTableUpdateCompanionBuilder,
      (ShiftRow, BaseReferences<_$AppDatabase, $ShiftsTable, ShiftRow>),
      ShiftRow,
      PrefetchHooks Function()
    >;
typedef $$EventsTableCreateCompanionBuilder =
    EventsCompanion Function({
      required String id,
      required int day,
      required String title,
      required bool allDay,
      required int startMinute,
      required int endMinute,
      required String notes,
      required String location,
      required int payType,
      required int payAmount,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$EventsTableUpdateCompanionBuilder =
    EventsCompanion Function({
      Value<String> id,
      Value<int> day,
      Value<String> title,
      Value<bool> allDay,
      Value<int> startMinute,
      Value<int> endMinute,
      Value<String> notes,
      Value<String> location,
      Value<int> payType,
      Value<int> payAmount,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payType => $composableBuilder(
    column: $table.payType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get payAmount => $composableBuilder(
    column: $table.payAmount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get allDay => $composableBuilder(
    column: $table.allDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get endMinute => $composableBuilder(
    column: $table.endMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get location => $composableBuilder(
    column: $table.location,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payType => $composableBuilder(
    column: $table.payType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get payAmount => $composableBuilder(
    column: $table.payAmount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<bool> get allDay =>
      $composableBuilder(column: $table.allDay, builder: (column) => column);

  GeneratedColumn<int> get startMinute => $composableBuilder(
    column: $table.startMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get endMinute =>
      $composableBuilder(column: $table.endMinute, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<int> get payType =>
      $composableBuilder(column: $table.payType, builder: (column) => column);

  GeneratedColumn<int> get payAmount =>
      $composableBuilder(column: $table.payAmount, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$EventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EventsTable,
          EventRow,
          $$EventsTableFilterComposer,
          $$EventsTableOrderingComposer,
          $$EventsTableAnnotationComposer,
          $$EventsTableCreateCompanionBuilder,
          $$EventsTableUpdateCompanionBuilder,
          (EventRow, BaseReferences<_$AppDatabase, $EventsTable, EventRow>),
          EventRow,
          PrefetchHooks Function()
        > {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> day = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<bool> allDay = const Value.absent(),
                Value<int> startMinute = const Value.absent(),
                Value<int> endMinute = const Value.absent(),
                Value<String> notes = const Value.absent(),
                Value<String> location = const Value.absent(),
                Value<int> payType = const Value.absent(),
                Value<int> payAmount = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion(
                id: id,
                day: day,
                title: title,
                allDay: allDay,
                startMinute: startMinute,
                endMinute: endMinute,
                notes: notes,
                location: location,
                payType: payType,
                payAmount: payAmount,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int day,
                required String title,
                required bool allDay,
                required int startMinute,
                required int endMinute,
                required String notes,
                required String location,
                required int payType,
                required int payAmount,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EventsCompanion.insert(
                id: id,
                day: day,
                title: title,
                allDay: allDay,
                startMinute: startMinute,
                endMinute: endMinute,
                notes: notes,
                location: location,
                payType: payType,
                payAmount: payAmount,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EventsTable, EventRow>(table),
                  BaseReferences<_$AppDatabase, $EventsTable, EventRow>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EventsTable,
      EventRow,
      $$EventsTableFilterComposer,
      $$EventsTableOrderingComposer,
      $$EventsTableAnnotationComposer,
      $$EventsTableCreateCompanionBuilder,
      $$EventsTableUpdateCompanionBuilder,
      (EventRow, BaseReferences<_$AppDatabase, $EventsTable, EventRow>),
      EventRow,
      PrefetchHooks Function()
    >;
typedef $$AttachmentsTableCreateCompanionBuilder =
    AttachmentsCompanion Function({
      required String id,
      required String ownerType,
      required String ownerId,
      required String name,
      required String path,
      required int size,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$AttachmentsTableUpdateCompanionBuilder =
    AttachmentsCompanion Function({
      Value<String> id,
      Value<String> ownerType,
      Value<String> ownerId,
      Value<String> name,
      Value<String> path,
      Value<int> size,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$AttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerType => $composableBuilder(
    column: $table.ownerType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ownerId => $composableBuilder(
    column: $table.ownerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get path => $composableBuilder(
    column: $table.path,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get size => $composableBuilder(
    column: $table.size,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AttachmentsTable> {
  $$AttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ownerType =>
      $composableBuilder(column: $table.ownerType, builder: (column) => column);

  GeneratedColumn<String> get ownerId =>
      $composableBuilder(column: $table.ownerId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get path =>
      $composableBuilder(column: $table.path, builder: (column) => column);

  GeneratedColumn<int> get size =>
      $composableBuilder(column: $table.size, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AttachmentsTable,
          AttachmentRow,
          $$AttachmentsTableFilterComposer,
          $$AttachmentsTableOrderingComposer,
          $$AttachmentsTableAnnotationComposer,
          $$AttachmentsTableCreateCompanionBuilder,
          $$AttachmentsTableUpdateCompanionBuilder,
          (
            AttachmentRow,
            BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
          ),
          AttachmentRow,
          PrefetchHooks Function()
        > {
  $$AttachmentsTableTableManager(_$AppDatabase db, $AttachmentsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AttachmentsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> ownerType = const Value.absent(),
                Value<String> ownerId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> path = const Value.absent(),
                Value<int> size = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                name: name,
                path: path,
                size: size,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String ownerType,
                required String ownerId,
                required String name,
                required String path,
                required int size,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => AttachmentsCompanion.insert(
                id: id,
                ownerType: ownerType,
                ownerId: ownerId,
                name: name,
                path: path,
                size: size,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AttachmentsTable, AttachmentRow>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $AttachmentsTable,
                    AttachmentRow
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AttachmentsTable,
      AttachmentRow,
      $$AttachmentsTableFilterComposer,
      $$AttachmentsTableOrderingComposer,
      $$AttachmentsTableAnnotationComposer,
      $$AttachmentsTableCreateCompanionBuilder,
      $$AttachmentsTableUpdateCompanionBuilder,
      (
        AttachmentRow,
        BaseReferences<_$AppDatabase, $AttachmentsTable, AttachmentRow>,
      ),
      AttachmentRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ShiftTemplatesTableTableManager get shiftTemplates =>
      $$ShiftTemplatesTableTableManager(_db, _db.shiftTemplates);
  $$ShiftsTableTableManager get shifts =>
      $$ShiftsTableTableManager(_db, _db.shifts);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$AttachmentsTableTableManager get attachments =>
      $$AttachmentsTableTableManager(_db, _db.attachments);
}
