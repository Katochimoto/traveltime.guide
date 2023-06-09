import 'package:latlong2/latlong.dart' as ll;

List<ll.LatLng> decodePolyline(String str) {
  int index = 0;
  double lat = 0;
  double lng = 0;
  List<ll.LatLng> coordinates = [];
  int shift = 0;
  int result = 0;
  int? byte;

  while (index < str.length) {
    byte = null;
    shift = 0;
    result = 0;

    do {
      byte = str.codeUnitAt(index++) - 63;
      result |= (byte & 0x1f) << shift;
      shift += 5;
    } while (byte >= 0x20);

    lat += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));

    shift = 0;
    result = 0;

    do {
      byte = str.codeUnitAt(index++) - 63;
      result |= (byte & 0x1f) << shift;
      shift += 5;
    } while (byte >= 0x20);

    lng += ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
    coordinates.add(ll.LatLng(lat / 1E6, lng / 1E6));
  }

  return coordinates;
}
