import 'package:catcher/catcher.dart';
import 'package:intl/intl.dart';

Future<String> buildMessage(Report report) async {
  final StringBuffer stringBuffer = StringBuffer();
  stringBuffer.write("\n\n**----------NEW REPORT----------**\n\n");

  stringBuffer.write(
      "**CreateAt:** ${DateFormat('EEEE, dd MMMM yyyy - kk:mm:ss').format(
    DateTime.parse(report.dateTime.toIso8601String()),
  )}\n\n");

  stringBuffer.write("**Error:**\n${await report.error} \n\n");

  stringBuffer.write("**Stack trace:**\n${await report.stackTrace}\n\n");

  stringBuffer.write("**Device parameters:**\n");
  for (final entry in report.deviceParameters.entries) {
    stringBuffer.write("${entry.key}: ${entry.value}\n");
  }
  stringBuffer.write("\n");

  stringBuffer.write("**Application parameters:**\n");
  for (final entry in report.applicationParameters.entries) {
    stringBuffer.write("${entry.key}: ${entry.value}\n");
  }
  stringBuffer.write("\n");

  return stringBuffer.toString();
}
