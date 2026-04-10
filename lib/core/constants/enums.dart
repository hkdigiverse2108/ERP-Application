enum ProductType {
  finished,
  raw_material,
  semi_finished,
  service,
  non_inventory,
}

enum StockVerificationStatus { pending, approved, rejected }

enum UserType { admin, superAdmin }

enum VoucherType { sales, purchase, expense }

enum OrderStatus {
  in_progress,
  completed,
  cancelled,
  exceed,
  delivered,
  partial_delivered,
}

enum CreditNoteStatus { available, used }

enum SalesRegisterStatus { open, closed }

enum ContactType { customer, supplier, transporter }

enum BillStatus { paid, unpaid }
