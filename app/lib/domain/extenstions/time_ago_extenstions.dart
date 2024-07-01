extension TimeAgoExtension on int? {
  String timeAgo() {
    if (this == null) return "";

    final DateTime now = DateTime.now();
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(this!);

    final Duration diff = now.difference(date);

    if (diff.inSeconds < 60) {
      return "just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} minutes ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hours ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} days ago";
    } else if (diff.inDays < 30) {
      return "${diff.inDays ~/ 7} weeks ago";
    } else if (diff.inDays < 365) {
      return "${diff.inDays ~/ 30} months ago";
    } else {
      return "${diff.inDays ~/ 365} years ago";
    }
  }
}
