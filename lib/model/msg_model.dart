class Message {
  String text;
  String uid;
  DateTime time;

  Message({required this.text, required this.uid, required this.time});

  Map<String, dynamic> toJson() {
    return {"text": text, "uid": uid, "time": time.toString()};
  }
}
