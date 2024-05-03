class Model {
  int index;
  String title;

  Model({required this.index, required this.title});

  @override
  String toString() {
    return '$index : $title';
  }
}