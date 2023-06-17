class StorageItem {
  final String key;
  final String value;
  StorageItem(this.key, this.value);

  // ignore: non_constant_identifier_names
  void Println() {
    // ignore: avoid_print
    print("key: $key, value: $value");
  }
}
