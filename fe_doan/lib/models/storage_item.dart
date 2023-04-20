class StorageItem {
  final String key;
  final String value;
  StorageItem(this.key, this.value);

  void Println() {
    print("key: $key, value: $value");
  }
}
