import 'package:flutter/material.dart';

import '../../../core/widgets/group_card.dart';
import '../../../core/widgets/inline_text_field.dart';
import '../../../l10n/app_localizations.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({required this.notes, required this.location, super.key});

  final TextEditingController notes;
  final TextEditingController location;

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context);

    return GroupCard(
      children: [
        InlineTextField(controller: notes, hint: l.notes, maxLines: 4, minLines: 1),
        InlineTextField(controller: location, hint: l.location),
      ],
    );
  }
}
