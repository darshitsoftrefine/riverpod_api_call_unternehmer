import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/widget_model.dart';
import '../utils/string_constants.dart';

class ModelListNotifier extends StateNotifier<List<Model>> {
  ModelListNotifier() : super([]);

  Future<void> configToNewPosition() async {
    final prefs = await SharedPreferences.getInstance();
    final lst = prefs.getStringList(ConstantStrings.sharedPreferencesKey);
    if (lst != null && lst.isNotEmpty) {
      state = lst.map((e) => state.firstWhere((Model item) => int.parse(e) == item.index)).toList();
    }
  }
}

final modelListProvider = StateNotifierProvider<ModelListNotifier, List<Model>>((ref) {
  return ModelListNotifier();
});