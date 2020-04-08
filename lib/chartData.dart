class FireData {
  final double amount;
  final String account;
  FireData(this.amount,this.account);

  FireData.fromMap(Map<String, dynamic> map)
      : assert(map['account'] != null),
        assert(map['money'] != null),
        account = map['account'],
        amount = map['money'];

  @override
  String toString() => "Record<$amount:$account>";
}