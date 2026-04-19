import 'dart:convert';
import 'dart:typed_data';
import 'package:nearby_connections/nearby_connections.dart';

class P2PSyncService {
  final Strategy strategy = Strategy.P2P_STAR;
  final String userName = "User_${DateTime.now().millisecond}";

  /// Starts advertising the device for peer discovery.
  Future<void> startAdvertising() async {
    await Nearby().startAdvertising(
      userName,
      strategy,
      onConnectionInitiated: (id, info) {
        Nearby().acceptConnection(id, onPayLoadRecieved: _onPayloadReceived);
      },
      onConnectionResult: (id, status) {},
      onDisconnected: (id) {},
      serviceId: "com.vheins.notulensi",
    );
  }

  /// Starts searching for nearby devices.
  Future<void> startDiscovery() async {
    await Nearby().startDiscovery(
      userName,
      strategy,
      onEndpointFound: (id, name, serviceId) {
        Nearby().requestConnection(
          userName,
          id,
          onConnectionInitiated: (id, info) {
            Nearby().acceptConnection(id, onPayLoadRecieved: _onPayloadReceived);
          },
          onConnectionResult: (id, status) {},
          onDisconnected: (id) {},
        );
      },
      onEndpointLost: (id) {},
      serviceId: "com.vheins.notulensi",
    );
  }

  /// Sends a marker sync event to all connected peers.
  Future<void> syncMarker(String endpointId, Map<String, dynamic> data) async {
    final payload = Uint8List.fromList(utf8.encode(jsonEncode(data)));
    await Nearby().sendBytesPayload(endpointId, payload);
  }

  void _onPayloadReceived(String endpointId, Payload payload) {
    if (payload.type == PayloadType.BYTES) {
      final String dataString = utf8.decode(payload.bytes!);
      // ignore: unused_local_variable
      final data = jsonDecode(dataString);
      // Trigger event handling logic (e.g. adding a shared marker)
    }
  }

  Future<void> stopAll() async {
    await Nearby().stopAdvertising();
    await Nearby().stopDiscovery();
    await Nearby().stopAllEndpoints();
  }
}
