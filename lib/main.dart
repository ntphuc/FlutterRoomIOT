import 'package:demo_b/app.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:oktoast/oktoast.dart';

import 'services/io.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await IO.getInstance();
  Intl.defaultLocale = "vi";
  runApp(
    OKToast(
      child: App(),
    ),
  );
}
