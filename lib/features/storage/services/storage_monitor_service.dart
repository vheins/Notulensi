import 'package:storage_space/storage_space.dart';

class StorageMonitorService {
  /// Minimum free space required to continue recording (50MB)
  static const int minFreeSpaceMb = 50;

  /// Returns true if there is enough space to continue recording.
  Future<bool> hasEnoughSpace() async {
    final storageSpace = await getStorageSpace(
      lowOnSpaceThreshold: minFreeSpaceMb * 1024 * 1024,
      fractionDigits: 2,
    );
    return storageSpace.free / (1024 * 1024) > minFreeSpaceMb;
  }

  /// Returns the current free space in MB.
  Future<double> getFreeSpaceMb() async {
    final storageSpace = await getStorageSpace(
      lowOnSpaceThreshold: minFreeSpaceMb * 1024 * 1024,
      fractionDigits: 2,
    );
    return storageSpace.free / (1024 * 1024);
  }
}
