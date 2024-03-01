class ChangePassModel {
  int? userId;
  String? currentPwd;
  String? newPwd;

  ChangePassModel({
    this.userId,
    this.currentPwd,
    this.newPwd,
  });

  Map<String, String> toJson() {
    return {
      "id": userId!.toString(),
      // "old_pwd": currentPwd!,
      // "new_pwd": newPwd!,
      "password": newPwd!,
    };
  }
}
