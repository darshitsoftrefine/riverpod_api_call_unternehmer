import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/utils/string_constants.dart';

import '../controller/tenants_controller.dart';
import '../model/tenants_model.dart';

final userDataProvider = FutureProvider<List<TenantsData>>((ref) async {
  return ref.watch(userProvider).fetchTenantsItems(ConstantStrings.dynamicId);
});