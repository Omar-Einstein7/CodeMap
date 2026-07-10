import 'package:flutter/material.dart';
import 'package:codemap2/src/services/service_locator.dart' as di;
import 'package:codemap2/src/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const CodeMapApp());
}
