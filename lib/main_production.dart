import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:kanban/app/app.dart';
import 'package:kanban/bootstrap.dart';
import 'package:kanban/core/services/dependency_injection/locator.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    bootstrap(() => const App());
  } catch (error, stackTrace) {
    log('Error: $error');
    log('Stacktrace: $stackTrace');
  }
}
