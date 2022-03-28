class Task {
  final String id;
  final String text;
  bool isChecked;
  Task({required this.id, required this.text, required this.isChecked});

  void check() {
    isChecked = !isChecked;
  }
}
