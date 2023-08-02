int _hashCombine(int hash, int value) {
  hash = 0x1fffffff & (hash + value);
  hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
  return hash ^ (hash >> 6);
}

int _hashFinish(int hash) {
  hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
  hash = hash ^ (hash >> 11);
  return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
}

int hash(List<dynamic> h) {
  var value = _hashCombine(0, h.first.hashCode);
  for (final item in h.skip(1)) {
    value = _hashCombine(value, item.hashCode);
  }
  return _hashFinish(value);
}
