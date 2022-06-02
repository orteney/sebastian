import 'dart:convert';
import 'dart:io';

Future<File?> findExePathByProcessName(String name) async {
  final cmd =
      'Get-CimInstance -ClassName Win32_Process -Filter "Name like \'$name\'" | select ExecutablePath | format-table -wrap -HideTableHeaders';

  var result = await Process.start('powershell.exe', ['/c', cmd]);

  List<String> resultData;

  try {
    resultData = await result.stdout.transform(utf8.decoder).toList();
  } catch (e) {
    // Happens with Cyrillic symbols in path
    return null;
  }

  final filteredData = resultData.map((e) => e.trim()).where((element) => element.isNotEmpty).toList();

  if (filteredData.isEmpty) {
    return null;
  }

  final path = filteredData.first;

  return File(path);
}
