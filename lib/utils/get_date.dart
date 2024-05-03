class GetTime {
  String calculateTime(String creation) {
    Duration diff = DateTime.now().difference(DateTime.parse(creation));
    return 'Seit ${diff.inDays} tagen';
  }

  String calculateRemainingDays(String end, String start) {
    Duration diff = DateTime.parse(end).difference(DateTime.parse(start));
    return 'Noch ${diff.inDays} tage';
  }
}
