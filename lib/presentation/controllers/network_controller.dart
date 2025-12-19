import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _subscription;
  final RxBool isConnected = true.obs;
  final RxBool isBannerVisible = false.obs;

  @override
  void onInit() {
    super.onInit();
    // Verify initial status
    _initConnectivity();
    // Listen to changes
    _subscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }

  Future<void> _initConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      _updateConnectionStatus(result);
    } catch (e) {
      debugPrint("Connectivity Error: $e");
    }
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    // If ANY result is not none, we are connected (simplification)
    // Actually ConnectivityResult.none means no connection.
    // If the list contains .none and ONLY .none (or empty?), it's offline.
    // Usually results list contains the active connection types.

    // Check if any active connection exists
    bool hasConnection = results.any((r) => r != ConnectivityResult.none);

    // Debounce/Transition logic could be added here if needed

    if (!hasConnection && isConnected.value) {
      isConnected.value = false;
      _showOfflineBanner();
    } else if (hasConnection && !isConnected.value) {
      isConnected.value = true;
      _hideOfflineBannerAndShowOnline();
    }
  }

  void _showOfflineBanner() {
    isBannerVisible.value = true;
    Get.rawSnackbar(
      messageText: const Text(
        "No Internet Connection",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      isDismissible: false,
      duration: const Duration(days: 1), // Persistent
      backgroundColor: Colors.red[900]!,
      icon: const Icon(Icons.wifi_off, color: Colors.white, size: 35),
      margin: EdgeInsets.zero,
      snackStyle: SnackStyle.GROUNDED,
    );
  }

  void _hideOfflineBannerAndShowOnline() {
    isBannerVisible.value = false;
    if (Get.isSnackbarOpen) {
      Get.closeCurrentSnackbar();
    }
    Get.rawSnackbar(
      messageText: const Text(
        "Back Online",
        style: TextStyle(color: Colors.white, fontSize: 14),
      ),
      duration: const Duration(seconds: 3),
      backgroundColor: Colors.green[800]!,
      icon: const Icon(Icons.wifi, color: Colors.white, size: 35),
      margin: EdgeInsets.zero,
      snackStyle: SnackStyle.GROUNDED,
    );
  }
}
