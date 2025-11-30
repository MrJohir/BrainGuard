import 'package:flutter/material.dart';
import 'package:lustless_hichim890/app.dart';
import 'package:lustless_hichim890/core/services/storage_service.dart';

void main() async {
  await _setupStripe();
  await StorageService.init();
  runApp(const Lustless());
}

Future<void> _setupStripe() async {
  WidgetsFlutterBinding.ensureInitialized();
}
