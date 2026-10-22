final _heading = RegExp(r'^#+\s*');
final _bullet = RegExp(r'^[*-]\s+');
final _author = RegExp(r'\s+by @\S+ in https?://\S+$');
final _fullChangelog = RegExp(r'^\*\*Full Changelog\*\*');
final _emphasis = RegExp(r'\*\*(.+?)\*\*');

String releaseNotesToPlainText(String markdown) {
  final lines = <String>[];

  for (final raw in markdown.split(RegExp(r'\r?\n'))) {
    var line = raw.trim();

    if (_fullChangelog.hasMatch(line)) {
      continue;
    }

    line = line
        .replaceFirst(_heading, '')
        .replaceFirst(_bullet, '• ')
        .replaceFirst(_author, '')
        .replaceAllMapped(_emphasis, (match) => match.group(1)!);
    lines.add(line);
  }

  return lines.join('\n').replaceAll(RegExp(r'\n{3,}'), '\n\n').trim();
}
