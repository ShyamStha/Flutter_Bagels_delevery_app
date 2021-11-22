class Amount{
    final double quantity;
    final double amount;

  Amount({this.quantity,this.amount});
 String totAmount()
  {
      double val=quantity*amount.toDouble();
      return val.toStringAsFixed(0);
  }
}