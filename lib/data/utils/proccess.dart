import 'dart:convert';
import 'dart:io';

Future<File?> findExePathByProcessName(String name) async {
  final cmd =
      'Get-CimInstance -ClassName Win32_Process -Filter "Name like \'$name\'" | select ExecutablePath | format-table -wrap -HideTableHeaders';

  List<String> resultData;

  try {
    var result = await Process.start('powershell.exe', ['/c', cmd]);
    resultData = await result.stdout.transform(utf8.decoder).toList();
  } catch (e) {
    // Happens when no powershell or with cyrillic symbols in path
    return null;
  }

  final filteredData = resultData.map((e) => e.trim()).where((element) => element.isNotEmpty).toList();

  if (filteredData.isEmpty) {
    return null;
  }

  final path = filteredData.first;

  return File(path);
}
