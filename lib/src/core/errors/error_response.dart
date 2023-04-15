class ErrorResp {
  ErrorResp({
    required this.msg,
    required this.status,
  });

  final String msg;
  final int status;

  factory ErrorResp.fromJson(Map<String, dynamic> json) => ErrorResp(
        msg: json["msg"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "msg": msg,
        "status": status,
      };
}
