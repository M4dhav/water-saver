import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:water_saver/controllers/graph_controller.dart';
import 'package:water_saver/models/graph_page_model.dart';

final graphControllerProvider =
    AsyncNotifierProvider<GraphController, GraphPageModel>(
        () => GraphController());
