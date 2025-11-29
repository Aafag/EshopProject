import 'package:flutter/foundation.dart';
import '../models/feature_flags.dart';
import '../services/flag_service.dart';

class FeatureFlagProvider extends ChangeNotifier {
  final FlagService service;

  FeatureFlags flags = FeatureFlags.empty;
  bool isLoading = false;

  FeatureFlagProvider({required this.service});

  Future<void> loadFlags() async {
    isLoading = true;
    notifyListeners();
    flags = await service.fetchFlags();
    isLoading = false;
    notifyListeners();
  }

  Future<void> refresh() => loadFlags();
}
