import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class PipService {
  /// Enables an overlay window to show live transcription while using other apps.
  /// This is an Android-optimized replacement for system PiP.
  Future<void> showOverlay() async {
    final bool status = await FlutterOverlayWindow.isPermissionGranted();
    if (!status) {
      await FlutterOverlayWindow.requestPermission();
    }
    
    if (await FlutterOverlayWindow.isPermissionGranted()) {
      await FlutterOverlayWindow.showOverlay(
        enableDrag: true,
        overlayTitle: "Live Transcript",
        overlayContent: "Transcription active...",
        flag: OverlayFlag.defaultFlag,
        alignment: OverlayAlignment.centerLeft,
        visibility: NotificationVisibility.visibilityPublic,
        positionGravity: PositionGravity.left,
        height: 400,
        width: 600,
      );
    }
  }

  Future<void> closeOverlay() async {
    await FlutterOverlayWindow.closeOverlay();
  }

  Future<void> updateOverlayData(Map<String, dynamic> data) async {
    await FlutterOverlayWindow.shareData(data);
  }
}
