import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_saver/controllers/wifi_smartconfig_controller.dart';
import 'package:water_saver/models/connection_model.dart';

final wifiSmartConfigProvider =
    AsyncNotifierProvider<WifiSmartConfigController, ConnectionModel>(
  () => WifiSmartConfigController(),
);
