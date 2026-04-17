import 'package:ai_setu/core/models/pdf_models.dart';
import 'package:ai_setu/data/model/selas/invoice_model.dart';
import 'package:ai_setu/data/model/selas/sales_order_model.dart';
import 'package:ai_setu/data/model/selas/estimate_model.dart';
import 'package:ai_setu/data/model/selas/delivery_challan_model.dart' as dc;
import 'package:ai_setu/data/model/selas/sales_credit_note_model.dart' as scn;
import 'package:ai_setu/data/model/purchase/purchase_order_model.dart';
import 'package:ai_setu/data/model/purchase/supplier_bill_model.dart' as sb;
import 'package:ai_setu/data/model/purchase/purchase_debit_note_model.dart'
    as pdn;
import 'package:ai_setu/data/model/pos/order_list_model.dart' as pos;
import 'package:ai_setu/data/model/bank_cash/pos_payment_model.dart' as bp;
import 'package:ai_setu/data/model/bank_cash/expense_model.dart' as ex;
import 'package:ai_setu/data/model/bank_cash/bank_transaction_model.dart' as bt;
import 'package:ai_setu/data/model/accounting/cradit_note_model.dart' as acc_cn;
import 'package:ai_setu/data/model/accounting/debit_note_model.dart' as acc_dn;
import 'package:ai_setu/data/model/invetory/stock_verification_model.dart'
    as sv;
import 'package:ai_setu/data/model/invetory/material_consumption_model.dart'
    as mc;
import 'package:ai_setu/data/model/pos/sales_register_model.dart' as reg;
import 'package:ai_setu/data/model/pos/credit_note_model.dart' as pos_cn;
import 'package:ai_setu/data/model/invetory/recipe_model.dart' as rec;
import 'package:ai_setu/data/model/invetory/bill_live_product_model.dart'
    as bom;
import 'package:ai_setu/data/model/bank_cash/salary_model.dart' as sal;
import 'package:intl/intl.dart';

class PdfMappers {
  static DetailPdfData mapInvoice(InvoiceModel invoice) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Invoice #${invoice.invoiceNo}',
      subtitle:
          'Date: ${dateFormat.format(invoice.date ?? DateTime.now())}\nDue Date: ${dateFormat.format(invoice.dueDate ?? DateTime.now())}',
      status: invoice.paymentStatus,
      filename: 'Invoice_${invoice.invoiceNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Invoice Details',
          items: [
            PdfItemData(
              label: 'Customer',
              value:
                  '${invoice.customerId?.firstName} ${invoice.customerId?.lastName}',
            ),
            PdfItemData(
              label: 'Place of Supply',
              value: invoice.placeOfSupply ?? '-',
            ),
            PdfItemData(label: 'Tax Type', value: invoice.taxType ?? '-'),
            PdfItemData(
              label: 'Payment Terms',
              value: invoice.paymentTerms ?? '-',
            ),
          ],
        ),
        PdfSectionData(
          title: 'Line Items',
          table: PdfTableData(
            headers: ['Item', 'Qty', 'Price', 'Tax (%)', 'Total'],
            rows: invoice.items
                .map(
                  (item) => [
                    item.productId?.name ?? '-',
                    '${item.qty} ${item.unit ?? ""}',
                    '₹${item.price}',
                    '${item.taxId?.percentage ?? 0}%',
                    '₹${item.totalAmount}',
                  ],
                )
                .toList(),
          ),
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Gross Amount',
              value: '₹${invoice.transactionSummary?.grossAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Discount',
              value: '₹${invoice.transactionSummary?.discountAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Taxable Amount',
              value: '₹${invoice.transactionSummary?.taxableAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Tax Amount',
              value: '₹${invoice.transactionSummary?.taxAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Net Amount',
              value: '₹${invoice.transactionSummary?.netAmount ?? 0}',
            ),
            PdfItemData(label: 'Paid Amount', value: '₹${invoice.paidAmount}'),
            PdfItemData(label: 'Balance', value: '₹${invoice.balanceAmount}'),
          ],
        ),
        if (invoice.billingAddress != null || invoice.shippingAddress != null)
          PdfSectionData(
            title: 'Address Information',
            items: [
              if (invoice.billingAddress != null)
                PdfItemData(
                  label: 'Billing Address',
                  value:
                      '${invoice.billingAddress!.addressLine1}, ${invoice.billingAddress!.city?.name}',
                ),
              if (invoice.shippingAddress != null)
                PdfItemData(
                  label: 'Shipping Address',
                  value:
                      '${invoice.shippingAddress!.addressLine1}, ${invoice.shippingAddress!.city?.name}',
                ),
            ],
          ),
      ],
    );
  }

  static DetailPdfData mapSalesOrder(SalesOrderModel order) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Sales Order #${order.salesOrderNo}',
      subtitle:
          'Date: ${dateFormat.format(order.date ?? DateTime.now())}\nDue Date: ${dateFormat.format(order.dueDate ?? DateTime.now())}',
      status: order.status,
      filename: 'SalesOrder_${order.salesOrderNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Order Details',
          items: [
            PdfItemData(
              label: 'Customer',
              value:
                  '${order.customerId?.firstName} ${order.customerId?.lastName}',
            ),
            PdfItemData(
              label: 'Place of Supply',
              value: order.placeOfSupply ?? '-',
            ),
            PdfItemData(label: 'Tax Type', value: order.taxType ?? '-'),
            PdfItemData(
              label: 'Payment Terms',
              value: order.paymentTerms ?? '-',
            ),
          ],
        ),
        PdfSectionData(
          title: 'Line Items',
          table: PdfTableData(
            headers: ['Item', 'Qty', 'Price', 'Tax (%)', 'Total'],
            rows: order.items
                .map(
                  (item) => [
                    item.productId?.name ?? '-',
                    '${item.qty}',
                    '₹${item.price}',
                    '${item.taxId?.percentage ?? 0}%',
                    '₹${item.totalAmount}',
                  ],
                )
                .toList(),
          ),
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Gross Amount',
              value: '₹${order.transactionSummary?.grossAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Taxable Amount',
              value: '₹${order.transactionSummary?.taxableAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Tax Amount',
              value: '₹${order.transactionSummary?.taxAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Net Amount',
              value: '₹${order.transactionSummary?.netAmount ?? 0}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapEstimate(EstimateModel estimate) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Estimate #${estimate.estimateNo}',
      subtitle:
          'Date: ${dateFormat.format(estimate.date ?? DateTime.now())}\nDue Date: ${dateFormat.format(estimate.dueDate ?? DateTime.now())}',
      status: estimate.status,
      filename: 'Estimate_${estimate.estimateNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Estimate Details',
          items: [
            PdfItemData(
              label: 'Customer',
              value:
                  '${estimate.customerId?.firstName} ${estimate.customerId?.lastName}',
            ),
            PdfItemData(
              label: 'Place of Supply',
              value: estimate.placeOfSupply ?? '-',
            ),
            PdfItemData(label: 'Tax Type', value: estimate.taxType ?? '-'),
          ],
        ),
        PdfSectionData(
          title: 'Line Items',
          table: PdfTableData(
            headers: ['Item', 'Qty', 'Price', 'Tax (%)', 'Total'],
            rows: estimate.items
                .map(
                  (item) => [
                    item.productId?.name ?? '-',
                    '${item.qty}',
                    '₹${item.price}',
                    '${item.taxId?.percentage ?? 0}%',
                    '₹${item.totalAmount}',
                  ],
                )
                .toList(),
          ),
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Gross Amount',
              value: '₹${estimate.transactionSummary?.grossAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Net Amount',
              value: '₹${estimate.transactionSummary?.netAmount ?? 0}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapPurchaseOrder(PurchaseOrderModel order) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Purchase Order #${order.orderNo}',
      subtitle:
          'Date: ${dateFormat.format(order.orderDate)}\nShipping Date: ${dateFormat.format(order.shippingDate)}',
      status: order.status,
      filename: 'PurchaseOrder_${order.orderNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Order Details',
          items: [
            PdfItemData(
              label: 'Supplier',
              value:
                  '${order.supplierId.firstName} ${order.supplierId.lastName}',
            ),
            PdfItemData(label: 'Company', value: order.supplierId.companyName),
            PdfItemData(
              label: 'Place of Supply',
              value: order.placeOfSupply ?? '-',
            ),
            PdfItemData(label: 'Tax Type', value: order.taxType),
          ],
        ),
        PdfSectionData(
          title: 'Line Items',
          table: PdfTableData(
            headers: ['Item', 'Qty', 'Cost', 'Tax (%)', 'Total'],
            rows: order.items
                .map(
                  (item) => [
                    item.productId.name,
                    '${item.qty} ${item.unit ?? ""}',
                    '₹${item.unitCost ?? 0}',
                    '${item.taxId?.percentage ?? 0}%',
                    '₹${item.total}',
                  ],
                )
                .toList(),
          ),
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Gross Amount',
              value: '₹${order.summary.grossAmount}',
            ),
            PdfItemData(
              label: 'Discount',
              value: '₹${order.summary.discountAmount}',
            ),
            PdfItemData(
              label: 'Taxable Amount',
              value: '₹${order.summary.taxableAmount}',
            ),
            PdfItemData(
              label: 'Tax Amount',
              value: '₹${order.summary.taxAmount}',
            ),
            PdfItemData(
              label: 'Net Amount',
              value: '₹${order.summary.netAmount}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapStockVerification(
    sv.StockVerificationModel verification,
  ) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return DetailPdfData(
      title: 'Stock Verification #${verification.stockVerificationNo}',
      subtitle: 'Date: ${dateFormat.format(verification.createdAt)}',
      status: verification.status,
      filename: 'StockVerification_${verification.stockVerificationNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Verification Summary',
          items: [
            PdfItemData(
              label: 'Total Products',
              value: verification.totalProducts.toStringAsFixed(0),
            ),
            PdfItemData(
              label: 'Total Physical Qty',
              value: verification.totalPhysicalQty.toStringAsFixed(2),
            ),
            PdfItemData(
              label: 'Net Difference Amount',
              value:
                  '₹${verification.totalDifferenceAmount.toStringAsFixed(2)}',
            ),
            PdfItemData(
              label: 'Responsible',
              value: verification.createdBy.fullName,
            ),
          ],
        ),
        PdfSectionData(
          title: 'Item Discrepancies',
          table: PdfTableData(
            headers: [
              'Product',
              'System Qty',
              'Physical Qty',
              'Diff Qty',
              'Value Diff',
            ],
            rows: verification.items
                .map(
                  (item) => [
                    item.productId.name,
                    item.systemQty.toString(),
                    item.physicalQty.toString(),
                    '${item.differenceQty > 0 ? '+' : ''}${item.differenceQty}',
                    '₹${item.differenceAmount.toStringAsFixed(2)}',
                  ],
                )
                .toList(),
          ),
        ),
      ],
    );
  }

  static DetailPdfData mapDeliveryChallan(dc.DeliveryChallanModel challan) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Delivery Challan #${challan.deliveryChallanNo}',
      subtitle: 'Date: ${dateFormat.format(challan.date ?? DateTime.now())}',
      status: challan.status,
      filename: 'DeliveryChallan_${challan.deliveryChallanNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Challan Details',
          items: [
            PdfItemData(
              label: 'Customer',
              value:
                  '${challan.customerId?.firstName} ${challan.customerId?.lastName}',
            ),
            PdfItemData(
              label: 'Place of Supply',
              value: challan.placeOfSupply ?? '-',
            ),
          ],
        ),
        PdfSectionData(
          title: 'Line Items',
          table: PdfTableData(
            headers: ['Item', 'Qty', 'Unit', 'Total'],
            rows: challan.items
                .map(
                  (item) => [
                    item.productId?.name ?? '-',
                    '${item.qty}',
                    item.unit ?? '-',
                    '₹${item.totalAmount}',
                  ],
                )
                .toList(),
          ),
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Net Amount',
              value: '₹${challan.transactionSummary?.netAmount ?? 0}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapSupplierBill(sb.SupplierBillModel bill) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Supplier Bill #${bill.supplierBillNo}',
      subtitle: 'Date: ${dateFormat.format(bill.supplierBillDate)}',
      status: bill.paymentStatus,
      filename: 'SupplierBill_${bill.supplierBillNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Bill Details',
          items: [
            PdfItemData(
              label: 'Supplier',
              value: '${bill.supplierId.firstName} ${bill.supplierId.lastName}',
            ),
            PdfItemData(label: 'Reference No', value: bill.referenceBillNo),
            PdfItemData(label: 'Tax Type', value: bill.taxType),
          ],
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Gross Amount',
              value: '₹${bill.summary.grossAmount}',
            ),
            PdfItemData(
              label: 'Tax Amount',
              value: '₹${bill.summary.taxAmount}',
            ),
            PdfItemData(
              label: 'Net Amount',
              value: '₹${bill.summary.netAmount}',
            ),
            PdfItemData(label: 'Paid Amount', value: '₹${bill.paidAmount}'),
            PdfItemData(label: 'Balance', value: '₹${bill.balanceAmount}'),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapSalesCreditNote(scn.SalesCreditNoteModel note) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Sales Credit Note #${note.creditNoteNo}',
      subtitle:
          'Date: ${dateFormat.format(note.creditNoteDate ?? DateTime.now())}',
      status: note.status,
      filename: 'SalesCreditNote_${note.creditNoteNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Note Details',
          items: [
            PdfItemData(
              label: 'Customer',
              value:
                  '${note.customerId?.firstName} ${note.customerId?.lastName}',
            ),
            if (note.reason != null)
              PdfItemData(label: 'Reason', value: note.reason!),
          ],
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Gross Amount',
              value: '₹${note.summary?.grossAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Tax Amount',
              value: '₹${note.summary?.taxAmount ?? 0}',
            ),
            PdfItemData(
              label: 'Net Amount',
              value: '₹${note.summary?.netAmount ?? 0}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapPurchaseDebitNote(pdn.PurchaseDebitNoteModel note) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Purchase Debit Note #${note.debitNoteNo}',
      subtitle: 'Date: ${dateFormat.format(note.debitNoteDate)}',
      status: note.status,
      filename: 'PurchaseDebitNote_${note.debitNoteNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Note Details',
          items: [
            PdfItemData(
              label: 'Supplier',
              value:
                  '${note.supplierId?.firstName} ${note.supplierId?.lastName}',
            ),
            if (note.reason != null)
              PdfItemData(label: 'Reason', value: note.reason!),
          ],
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(
              label: 'Gross Amount',
              value: '₹${note.summary.grossAmount}',
            ),
            PdfItemData(
              label: 'Tax Amount',
              value: '₹${note.summary.taxAmount}',
            ),
            PdfItemData(
              label: 'Net Amount',
              value: '₹${note.summary.netAmount}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapPOSOrder(pos.OrderListModel order) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return DetailPdfData(
      title: 'POS Receipt #${order.orderNo}',
      subtitle: 'Date: ${dateFormat.format(order.createdAt)}',
      status: order.paymentStatus,
      filename: 'POS_Order_${order.orderNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Order Info',
          items: [
            if (order.customerId != null)
              PdfItemData(
                label: 'Customer',
                value:
                    '${order.customerId?.firstName} ${order.customerId?.lastName}',
              ),
            PdfItemData(label: 'Salesman', value: order.salesManId.fullName),
            PdfItemData(label: 'Order Type', value: order.orderType),
          ],
        ),
        PdfSectionData(
          title: 'Items',
          table: PdfTableData(
            headers: ['Product', 'Qty', 'MRP', 'Total'],
            rows: order.items
                .map(
                  (item) => [
                    item.productId.name,
                    item.qty.toString(),
                    '₹${item.mrp}',
                    '₹${item.netAmount.toStringAsFixed(2)}',
                  ],
                )
                .toList(),
          ),
        ),
        PdfSectionData(
          title: 'Summary',
          items: [
            PdfItemData(label: 'Subtotal', value: '₹${order.totalMrp}'),
            PdfItemData(label: 'Discount', value: '₹${order.totalDiscount}'),
            PdfItemData(label: 'Tax', value: '₹${order.totalTaxAmount}'),
            PdfItemData(label: 'Net Amount', value: '₹${order.totalAmount}'),
            PdfItemData(label: 'Paid', value: '₹${order.paidAmount}'),
            PdfItemData(label: 'Due', value: '₹${order.dueAmount}'),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapBankPayment(bp.PosPaymentModel payment) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');
    final isReceipt = payment.voucherType.toLowerCase() == 'receipt';

    return DetailPdfData(
      title: '${isReceipt ? 'Receipt' : 'Payment'} #${payment.paymentNo}',
      subtitle: 'Date: ${dateFormat.format(payment.createdAt)}',
      status: payment.status,
      filename: '${isReceipt ? 'Receipt' : 'Payment'}_${payment.paymentNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Transaction Details',
          items: [
            PdfItemData(
              label: isReceipt ? 'Customer' : 'Supplier',
              value: payment.partyId.companyName?.isNotEmpty == true
                  ? payment.partyId.companyName!
                  : '${payment.partyId.firstName} ${payment.partyId.lastName}',
            ),
            PdfItemData(
              label: 'Payment Mode',
              value: payment.paymentMode.toUpperCase(),
            ),
            PdfItemData(
              label: 'Voucher Type',
              value: payment.voucherType.toUpperCase(),
            ),
            if (payment.posOrderId.orderNo.isNotEmpty)
              PdfItemData(
                label: 'Reference Order',
                value: payment.posOrderId.orderNo,
              ),
          ],
        ),
        PdfSectionData(
          title: 'Financial Breakdown',
          items: [
            PdfItemData(label: 'Base Amount', value: '₹${payment.amount}'),
            if (payment.discountAmount > 0)
              PdfItemData(
                label: 'Discount',
                value: '₹${payment.discountAmount}',
              ),
            if (payment.kasar > 0)
              PdfItemData(label: 'Round Off', value: '₹${payment.kasar}'),
            PdfItemData(
              label: 'Total Amount',
              value: '₹${payment.totalAmount}',
            ),
            PdfItemData(label: 'Paid Amount', value: '₹${payment.paidAmount}'),
            PdfItemData(
              label: 'Balance Amount',
              value: '₹${payment.pendingAmount}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapExpense(ex.ExpenseModel expense) {
    final dateFormat = DateFormat('dd MMM yyyy');

    return DetailPdfData(
      title: 'Expense Receipt',
      subtitle: 'Date: ${dateFormat.format(expense.fromDate)}',
      status: expense.isActive ? 'Active' : 'Inactive',
      filename: 'Expense_${expense.type}.pdf',
      sections: [
        PdfSectionData(
          title: 'Expense Details',
          items: [
            PdfItemData(label: 'Category', value: expense.type.toUpperCase()),
            PdfItemData(label: 'Payee', value: expense.partyId.fullName),
            PdfItemData(
              label: 'Description',
              value: expense.description ?? '-',
            ),
          ],
        ),
        PdfSectionData(
          title: 'Financial Breakdown',
          items: [
            PdfItemData(label: 'Amount', value: '₹${expense.amount}'),
            if (expense.incentive != null && expense.incentive! > 0)
              PdfItemData(label: 'Incentive', value: '₹${expense.incentive}'),
            PdfItemData(
              label: 'Total Amount',
              value:
                  '₹${expense.total ?? (expense.amount + (expense.incentive ?? 0))}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapBankTransaction(bt.BankTransactionModel transaction) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return DetailPdfData(
      title: 'Bank Transaction #${transaction.voucherNo}',
      subtitle: 'Date: ${dateFormat.format(transaction.transactionDate)}',
      status: transaction.transactionType,
      filename: 'BankTransaction_${transaction.voucherNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Transaction Details',
          items: [
            PdfItemData(label: 'Type', value: transaction.transactionType),
            PdfItemData(
              label: 'From Account',
              value: transaction.fromAccount.name,
            ),
            PdfItemData(
              label: 'To Account',
              value: transaction.toAccount?.name ?? '-',
            ),
            PdfItemData(label: 'Amount', value: '₹${transaction.amount}'),
            PdfItemData(label: 'Description', value: transaction.description),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapAccountingCreditNote(acc_cn.CreditNoteModel note) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return DetailPdfData(
      title: 'Credit Note #${note.voucherNumber}',
      subtitle: 'Date: ${DateFormat('dd MMM yyyy').format(note.date)}',
      status: note.isActive ? 'Active' : 'Inactive',
      filename: 'Acc_CreditNote_${note.voucherNumber}.pdf',
      sections: [
        PdfSectionData(
          title: 'Note Details',
          items: [
            PdfItemData(label: 'Person Name', value: note.personName ?? '-'),
            PdfItemData(
              label: 'Phone',
              value: '+${note.phoneNo.countryCode} ${note.phoneNo.phoneNo}',
            ),
            PdfItemData(label: 'Account', value: note.bankAccountId.name),
            PdfItemData(label: 'Amount', value: '₹${note.amount}'),
            PdfItemData(label: 'Type', value: note.type),
            PdfItemData(
              label: 'Created At',
              value: dateFormat.format(note.createdAt),
            ),
          ],
        ),
        if (note.description != null && note.description!.isNotEmpty)
          PdfSectionData(
            title: 'Description',
            items: [PdfItemData(label: 'Note', value: note.description!)],
          ),
      ],
    );
  }

  static DetailPdfData mapAccountingDebitNote(acc_dn.DebitNoteModel note) {
    final dateFormat = DateFormat('dd MMM yyyy, hh:mm a');

    return DetailPdfData(
      title: 'Debit Note #${note.voucherNumber}',
      subtitle: 'Date: ${DateFormat('dd MMM yyyy').format(note.date)}',
      status: note.isActive ? 'Active' : 'Inactive',
      filename: 'Acc_DebitNote_${note.voucherNumber}.pdf',
      sections: [
        PdfSectionData(
          title: 'Note Details',
          items: [
            PdfItemData(label: 'Person Name', value: note.personName),
            PdfItemData(
              label: 'Phone',
              value: '+${note.phoneNo.countryCode} ${note.phoneNo.phoneNo}',
            ),
            PdfItemData(label: 'Account', value: note.bankAccountId.name),
            PdfItemData(label: 'Amount', value: '₹${note.amount}'),
            PdfItemData(label: 'Type', value: note.type),
            PdfItemData(
              label: 'Created At',
              value: dateFormat.format(note.createdAt),
            ),
          ],
        ),
        if (note.description.isNotEmpty)
          PdfSectionData(
            title: 'Description',
            items: [PdfItemData(label: 'Note', value: note.description)],
          ),
      ],
    );
  }

  static DetailPdfData mapMaterialConsumption(
    mc.MaterialConsumptionModel consumption,
  ) {
    return DetailPdfData(
      title: 'Material Consumption #${consumption.number}',
      subtitle: 'Date: ${DateFormat('dd MMM yyyy').format(consumption.date)}',
      status: consumption.isActive ? 'Active' : 'Inactive',
      filename: 'MaterialConsumption_${consumption.number}.pdf',
      sections: [
        PdfSectionData(
          title: 'Overview',
          items: [
            PdfItemData(label: 'Voucher No', value: consumption.number),
            PdfItemData(
              label: 'Type',
              value: consumption.consumptionTypeId.name,
            ),
            PdfItemData(
              label: 'Total Qty',
              value: consumption.totalQty.toString(),
            ),
            PdfItemData(
              label: 'Total Amount',
              value: '₹${consumption.totalAmount}',
            ),
            PdfItemData(label: 'Branch', value: consumption.branchId.name),
          ],
        ),
        PdfSectionData(
          title: 'Consumed Items',
          items: consumption.items
              .map(
                (item) => PdfItemData(
                  label: item.productId.name,
                  value:
                      'Qty: ${item.qty} | Price: ₹${item.price} | Total: ₹${item.totalPrice}',
                ),
              )
              .toList(),
        ),
        if (consumption.remark != null && consumption.remark!.isNotEmpty)
          PdfSectionData(
            title: 'Remarks',
            items: [PdfItemData(label: 'Comment', value: consumption.remark!)],
          ),
      ],
    );
  }

  static DetailPdfData mapSalesRegister(reg.SalesRegisterModel model) {
    return DetailPdfData(
      title: 'Sales Register Summary',
      subtitle: 'Period: ${DateFormat('dd MMM yyyy').format(model.createdAt)}',
      status: model.status,
      filename: 'SalesRegister_${model.registerNo ?? model.id}.pdf',
      sections: [
        PdfSectionData(
          title: 'Register Overview',
          items: [
            PdfItemData(label: 'Register No', value: model.registerNo ?? 'N/A'),
            PdfItemData(label: 'Total Sales', value: '₹${model.totalSales}'),
            PdfItemData(label: 'Total Tax', value: '₹${model.taxAmount ?? 0}'),
            PdfItemData(label: 'Opening Cash', value: '₹${model.openingCash}'),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapRecipe(rec.RecipeModel recipe) {
    return DetailPdfData(
      title: 'Recipe: ${recipe.name}',
      subtitle: 'Number: ${recipe.number}',
      status: recipe.isActive ? 'Active' : 'Inactive',
      filename: 'Recipe_${recipe.number}.pdf',
      sections: [
        PdfSectionData(
          title: 'Details',
          items: [
            PdfItemData(label: 'Name', value: recipe.name),
            PdfItemData(label: 'Type', value: recipe.type),
            PdfItemData(
              label: 'Final Product',
              value: recipe.finalProducts.productId?.name ?? 'N/A',
            ),
            PdfItemData(
              label: 'Yield Qty',
              value: '${recipe.finalProducts.qtyGenerate}',
            ),
          ],
        ),
        PdfSectionData(
          title: 'Raw Materials',
          table: PdfTableData(
            headers: ['Item', 'Quantity'],
            rows: recipe.rawProducts
                .map((rp) => [rp.productId?.name ?? 'Unknown', '${rp.useQty}'])
                .toList(),
          ),
        ),
      ],
    );
  }

  static DetailPdfData mapBOM(bom.BillOfLiveProductModel bomData) {
    return DetailPdfData(
      title: 'BOM: ${bomData.number}',
      subtitle: 'Date: ${DateFormat('dd MMM yyyy').format(bomData.date)}',
      status: bomData.isActive ? 'Active' : 'Inactive',
      filename: 'BOM_${bomData.number}.pdf',
      sections: [
        PdfSectionData(
          title: 'BOM Header',
          items: [PdfItemData(label: 'Voucher No', value: bomData.number)],
        ),
        ...bomData.productDetails.map(
          (product) => PdfSectionData(
            title: 'Manufactured: ${product.productId.name}',
            items: [PdfItemData(label: 'Yield Qty', value: '${product.qty}')],
            table: PdfTableData(
              headers: ['Component', 'Qty Used'],
              rows: product.ingredients
                  .map((ing) => [ing.productId.name, ing.useQty.toString()])
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  static DetailPdfData mapPOSCreditNote(pos_cn.CreditNoteModel note) {
    return DetailPdfData(
      title: 'Credit Note #${note.creditNoteNo}',
      subtitle: 'Date: ${DateFormat('dd MMM yyyy').format(note.createdAt)}',
      status: note.status,
      filename: 'POS_CreditNote_${note.creditNoteNo}.pdf',
      sections: [
        PdfSectionData(
          title: 'Details',
          items: [
            PdfItemData(
              label: 'Original Order',
              value: note.returnPosOrderId.returnOrderNo,
            ),
            PdfItemData(label: 'Total Amount', value: '₹${note.totalAmount}'),
            PdfItemData(
              label: 'Credits Remaining',
              value: '₹${note.creditsRemaining}',
            ),
          ],
        ),
      ],
    );
  }

  static DetailPdfData mapSalary(sal.SalaryModel salary) {
    final dateFormat = DateFormat('dd MMM yyyy');
    return DetailPdfData(
      title: 'Payslip: ${salary.partyId.fullName}',
      subtitle:
          'Period: ${dateFormat.format(salary.fromDate)} - ${dateFormat.format(salary.toDate)}',
      status: salary.isActive ? 'Active' : 'Inactive',
      filename: 'Payslip_${salary.partyId.fullName}.pdf',
      sections: [
        PdfSectionData(
          title: 'Employee Details',
          items: [
            PdfItemData(label: 'Name', value: salary.partyId.fullName),
            if (salary.description != null && salary.description!.isNotEmpty)
              PdfItemData(label: 'Description', value: salary.description!),
          ],
        ),
        PdfSectionData(
          title: 'Earnings & Deductions',
          items: [
            PdfItemData(label: 'Basic Salary', value: '₹${salary.amount}'),
            PdfItemData(label: 'Incentive', value: '₹${salary.incentive}'),
            PdfItemData(label: 'Net Paid', value: '₹${salary.total}'),
          ],
        ),
      ],
    );
  }
}
