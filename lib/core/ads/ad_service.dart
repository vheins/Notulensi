import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import '../security/secure_storage_service.dart';

class AdService extends GetxService {
  final SecureStorageService _secureStorage;
  
  AdService({required SecureStorageService secureStorage}) : _secureStorage = secureStorage;

  RewardedAd? _rewardedAd;
  final isLoading = false.obs;
  final isPro = false.obs;

  // Test Ad Unit IDs
  final String _rewardedAdUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  Future<void> init() async {
    await MobileAds.instance.initialize();
    await checkProStatus();
    _loadRewardedAd();
  }

  Future<void> checkProStatus() async {
    isPro.value = await isProActive();
  }

  void _loadRewardedAd() {
    isLoading.value = true;
    RewardedAd.load(
      adUnitId: _rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          _rewardedAd = ad;
          isLoading.value = false;
        },
        onAdFailedToLoad: (error) {
          _rewardedAd = null;
          isLoading.value = false;
          // Retry logic could be added here
        },
      ),
    );
  }

  Future<void> showRewardAd({required Function() onRewardGranted}) async {
    if (_rewardedAd == null) {
      Get.snackbar('Ad Not Ready', 'Please wait while the ad loads.');
      _loadRewardedAd();
      return;
    }

    await _rewardedAd!.show(
      onUserEarnedReward: (ad, reward) async {
        await _grantProAccess();
        await checkProStatus();
        onRewardGranted();
        _loadRewardedAd(); // Load next one
      },
    );
  }

  Future<void> _grantProAccess() async {
    final expiry = DateTime.now().add(const Duration(hours: 24));
    await _secureStorage.save('pro_access_expiry', expiry.toIso8601String());
  }

  Future<bool> isProActive() async {
    final expiryStr = await _secureStorage.read('pro_access_expiry');
    if (expiryStr == null) return false;
    
    final expiry = DateTime.tryParse(expiryStr);
    if (expiry == null) return false;
    
    return DateTime.now().isBefore(expiry);
  }
}
