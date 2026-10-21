import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app/routes.dart';
import '../../domain/models/shift_template.dart';

Future<ShiftTemplate?> openTemplateEditor(BuildContext context, {String? id}) {
  return context.push<ShiftTemplate>(id == null ? Routes.newTemplate : Routes.templateById(id));
}
