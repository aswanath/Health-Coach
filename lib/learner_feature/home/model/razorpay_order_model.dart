// // To parse this JSON data, do
// //
// //     final razorPayOrder = razorPayOrderFromJson(jsonString);
//
// import 'dart:convert';
//
// RazorPayOrder razorPayOrderFromJson(String str) => RazorPayOrder.fromJson(json.decode(str));
//
// String razorPayOrderToJson(RazorPayOrder data) => json.encode(data.toJson());
//
// class RazorPayOrder {
//   RazorPayOrder({
//     this.id,
//     this.entity,
//     this.amount,
//     this.amountPaid,
//     this.amountDue,
//     this.currency,
//     this.receipt,
//     this.status,
//     this.attempts,
//     this.notes,
//     this.createdAt,
//   });
//
//   String id;
//   String entity;
//   int amount;
//   int amountPaid;
//   int amountDue;
//   String currency;
//   String receipt;
//   String status;
//   int attempts;
//   List<dynamic> notes;
//   int createdAt;
//
//   factory RazorPayOrder.fromJson(Map<String, dynamic> json) => RazorPayOrder(
//     id: json["id"],
//     entity: json["entity"],
//     amount: json["amount"],
//     amountPaid: json["amount_paid"],
//     amountDue: json["amount_due"],
//     currency: json["currency"],
//     receipt: json["receipt"],
//     status: json["status"],
//     attempts: json["attempts"],
//     notes: List<dynamic>.from(json["notes"].map((x) => x)),
//     createdAt: json["created_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "entity": entity,
//     "amount": amount,
//     "amount_paid": amountPaid,
//     "amount_due": amountDue,
//     "currency": currency,
//     "receipt": receipt,
//     "status": status,
//     "attempts": attempts,
//     "notes": List<dynamic>.from(notes.map((x) => x)),
//     "created_at": createdAt,
//   };
// }
