import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/constants/sizes.dart';
import 'package:ai_setu/core/services/storage_service.dart';
import 'package:ai_setu/core/services/theme_service.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:ai_setu/core/services/pdf_service.dart';
import 'package:ai_setu/core/utils/pdf_mappers.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/invetory/product_model.dart';
import 'package:ai_setu/data/model/location/location_model.dart';
import 'package:ai_setu/data/model/user_model.dart';
import 'package:ai_setu/data/model/pos/order_list_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/inventory/location_repository.dart';
import 'package:ai_setu/core/helper/text_helper.dart';
import 'package:ai_setu/data/repositories/inventory/product_repository.dart';
import 'package:ai_setu/data/repositories/user/user_repository.dart';
import 'package:ai_setu/data/repositories/pos/credit_note_repository.dart';
import 'package:ai_setu/data/repositories/crm/coupon_repository.dart';
import 'package:ai_setu/data/repositories/crm/discount_repository.dart';
import 'package:ai_setu/data/repositories/pos/pos_order_repository.dart';
import 'package:ai_setu/data/repositories/pos/cash_register_repository.dart';
import 'package:ai_setu/data/model/crm/coupon_model.dart';
import 'package:ai_setu/data/model/crm/discount_model.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/redeem_credit_bottom_sheet.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/apply_coupon_bottom_sheet.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/redeem_loyalty_bottom_sheet.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/card_payment_bottom_sheet.dart';
import 'package:ai_setu/data/repositories/crm/loyalty_repository.dart';
import 'package:ai_setu/data/model/crm/loyalty_pos_model.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/pay_later_bottom_sheet.dart';
import 'package:ai_setu/data/repositories/bank_cash/bank_repository.dart';
import 'package:ai_setu/data/model/common/id_name_model.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/quick_add_customer_sheet.dart';
import 'package:ai_setu/modules/pos/pos_new/widgets/image_source_bottom_sheet.dart';
import 'package:ai_setu/app/app_routes.dart';
import 'package:ai_setu/shared/widgets/text_fields/edit_text_field.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'dart:ui';
import 'dart:math' as math;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class RedemptionItem {
  final String id;
  final String code;
  final String type;
  final double amount;
  final String customerId;

  RedemptionItem({
    required this.id,
    required this.code,
    required this.type,
    required this.amount,
    required this.customerId,
  });

  RedemptionItem copyWith({
    String? id,
    String? code,
    String? type,
    double? amount,
    String? customerId,
  }) {
    return RedemptionItem(
      id: id ?? this.id,
      code: code ?? this.code,
      type: type ?? this.type,
      amount: amount ?? this.amount,
      customerId: customerId ?? this.customerId,
    );
  }

  Map<String, dynamic> toRedeemPayload() {
    return {"code": code, "type": type, "customerId": customerId};
  }
}

class PosNewController extends GetxController {
  static PosNewController get instance => Get.find();

  // Image Selection
  final ImagePicker _picker = ImagePicker();
  final Rxn<File> selectedImage = Rxn<File>();

  // Order Type: Walk In = 0, Delivery = 1
  final orderType = 0.obs;

  // Selected Values
  final selectedProduct = Rxn<ProductDropdownModel>();
  final selectedSalesman = Rxn<UserDropDownModel>();
  final selectedCustomer = Rxn<ContactDropdownModel>();

  // Dropdown Lists
  final products = <ProductDropdownModel>[].obs;
  final salesmen = <UserDropDownModel>[].obs;
  final customers = <ContactDropdownModel>[].obs;
  final countries = <LocationDropdown>[].obs;
  final states = <LocationDropdown>[].obs;
  final cities = <LocationDropdown>[].obs;

  // Repositories
  final _productRepo = ProductRepository();
  final _userRepo = UserRepository();
  final _contactRepo = ContactRepository();
  final _locationRepo = LocationRepository();
  final _creditNoteRepo = CreditNoteRepository();
  final _couponRepo = CouponRepository();
  final _discountRepo = DiscountRepository();
  final _orderRepo = PosOrderRepository();
  final _bankRepo = BankRepository();
  final _loyaltyRepo = LoyaltyRepository();
  final _registerRepo = CashRegisterRepository();

  // State
  final isLoading = false.obs;
  final isRegisterOpen = true.obs;
  final registerDetails = Rxn<Map<String, dynamic>>();
  final isRedeemLoading = false.obs;
  final isCustomerPosLoading = false.obs;
  final customerPosDetails = Rxn<Map<String, dynamic>>();

  // Metrics
  final totalQuantity = 0.0.obs;
  final totalMRP = 0.0.obs;
  final totalDiscount = 0.0.obs;
  final productDiscountTotal = 0.0.obs;
  final flatDiscount = 0.0.obs;
  final taxAmount = 0.0.obs;
  final addCharges = 0.0.obs;
  final totalAmount = 0.0.obs;
  final isSavingCustomer = false.obs;

  // Edit Mode state
  final isEditMode = false.obs;
  final editingOrderId = RxnString();

  // Inputs
  final remarkController = TextEditingController();
  final flatDiscountController = TextEditingController(text: '0');
  final roundOffController = TextEditingController(text: '0.00');

  // Quick Add Customer Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final countryCodeController = TextEditingController(text: "+91");
  final addressLine1Controller = TextEditingController();
  final selectedCountry = Rxn<LocationDropdown>();
  final selectedState = Rxn<LocationDropdown>();
  final selectedCity = Rxn<LocationDropdown>();

  // Cart List
  final cartItems = <Map<String, dynamic>>[].obs;

  // Redeemables
  final creditNotes = <dynamic>[].obs;
  final advancePayments = <dynamic>[].obs;
  final appliedCoupon = Rxn<CouponModel>();
  final appliedDiscount = Rxn<DiscountModel>();
  final coupons = <CouponModel>[].obs;
  final discounts = <DiscountModel>[].obs;
  final isCouponLoading = false.obs;
  final isDiscountLoading = false.obs;
  final appliedRedemption = Rxn<RedemptionItem>();
  final appliedLoyalty = Rxn<LoyaltyRedeemResponse>();
  final loyalties = <LoyaltyDropdownModel>[].obs;
  final promoDiscountAmount = 0.0.obs;
  final isLoyaltyLoading = false.obs;

  // Payment Accounts
  final bankAccounts = <IdNameModel>[].obs;
  final isBankLoading = false.obs;

  // Track TextEditingControllers for each cart item's discount
  // This prevents the "jitter" where typing causes the cursor to reset or values to format unexpectedly
  final Map<String, TextEditingController> _discountControllers = {};

  // Internal flag to prevent side effects (like clearing promos) during order reconstruction
  bool _isResuming = false;

  TextEditingController getDiscountController(
    int index,
    String productId,
    double initialDiscount,
  ) {
    final key = "${productId}_$index";
    if (!_discountControllers.containsKey(key)) {
      _discountControllers[key] = TextEditingController(
        text: initialDiscount.toString(),
      );
    }
    return _discountControllers[key]!;
  }

  @override
  void onInit() {
    super.onInit();
    fetchInitialData().then((_) => _checkArguments());

    // Listen to flat discount and round off changes
    flatDiscountController.addListener(() {
      final val = double.tryParse(flatDiscountController.text) ?? 0.0;
      if (val != flatDiscount.value) {
        flatDiscount.value = val;
        _clearPromoSilent(); // Clear redemptions on amount change
        calculateTotals();
      }
    });

    roundOffController.addListener(() {
      _clearPromoSilent();
      calculateTotals();
    });

    // Listen to customer changes to fetch POS details
    ever(selectedCustomer, (customer) {
      if (customer != null) {
        fetchCustomerPosDetails(customer.id);
      } else {
        customerPosDetails.value = null;
      }
    });
  }

  Future<void> fetchInitialData() async {
    try {
      isLoading.value = true;
      final results = await Future.wait([
        _productRepo.getProductDropdown(),
        _userRepo.getUserDropDown(typeFilter: 'salesman'),
        _contactRepo.getContactDropdown(typeFilter: 'customer'),
        fetchBankAccounts(),
        checkRegisterStatus(),
      ]);

      products.value = results[0] as List<ProductDropdownModel>;
      salesmen.value = results[1] as List<UserDropDownModel>;
      customers.value = results[2] as List<ContactDropdownModel>;

      // Auto-select current logged-in user as salesman
      final userData = StorageService.instance.read<Map<String, dynamic>>(
        StorageKeys.userData,
      );
      if (userData != null) {
        final currentUserId = userData['_id'];
        final currentSalesman = salesmen.firstWhereOrNull(
          (s) => s.id == currentUserId,
        );
        if (currentSalesman != null) {
          selectedSalesman.value = currentSalesman;
        } else if (userData['fullName'] != null) {
          // If not in salesman list, create a dropdown model for the current user
          selectedSalesman.value = UserDropDownModel(
            id: currentUserId,
            fullName: userData['fullName'],
            userType: userData['userType'] ?? 'staff',
          );
        }
      }
    } catch (e) {
      debugPrint("Error fetching POS data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkRegisterStatus() async {
    try {
      final res = await _registerRepo.getRegisterDetails();
      if (res.status == 200 &&
          res.data != null &&
          res.data['status'] == 'open') {
        registerDetails.value = res.data;
        isRegisterOpen.value = true;
      } else {
        isRegisterOpen.value = false;
        _showOpenRegisterDialog();
      }
    } catch (e) {
      isRegisterOpen.value = false;
      _showOpenRegisterDialog();
    }
  }

  void _showOpenRegisterDialog() {
    final openingCashController = TextEditingController(text: "0");
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    Get.dialog(
      PopScope(
        canPop: false,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Material(
            color: Colors.transparent,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(Get.context!).viewInsets.bottom + 24,
              ),
              child: Center(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 80,
                  ),
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 360),
                  decoration: BoxDecoration(
                    color: Get.context!.appColors.surface,
                    borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Gap(28),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Get.context!.appColors.primary.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            PhosphorIconsLight.lockOpen,
                            color: Get.context!.appColors.primary,
                            size: 32,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          "Register Closed",
                          style: TextHelper.h4Style(
                            Get.context!,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            "No active cash register is currently open. Please open a new register to perform sales.",
                            textAlign: TextAlign.center,
                            style: TextHelper.bodySmall.copyWith(
                              color: Get.context!.appColors.textSecondary,
                            ),
                          ),
                        ),
                        const Gap(24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: EditTextField(
                            label: "Opening Cash (Amount)",
                            controller: openingCashController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            prefixIcon: Icon(
                              PhosphorIconsLight.currencyInr,
                              size: 20,
                              color: Get.context!.appColors.textSecondary,
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) {
                                return "Opening cash is required";
                              }
                              if (double.tryParse(val) == null) {
                                return "Please enter a valid amount";
                              }
                              return null;
                            },
                          ),
                        ),
                        const Gap(28),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 28),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {
                                    Get.back(); // Close dialog
                                    Get.offAllNamed(
                                      Routes.dashboard,
                                    ); // Redirect to dashboard
                                  },
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Get.context!.appColors.border,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.borderRadiusM,
                                      ),
                                    ),
                                  ),
                                  child: const Text("Cancel"),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () async {
                                    if (formKey.currentState?.validate() ??
                                        false) {
                                      final amt =
                                          double.tryParse(
                                            openingCashController.text,
                                          ) ??
                                          0.0;
                                      Get.back(); // Close dialog
                                      await _openRegisterWithAmount(amt);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Get.context!.appColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.borderRadiusM,
                                      ),
                                    ),
                                  ),
                                  child: const Text("Open Register"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.6),
    );
  }

  Future<void> _openRegisterWithAmount(double openingCash) async {
    try {
      isLoading.value = true;
      final payload = {"openingCash": openingCash};
      final res = await _registerRepo.openRegister(payload);
      if (res.status == 200 || res.status == 201) {
        AppSnackbar.success(res.message ?? "Register opened successfully");
        isRegisterOpen.value = true;
        await checkRegisterStatus();
      } else {
        AppSnackbar.error(res.message ?? "Failed to open register");
        _showOpenRegisterDialog();
      }
    } catch (e) {
      AppSnackbar.error("Error opening register: $e");
      _showOpenRegisterDialog();
    } finally {
      isLoading.value = false;
    }
  }

  Future<Map<String, dynamic>?> getLatestRegisterDetails() async {
    try {
      isLoading.value = true;
      final res = await _registerRepo.getRegisterDetails();
      if (res.status == 200 && res.data != null) {
        registerDetails.value = res.data;
        return res.data;
      } else {
        AppSnackbar.error(res.message ?? "Failed to load register details");
      }
    } catch (e) {
      debugPrint("Error fetching latest register details: $e");
      AppSnackbar.error("Failed to load register details: $e");
    } finally {
      isLoading.value = false;
    }
    return null;
  }

  Future<bool> closeActiveRegister(Map<String, dynamic> payload) async {
    try {
      isLoading.value = true;
      final res = await _registerRepo.closeRegister(payload);
      if (res.status == 200) {
        isRegisterOpen.value = false;
        registerDetails.value = null;
        return true;
      } else {
        AppSnackbar.error(res.message ?? "Failed to close register");
      }
    } catch (e) {
      debugPrint("Error closing register: $e");
      AppSnackbar.error("Failed to close register: $e");
    } finally {
      isLoading.value = false;
    }
    return false;
  }

  @override
  void onClose() {
    remarkController.dispose();
    flatDiscountController.dispose();
    roundOffController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    addressLine1Controller.dispose();
    for (var controller in _discountControllers.values) {
      controller.dispose();
    }
    super.onClose();
  }

  Future<void> fetchBankAccounts() async {
    try {
      isBankLoading.value = true;
      final data = await _bankRepo.getBankDropdown();
      bankAccounts.assignAll(data);
    } catch (e) {
      debugPrint("Error fetching banks: $e");
    } finally {
      isBankLoading.value = false;
    }
  }

  Future<void> fetchCustomerPosDetails(String customerId) async {
    try {
      isCustomerPosLoading.value = true;
      final res = await _orderRepo.getCustomerPosDetails(customerId);
      if (res.status == 200) {
        customerPosDetails.value = res.data;
      }
    } catch (e) {
      debugPrint("Error fetching customer POS details: $e");
    } finally {
      isCustomerPosLoading.value = false;
    }
  }

  void updateOrderType(int value) {
    orderType.value = value;
  }

  void _clearPromoSilent() {
    if (_isResuming) return;
    if (appliedCoupon.value != null ||
        appliedDiscount.value != null ||
        appliedRedemption.value != null ||
        appliedLoyalty.value != null) {
      appliedCoupon.value = null;
      appliedDiscount.value = null;
      appliedRedemption.value = null;
      appliedLoyalty.value = null;
      promoDiscountAmount.value = 0.0;
    }
  }

  void addItemToCart(ProductDropdownModel product) {
    // Check if item already exists in cart
    final existingIndex = cartItems.indexWhere(
      (item) => item['id'] == product.id,
    );

    if (existingIndex != -1) {
      // Increase quantity
      final item = cartItems[existingIndex];
      item['qty'] = (item['qty'] as double) + 1.0;
      cartItems[existingIndex] = Map<String, dynamic>.from(item);
    } else {
      // Add new item
      cartItems.add({
        'id': product.id,
        'name': product.name,
        'uom': product.uomId?.code ?? "",
        'availableQty': product.qty,
        'qty': 1.0,
        'mrp': product.mrp,
        'discount': product.sellingDiscount,
        'additionalDisc': 0.0,
        'unitCost': product.sellingPrice,
        'taxPercentage': product.salesTaxId?.percentage ?? 0,
        'taxId': product.salesTaxId?.id ?? "",
        'netAmount': product.sellingPrice,
      });
    }

    // Clear selection
    selectedProduct.value = null;

    // Clear promo as cart modified
    _clearPromoSilent();

    // Recalculate metrics
    calculateTotals();
  }

  void removeItemFromCart(Map<String, dynamic> item) {
    // Find index to clean up controller
    final index = cartItems.indexOf(item);
    if (index != -1) {
      final key = "${item['id']}_$index";
      _discountControllers[key]?.dispose();
      _discountControllers.remove(key);
    }
    cartItems.remove(item);
    _clearPromoSilent();
    calculateTotals();
  }

  void clearCart() {
    // Dispose all item-specific controllers
    for (var controller in _discountControllers.values) {
      controller.dispose();
    }
    _discountControllers.clear();

    // Clear the cart list
    cartItems.clear();

    // Reset global inputs
    flatDiscountController.text = "0";
    roundOffController.text = "0.00";
    remarkController.clear();

    // Reset selection
    selectedProduct.value = null;
    selectedCustomer.value = null;
    selectedImage.value = null;
    appliedRedemption.value = null;
    appliedLoyalty.value = null;
    appliedCoupon.value = null;
    appliedDiscount.value = null;
    promoDiscountAmount.value = 0.0;
    customerPosDetails.value = null;

    // Reset Edit Mode
    isEditMode.value = false;
    editingOrderId.value = null;

    // Recalculate (will reset all totals to 0)
    calculateTotals();
  }

  void _checkArguments() {
    if (Get.arguments != null && Get.arguments is OrderListModel) {
      loadOrderForEdit(Get.arguments as OrderListModel);
    }
  }

  void loadOrderForEdit(OrderListModel order) {
    // We can reuse resumeOrder logic by converting model to JSON
    resumeOrder(order.toJson());
  }

  void resumeOrder(Map<String, dynamic> order) {
    _isResuming = true;
    // 1. Clear existing state
    clearCart();

    // 1.1 Set edit mode if ID is present
    if (order['_id'] != null) {
      isEditMode.value = true;
      editingOrderId.value = order['_id'].toString();
    }

    // 2. Set Customer
    final customerData = order['customerId'] as Map<String, dynamic>?;
    if (customerData != null) {
      final customer = ContactDropdownModel(
        id: customerData['_id']?.toString() ?? "",
        name:
            "${customerData['firstName'] ?? ''} ${customerData['lastName'] ?? ''}"
                .trim(),
        firstName: customerData['firstName']?.toString() ?? "",
        lastName: customerData['lastName']?.toString() ?? "",
        contactType: ContactType.customer,
        address: const [],
        email: customerData['email']?.toString(),
        phoneNo: ContactPhone(
          phoneNo: customerData['phoneNo']?['phoneNo'],
          countryCode:
              customerData['phoneNo']?['countryCode']?.toString() ?? "91",
        ),
      );

      // Ensure the customer exists in the dropdown list to avoid selection issues
      if (!customers.any((c) => c.id == customer.id)) {
        customers.add(customer);
      }
      selectedCustomer.value = customer;
    }

    // 3. Set Salesman
    final salesManData = order['salesManId'] as Map<String, dynamic>?;
    if (salesManData != null) {
      final salesman = salesmen.firstWhereOrNull(
        (s) => s.id == salesManData['_id'],
      );
      if (salesman != null) {
        selectedSalesman.value = salesman;
      }
    }

    // 4. Set Order Type
    final typeStr = order['orderType']?.toString().toLowerCase() ?? 'walk_in';
    orderType.value = typeStr == 'delivery' ? 1 : 0;

    // 4. Set Remark
    remarkController.text = order['remarks']?.toString() ?? "";

    // 5. Set Items
    final itemsData = order['items'] as List<dynamic>?;
    _discountControllers.clear();
    if (itemsData != null) {
      for (var item in itemsData) {
        final productData = item['productId'] as Map<String, dynamic>?;
        if (productData != null) {
          final prodId = productData['_id']?.toString() ?? "";
          // Try to find current available qty from master list
          final masterProduct = products.firstWhereOrNull(
            (p) => p.id == prodId,
          );

          final cartItem = {
            'id': prodId,
            'name':
                productData['name']?.toString() ?? masterProduct?.name ?? "",
            'uom': productData['uomId'] is Map
                ? (productData['uomId']['code'] ?? "")
                : (masterProduct?.uomId?.code ?? ""),
            'availableQty':
                masterProduct?.qty ??
                (productData['qty'] as num? ?? 0).toDouble(),
            'qty': (item['qty'] as num? ?? 1).toDouble(),
            'mrp': (item['mrp'] as num? ?? 0).toDouble(),
            'discount': (item['discountAmount'] as num? ?? 0).toDouble(),
            'additionalDisc': (item['additionalDiscountAmount'] as num? ?? 0)
                .toDouble(),
            'unitCost': (item['unitCost'] as num? ?? 0).toDouble(),
            'taxPercentage': productData['salesTaxId'] is Map
                ? (productData['salesTaxId']['percentage'] as num? ?? 0)
                      .toDouble()
                : (masterProduct?.salesTaxId?.percentage ?? 0.0),
            'taxId': productData['salesTaxId'] is Map
                ? (productData['salesTaxId']['_id']?.toString() ?? "")
                : (masterProduct?.salesTaxId?.id ?? ""),
            'isTaxIncluding':
                productData['isSalesTaxIncluding'] as bool? ??
                false, // Order items from list have this field
            'netAmount': (item['netAmount'] as num? ?? 0).toDouble(),
          };

          cartItems.add(cartItem);

          // Initialize discount controller for this item
          getDiscountController(
            cartItems.length - 1,
            prodId,
            (item['discountAmount'] as num? ?? 0).toDouble(),
          );
        }
      }
    }

    // 6. Set Global Discounts/Charges
    flatDiscountController.text = (order['flatDiscountAmount'] as num? ?? 0)
        .toString();
    roundOffController.text = (order['roundOff'] as num? ?? 0).toStringAsFixed(
      2,
    );

    // 7. Coupons, Loyalty & Redemptions
    appliedCoupon.value = null;
    appliedDiscount.value = null;
    appliedLoyalty.value = null;
    appliedRedemption.value = null;
    promoDiscountAmount.value = 0.0;

    if ((order['couponDiscount'] as num? ?? 0) > 0) {
      promoDiscountAmount.value = (order['couponDiscount'] as num? ?? 0)
          .toDouble();
      appliedCoupon.value = CouponModel(
        id: order['couponId']?.toString() ?? "",
        name: "Applied Coupon",
        // Name might not be in the order list, but we show the amount
        isActive: true,
        isDeleted: false,
        status: "active",
        redemptionType: "flat",
        redeemValue: (order['couponDiscount'] as num? ?? 0).toInt(),
        singleTimeUse: false,
        usedCount: 0,
        createdAt: DateTime.now(),
        customerIds: [],
      );
    }

    if (order['discountId'] != null &&
        (order['discountAmount'] as num? ?? 0) > 0) {
      promoDiscountAmount.value = (order['discountAmount'] as num? ?? 0)
          .toDouble();
      appliedDiscount.value = DiscountModel(
        id: order['discountId'].toString(),
        title: "Order Discount",
        discountCode: "",
        isActive: true,
        isDeleted: false,
        autoApply: false,
        excludeAlreadyDiscounted: false,
        applyToEntireSelection: true,
        usageLimitPerCustomer: false,
        hasEndDate: false,
        discountApplicable: "entire_order",
        discountMode: order['discountMode']?.toString() ?? "normal",
        // discountCode: order['discountCode']?.toString() ?? "",
        discountType: "flat",
        discountValue: (order['discountAmount'] as num? ?? 0).toDouble(),
        minimumRequirement: "none",
        status: "active",
        usedCount: 0,
        orders: 0,
        revenue: 0,
        startDateTime: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        rangeWiseRules: [],
        categoryIds: [],
        subcategoryIds: [],
        brandIds: [],
        productIds: [],
        excludedProductIds: [],
        branchIds: [],
      );
    }

    if (order['loyaltyId'] != null &&
        (order['loyaltyDiscount'] as num? ?? 0) > 0) {
      appliedLoyalty.value = LoyaltyRedeemResponse(
        loyaltyId: order['loyaltyId'].toString(),
        name: "Loyalty Discount",
        type: "flat",
        discountValue: (order['loyaltyDiscount'] as num? ?? 0).toDouble(),
      );
    }

    if (order['redeemCreditId'] != null &&
        (order['redeemCreditAmount'] as num? ?? 0) > 0) {
      appliedRedemption.value = RedemptionItem(
        id: order['redeemCreditId'].toString(),
        code: "",
        type: order['redeemCreditType']?.toString() ?? "credit_note",
        amount: (order['redeemCreditAmount'] as num? ?? 0).toDouble(),
        customerId: customerData?['_id']?.toString() ?? "",
      );
    }
    // 8. Recalculate all totals
    calculateTotals();

    // 9. Re-validate all promos asynchronously
    revalidateResumedPromos();

    _isResuming = false;
    AppSnackbar.success("Order ${order['orderNo']} resumed successfully");
  }

  Future<void> revalidateResumedPromos() async {
    // 1. Re-validate Coupon
    if (appliedCoupon.value != null) {
      final coupon = appliedCoupon.value!;
      appliedCoupon.value = null;
      await applyCoupon(coupon);
      if (appliedCoupon.value == null) {
        AppSnackbar.warning(
          "Previously applied coupon is no longer valid for this order and has been removed.",
        );
      }
    }

    // 2. Re-validate Discount
    if (appliedDiscount.value != null) {
      final discount = appliedDiscount.value!;
      appliedDiscount.value = null;
      await applyDiscount(discount);
      if (appliedDiscount.value == null) {
        AppSnackbar.warning(
          "Previously applied discount is no longer valid for this order and has been removed.",
        );
      }
    }

    // 3. Re-validate Loyalty
    if (appliedLoyalty.value != null) {
      await fetchLoyalties();
      final loyalty = loyalties.firstWhereOrNull(
        (l) => l.id == appliedLoyalty.value!.loyaltyId,
      );
      if (loyalty != null) {
        appliedLoyalty.value = null;
        await redeemLoyalty(loyalty);
      } else {
        appliedLoyalty.value = null;
        calculateTotals();
        AppSnackbar.warning(
          "Previously applied loyalty reward is no longer available.",
        );
      }
    }

    // 4. Re-validate Redemption (Credit Note / Advance)
    if (appliedRedemption.value != null) {
      final redemption = appliedRedemption.value!;
      try {
        final res = await _creditNoteRepo.redeemCreditNote({
          "code": redemption.code,
          "type": redemption.type,
          "customerId": redemption.customerId,
        });

        if (res.status == 200 && res.data != null) {
          final double available =
              double.tryParse(
                res.data['redeemableAmount']?.toString() ?? '0',
              ) ??
              0.0;

          if (available <= 0) {
            appliedRedemption.value = null;
            AppSnackbar.warning(
              "Previously applied credit note/advance is no longer available.",
            );
          } else if (available < redemption.amount) {
            appliedRedemption.value = redemption.copyWith(amount: available);
            AppSnackbar.warning(
              "Redemption amount adjusted to available balance: ₹${available.toStringAsFixed(2)}",
            );
          }
          // If available >= redemption.amount, we keep it as is.
        } else {
          appliedRedemption.value = null;
          AppSnackbar.warning(
            "Previously applied credit note/advance verification failed and has been removed.",
          );
        }
      } catch (e) {
        debugPrint("Error re-validating redemption: $e");
      }
      calculateTotals();
    }
  }

  void updateQuantity(int index, double delta) {
    final item = cartItems[index];
    final step = _getQtyStep(item['uom'] ?? "");
    double newQty = (item['qty'] as double) + (delta * step);
    if (newQty > 0) {
      item['qty'] = newQty;
      cartItems[index] = Map<String, dynamic>.from(item);
      _clearPromoSilent();
      calculateTotals();
    }
  }

  double _getQtyStep(String uom) {
    final decimalUoms = ['KG', 'LTR', 'MT', 'GRAM', 'ML'];
    if (decimalUoms.contains(uom.toUpperCase())) {
      return 0.1;
    }
    return 1.0;
  }

  String formatQty(Map<String, dynamic> item) {
    final uom = item['uom'] ?? "";
    final qty = item['qty'] as double;
    final decimalUoms = ['KG', 'LTR', 'MT', 'GRAM', 'ML'];
    if (decimalUoms.contains(uom.toUpperCase())) {
      return qty.toStringAsFixed(2);
    }
    return qty.toInt().toString();
  }

  void updateItemDiscount(int index, String value) {
    final discount = double.tryParse(value) ?? 0.0;
    final item = cartItems[index];
    item['discount'] = discount;
    _clearPromoSilent();
    calculateTotals();
  }

  void calculateTotals() {
    double qty = 0;
    double mrpTotal = 0;
    double discountTotal = 0;
    double taxTotal = 0;
    double netTotal = 0;

    for (var item in cartItems) {
      final itemQty = item['qty'] as double;
      final itemMrp = (item['mrp'] as num).toDouble();
      final itemDiscount = (item['discount'] as num).toDouble();
      final itemAdditionalDisc = (item['additionalDisc'] as num).toDouble();
      final taxPercent = (item['taxPercentage'] as num).toDouble();
      final isTaxIncluding = item['isTaxIncluding'] as bool? ?? false;

      // Individual item calculations
      double itemDiscAmount = itemDiscount + itemAdditionalDisc;
      double taxableValue;
      double itemTax;

      if (isTaxIncluding) {
        // Reverse calculation for inclusive tax
        // taxable = (mrp - discount) / (1 + taxRate)
        double inclusiveBase = itemMrp - itemDiscAmount;
        taxableValue = inclusiveBase / (1 + (taxPercent / 100));
        itemTax = inclusiveBase - taxableValue;
      } else {
        // Exclusive calculation
        taxableValue = itemMrp - itemDiscAmount;
        itemTax = taxableValue * (taxPercent / 100);
      }

      double sellingPrice = taxableValue + itemTax;
      double netAmount = itemQty * sellingPrice;

      // Update item in cart for UI consistency
      item['unitCost'] = sellingPrice;
      item['netAmount'] = netAmount;

      // Accumulate totals
      qty += itemQty;
      mrpTotal += (itemQty * itemMrp);
      discountTotal += (itemQty * itemDiscAmount);
      taxTotal += (itemQty * itemTax);
      netTotal += netAmount;
    }

    totalQuantity.value = qty;
    totalMRP.value = mrpTotal;
    productDiscountTotal.value = discountTotal;
    taxAmount.value = taxTotal;

    // Final Grand Total calculation
    final finalRoundOff = double.tryParse(roundOffController.text) ?? 0.0;
    double netWithDiscount = (netTotal - flatDiscount.value) + finalRoundOff;

    // Apply Promo Discount (Coupon or Discount)
    double promoDiscountValue = promoDiscountAmount.value;

    // Cap promo discount at net total
    promoDiscountValue = math.min(promoDiscountValue, netWithDiscount);
    netWithDiscount -= promoDiscountValue;

    // Apply Loyalty
    final loyaltyDiscount = appliedLoyalty.value?.discountValue ?? 0.0;
    netWithDiscount = math.max(0.0, netWithDiscount - loyaltyDiscount);

    final redemptionAmount = appliedRedemption.value?.amount ?? 0.0;
    // Cap redemption at the net amount (cannot redeem more than the total)
    double actualRedemption = redemptionAmount;
    if (redemptionAmount > netWithDiscount && netWithDiscount > 0) {
      actualRedemption = netWithDiscount;
    } else if (netWithDiscount <= 0) {
      actualRedemption = 0;
    }

    totalAmount.value = netWithDiscount - actualRedemption;

    // Aggregate all discounts for display
    totalDiscount.value =
        discountTotal +
        flatDiscount.value +
        promoDiscountValue +
        loyaltyDiscount +
        actualRedemption;
  }

  // --- Loyalty Logic ---

  Future<void> fetchLoyalties() async {
    try {
      isLoyaltyLoading.value = true;
      final results = await _loyaltyRepo.getLoyaltyDropdown();
      loyalties.assignAll(results);
    } catch (e) {
      debugPrint("Error fetching loyalties: $e");
    } finally {
      isLoyaltyLoading.value = false;
    }
  }

  void openLoyaltySheet() {
    if (selectedCustomer.value == null) {
      AppSnackbar.warning("Please select a customer first");
      return;
    }

    if (cartItems.isEmpty) {
      AppSnackbar.warning("Please add at least one product to the cart");
      return;
    }

    fetchLoyalties();
    Get.bottomSheet(
      const RedeemLoyaltyBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> redeemLoyalty(LoyaltyDropdownModel loyalty) async {
    try {
      isLoading.value = true;
      final payload = {
        "loyaltyId": loyalty.id,
        "totalAmount": totalMRP.value,
        "customerId": selectedCustomer.value?.id,
      };

      final res = await _loyaltyRepo.redeemLoyalty(payload);

      if (res.status == 200 && res.data != null) {
        appliedLoyalty.value = LoyaltyRedeemResponse.fromJson(res.data);
        // Ensure exclusivity: remove other promos and redemptions
        appliedCoupon.value = null;
        appliedDiscount.value = null;
        appliedRedemption.value = null;
        promoDiscountAmount.value = 0.0;

        calculateTotals();
        Get.back(); // Close bottom sheet
        AppSnackbar.success(res.message ?? "Loyalty redeemed successfully");
      } else {
        AppSnackbar.error(res.message ?? "Failed to redeem loyalty");
      }
    } catch (e) {
      AppSnackbar.error("Error redeeming loyalty: $e");
    } finally {
      isLoading.value = false;
    }
  }

  bool get isCustomerFormDirty {
    return firstNameController.text.isNotEmpty ||
        lastNameController.text.isNotEmpty ||
        phoneController.text.isNotEmpty ||
        countryCodeController.text != "+91" ||
        addressLine1Controller.text.isNotEmpty;
  }

  // --- Quick Add Customer Logic ---

  Future<void> fetchCountries() async {
    try {
      final results = await _locationRepo.countryDropdown();
      countries.assignAll(results);
    } catch (e) {
      debugPrint("Error fetching countries: $e");
    }
  }

  Future<void> fetchStates(String countryId) async {
    try {
      states.clear();
      cities.clear();
      selectedState.value = null;
      selectedCity.value = null;
      final results = await _locationRepo.stateDropdown(countryId);
      states.assignAll(results);
    } catch (e) {
      debugPrint("Error fetching states: $e");
    }
  }

  Future<void> fetchCities(String stateId) async {
    try {
      cities.clear();
      selectedCity.value = null;
      final results = await _locationRepo.cityDropdown(stateId);
      cities.assignAll(results);
    } catch (e) {
      debugPrint("Error fetching cities: $e");
    }
  }

  Future<void> quickAddCustomer() async {
    if (firstNameController.text.isEmpty || phoneController.text.isEmpty) {
      AppSnackbar.warning("First name and Phone number are required");
      return;
    }

    try {
      isSavingCustomer.value = true;
      final payload = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "contactType": "customer",
        "phoneNo": {
          "phoneNo": phoneController.text,
          "countryCode": countryCodeController.text.replaceAll("+", ""),
        },
        "address": [
          {
            "addressLine1": addressLine1Controller.text,
            "country": selectedCountry.value?.id,
            "state": selectedState.value?.id,
            "city": selectedCity.value?.id,
          },
        ],
        "status": "active",
      };

      final bool isEdit = selectedCustomer.value != null;
      if (isEdit) {
        payload["contactId"] = selectedCustomer.value!.id;
      }

      final response = isEdit
          ? await _contactRepo.updateContact(payload)
          : await _contactRepo.addContact(payload);

      if (response.status == 200) {
        AppSnackbar.success(
          isEdit
              ? "Customer updated successfully"
              : "Customer added successfully",
        );
        // Refresh customer list
        final updatedCustomers = await _contactRepo.getContactDropdown(
          typeFilter: 'customer',
        );
        customers.assignAll(updatedCustomers);

        // Auto-select the newly added/updated customer
        final phone = phoneController.text;
        final targetCustomer = customers.firstWhereOrNull(
          (c) => c.phoneNo.phoneNo.toString() == phone,
        );
        if (targetCustomer != null) {
          selectedCustomer.value = targetCustomer;
        }

        clearCustomerForm();
        Get.back(); // Close sheet
      } else {
        AppSnackbar.error(
          response.message ??
              (isEdit ? "Failed to update customer" : "Failed to add customer"),
        );
      }
    } catch (e) {
      AppSnackbar.error("An error occurred: $e");
    } finally {
      isSavingCustomer.value = false;
    }
  }

  void clearCustomerForm() {
    firstNameController.clear();
    lastNameController.clear();
    phoneController.clear();
    countryCodeController.text = "+91";
    addressLine1Controller.clear();
    selectedCountry.value = null;
    selectedState.value = null;
    selectedCity.value = null;
    states.clear();
    cities.clear();
  }

  void openCustomerSheet() {
    final bool isEdit = selectedCustomer.value != null;
    if (isEdit) {
      prepareEditForm();
    } else {
      clearCustomerForm();
    }
    fetchCountries();

    Get.bottomSheet(
      QuickAddCustomerSheet(controller: this),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void prepareEditForm() {
    final customer = selectedCustomer.value;
    if (customer == null) return;

    firstNameController.text = customer.firstName;
    lastNameController.text = customer.lastName;
    phoneController.text = customer.phoneNo.phoneNo?.toString() ?? "";
    countryCodeController.text =
        "+${customer.phoneNo.countryCode.replaceAll("+", "")}";

    if (customer.address.isNotEmpty) {
      final addr = customer.address.first;
      addressLine1Controller.text = addr.addressLine1!;

      if (addr.country != null) {
        selectedCountry.value = LocationDropdown.fromMap(addr.country!.toMap());
        fetchStates(addr.country!.id).then((_) {
          if (addr.state != null) {
            selectedState.value = LocationDropdown.fromMap(addr.state!.toMap());
            fetchCities(addr.state!.id).then((_) {
              if (addr.city != null) {
                selectedCity.value = LocationDropdown.fromMap(
                  addr.city!.toMap(),
                );
              }
            });
          }
        });
      }
    }
  }

  void unselectCustomer() {
    selectedCustomer.value = null;
    _clearPromoSilent();
  }

  Future<void> goToMultiplePay() async {
    if (selectedCustomer.value == null) {
      AppSnackbar.warning("Please select a customer first");
      return;
    }

    if (cartItems.isEmpty) {
      AppSnackbar.warning("Please add at least one product to the cart");
      return;
    }

    final result = await Get.toNamed(
      Routes.posMultiplePay,
      arguments: {
        'totalAmount': totalAmount.value,
        'customer': selectedCustomer.value,
        'redemption': appliedRedemption.value,
      },
    );

    if (result != null && result is Map) {
      final multiPayData = result['payments'];
      final shouldPrint = result['shouldPrint'] ?? false;
      final payLater = result['payLater'];

      final payload = _buildBaseOrderPayload();
      payload['paymentMethod'] = 'multipay';
      payload['multiplePayments'] = multiPayData;
      if (payLater != null) {
        payload['payLater'] = payLater;
      }

      await _submitOrder(payload, shouldPrint: shouldPrint);
    }
  }

  void redeemCredit() {
    if (selectedCustomer.value == null) {
      AppSnackbar.warning("Please select a customer first");
      return;
    }

    if (cartItems.isEmpty) {
      AppSnackbar.warning("Please add at least one product to the cart");
      return;
    }

    Get.bottomSheet(
      const RedeemCreditBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  void openCouponSheet() {
    if (cartItems.isEmpty) {
      AppSnackbar.warning("Please add at least one product to the cart");
      return;
    }

    Get.bottomSheet(
      const ApplyCouponBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> applyRedemption(Map<String, dynamic> item, String type) async {
    isRedeemLoading.value = true;
    try {
      final payload = {
        "code": item['no']?.toString() ?? '',
        "type": type,
        "customerId": selectedCustomer.value?.id ?? '',
      };

      final res = await _creditNoteRepo.redeemCreditNote(payload);

      if (res.status == 200) {
        final data = res.data;
        final creditBalance =
            double.tryParse(data?['redeemableAmount']?.toString() ?? '0') ??
            0.0;

        // Calculate current order total to cap redemption
        double currentNetTotal = 0;
        for (var item in cartItems) {
          final itemQty = item['qty'] as double;
          final itemMrp = (item['mrp'] as num).toDouble();
          final itemDiscount = (item['discount'] as num).toDouble();
          final itemAdditionalDisc = (item['additionalDisc'] as num).toDouble();
          final taxPercent = (item['taxPercentage'] as num).toDouble();

          double totalDiscount = itemDiscount + itemAdditionalDisc;
          double taxableValue = itemMrp - totalDiscount;
          double itemTax = taxableValue * (taxPercent / 100);
          double sellingPrice = taxableValue + itemTax;
          currentNetTotal += itemQty * sellingPrice;
        }
        final finalRoundOff = double.tryParse(roundOffController.text) ?? 0.0;
        final orderTotal =
            (currentNetTotal - flatDiscount.value) + finalRoundOff;

        // The user can only redeem the lesser of their credit balance OR the order total
        final maxAmount = math.max(0.0, math.min(creditBalance, orderTotal));

        // Show dialog to confirm/edit redemption amount
        final amountController = TextEditingController(
          text: maxAmount.toStringAsFixed(2),
        );

        amountController.text = maxAmount.toStringAsFixed(2);

        Get.dialog(
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Material(
              color: Colors.transparent,
              child: SingleChildScrollView(
                padding: MediaQuery.of(Get.context!).viewInsets,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 24,
                    ),
                    width: double.infinity,
                    constraints: const BoxConstraints(maxWidth: 340),
                    decoration: BoxDecoration(
                      color: Get.context!.appColors.surface,
                      borderRadius: BorderRadius.circular(Sizes.borderRadiusXL),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Gap(24),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Get.context!.appColors.primary.withValues(
                              alpha: 0.1,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            PhosphorIconsLight.checkCircle,
                            color: Get.context!.appColors.primary,
                            size: 32,
                          ),
                        ),
                        const Gap(16),
                        Text(
                          "Confirm Redemption",
                          style: TextHelper.h4Style(
                            Get.context!,
                          ).copyWith(fontWeight: FontWeight.bold),
                        ),
                        const Gap(8),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Text(
                            "Maximum redeemable amount is ₹${maxAmount.toStringAsFixed(2)}",
                            textAlign: TextAlign.center,
                            style: TextHelper.bodySmall.copyWith(
                              color: Get.context!.appColors.textSecondary,
                            ),
                          ),
                        ),
                        const Gap(20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: EditTextField(
                            label: "Amount to Redeem",
                            controller: amountController,
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                            prefixIcon: Icon(
                              PhosphorIconsLight.currencyInr,
                              size: 20,
                              color: Get.context!.appColors.textSecondary,
                            ),
                          ),
                        ),
                        const Gap(24),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                          child: Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () => Get.back(),
                                  style: OutlinedButton.styleFrom(
                                    side: BorderSide(
                                      color: Get.context!.appColors.border,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.borderRadiusM,
                                      ),
                                    ),
                                  ),
                                  child: const Text("Cancel"),
                                ),
                              ),
                              const Gap(12),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {
                                    final enteredAmount =
                                        double.tryParse(
                                          amountController.text,
                                        ) ??
                                        0.0;
                                    if (enteredAmount <= 0) {
                                      AppSnackbar.warning(
                                        "Please enter a valid amount",
                                      );
                                      return;
                                    }
                                    if (enteredAmount > maxAmount) {
                                      AppSnackbar.warning(
                                        "Amount cannot exceed ₹${maxAmount.toStringAsFixed(2)}",
                                      );
                                      return;
                                    }

                                    appliedRedemption.value = RedemptionItem(
                                      id:
                                          (item['_id'] ?? item['id'])
                                              ?.toString() ??
                                          '',
                                      code: item['no']?.toString() ?? '',
                                      type: type,
                                      amount: enteredAmount,
                                      customerId:
                                          selectedCustomer.value?.id ?? '',
                                    );
                                    // Ensure exclusivity: remove other promos and loyalty
                                    appliedCoupon.value = null;
                                    appliedDiscount.value = null;
                                    appliedLoyalty.value = null;
                                    promoDiscountAmount.value = 0.0;

                                    calculateTotals();
                                    Get.back(); // Close Dialog
                                    Get.back(); // Close BottomSheet
                                    AppSnackbar.success(
                                      "Redemption applied successfully",
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Get.context!.appColors.primary,
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        Sizes.borderRadiusM,
                                      ),
                                    ),
                                  ),
                                  child: const Text("Apply"),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          barrierDismissible: true,
          barrierColor: Colors.black.withValues(alpha: 0.5),
        );
      } else {
        AppSnackbar.error(res.message ?? "Failed to redeem credit");
      }
    } catch (e) {
      AppSnackbar.error("Error: $e");
    } finally {
      isRedeemLoading.value = false;
    }
  }

  void removeRedemption() {
    appliedRedemption.value = null;
    calculateTotals();
    AppSnackbar.info("Redemption removed");
  }

  Future<void> fetchCoupons() async {
    isCouponLoading.value = true;
    try {
      final res = await _couponRepo.getCouponDropdown();
      if (res.status == 200 && res.data != null) {
        final List<dynamic> data = res.data;
        coupons.assignAll(data.map((e) => CouponModel.fromJson(e)).toList());
      }
    } catch (e) {
      AppSnackbar.error("Error fetching coupons: $e");
    } finally {
      isCouponLoading.value = false;
    }
  }

  Future<void> fetchDiscounts() async {
    isDiscountLoading.value = true;
    try {
      final res = await _discountRepo.getDiscountDropdown();
      if (res.status == 200 && res.data != null) {
        final List<dynamic> data = res.data;
        discounts.assignAll(
          data.map((e) => DiscountModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      AppSnackbar.error("Error fetching discounts: $e");
    } finally {
      isDiscountLoading.value = false;
    }
  }

  Future<void> applyCoupon(CouponModel coupon) async {
    isLoading.value = true;
    try {
      final payload = {
        "couponId": coupon.id,
        "totalAmount":
            totalMRP.value -
            (productDiscountTotal.value + flatDiscount.value) +
            taxAmount.value, // Net amount including tax before promo
        "customerId": selectedCustomer.value?.id,
      };

      final res = await _couponRepo.verifyCoupon(payload);
      if (res.status == 200) {
        appliedCoupon.value = coupon;
        appliedDiscount.value = null; // Reset discount if coupon applied
        appliedRedemption.value = null; // Reset redemption if coupon applied
        appliedLoyalty.value = null; // Reset loyalty if coupon applied
        promoDiscountAmount.value = (res.data['discountAmount'] as num)
            .toDouble();
        calculateTotals();
        AppSnackbar.success("Coupon '${coupon.name}' applied");
      } else {
        AppSnackbar.error(res.message ?? "Coupon verification failed");
      }
    } catch (e) {
      AppSnackbar.error("Error verifying coupon: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void removeCoupon() {
    appliedCoupon.value = null;
    promoDiscountAmount.value = 0.0;
    calculateTotals();
    AppSnackbar.info("Coupon removed");
  }

  Future<void> applyDiscount(DiscountModel discount) async {
    isLoading.value = true;
    try {
      final payload = {
        "discountId": discount.id,
        "discountCode": discount.discountCode,
        "customerId": selectedCustomer.value?.id,
        "totalAmount":
            totalMRP.value -
            (productDiscountTotal.value + flatDiscount.value) +
            taxAmount.value, // Net amount including tax before promo
        "totalQty": totalQuantity.value.toStringAsFixed(2),
        "items": cartItems.map((item) {
          return {
            "productId": item['id'],
            "qty": item['qty'],
            "mrp": item['mrp'],
            "unitCost": item['unitCost'],
            "netAmount": item['netAmount'],
          };
        }).toList(),
      };

      final res = await _discountRepo.verifyDiscount(payload);
      if (res.status == 200) {
        appliedDiscount.value = discount;
        appliedCoupon.value = null; // Reset coupon if discount applied
        appliedRedemption.value = null; // Reset redemption if discount applied
        appliedLoyalty.value = null; // Reset loyalty if discount applied
        promoDiscountAmount.value = (res.data['discountAmount'] as num)
            .toDouble();
        calculateTotals();
        AppSnackbar.success("Discount '${discount.title}' applied");
      } else {
        AppSnackbar.error(res.message ?? "Discount verification failed");
      }
    } catch (e) {
      AppSnackbar.error("Error verifying discount: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void removeDiscount() {
    appliedDiscount.value = null;
    promoDiscountAmount.value = 0.0;
    calculateTotals();
    AppSnackbar.info("Discount removed");
  }

  Future<void> fetchRedeemables() async {
    if (selectedCustomer.value == null) return;

    isRedeemLoading.value = true;
    try {
      final cn = await _creditNoteRepo.getRedeemDropdown(
        typeFilter: 'credit_note',
        customerFilter: selectedCustomer.value!.id,
      );
      creditNotes.assignAll(cn);

      final ap = await _creditNoteRepo.getRedeemDropdown(
        typeFilter: 'advance_payment',
        customerFilter: selectedCustomer.value!.id,
      );
      advancePayments.assignAll(ap);
    } catch (e) {
      debugPrint("Error fetching redeemables: $e");
    } finally {
      isRedeemLoading.value = false;
    }
  }

  Future<void> submitCashOrder({bool shouldPrint = false}) async {
    if (cartItems.isEmpty) {
      AppSnackbar.error("Cart is empty");
      return;
    }
    if (selectedCustomer.value == null) {
      AppSnackbar.error("Please select a customer");
      return;
    }

    final payload = _buildBaseOrderPayload();
    payload["paymentMethod"] = "cash";
    payload["multiplePayments"] = [
      {"method": "cash", "amount": totalAmount.value.toStringAsFixed(2)},
    ];

    await _submitOrder(payload, shouldPrint: shouldPrint);
  }

  void openCardPaymentSheet({bool shouldPrint = false}) {
    if (cartItems.isEmpty) {
      AppSnackbar.error("Cart is empty");
      return;
    }
    if (selectedCustomer.value == null) {
      AppSnackbar.error("Please select a customer");
      return;
    }

    Get.bottomSheet(
      CardPaymentBottomSheet(
        totalAmount: totalAmount.value,
        onConfirm: (cardHolder, transNo, accountId) {
          submitCardOrder(
            cardHolderName: cardHolder,
            cardTransactionNo: transNo,
            paymentAccountId: accountId,
            shouldPrint: shouldPrint,
          );
        },
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> submitCardOrder({
    required String cardHolderName,
    required String cardTransactionNo,
    required String paymentAccountId,
    bool shouldPrint = false,
  }) async {
    final payload = _buildBaseOrderPayload();
    payload["paymentMethod"] = "card";
    payload["multiplePayments"] = [
      {
        "method": "card",
        "paymentAccountId": paymentAccountId,
        "amount": totalAmount.value.toStringAsFixed(2),
        "cardHolderName": cardHolderName,
        "cardTransactionNo": cardTransactionNo,
      },
    ];

    await _submitOrder(payload, shouldPrint: shouldPrint);
  }

  void openPayLaterSheet() {
    if (cartItems.isEmpty) {
      AppSnackbar.error("Cart is empty");
      return;
    }
    if (selectedCustomer.value == null) {
      AppSnackbar.error("Please select a customer");
      return;
    }

    Get.bottomSheet(
      PayLaterBottomSheet(
        totalAmount: totalAmount.value,
        onConfirm: (paymentTermsId, dueDate, sendReminder) {
          Get.back(); // Close sheet
          submitPayLaterOrder(
            paymentTermsId: paymentTermsId,
            dueDate: dueDate,
            sendReminder: sendReminder,
            shouldPrint: true,
          );
        },
      ),
      isScrollControlled: true,
    );
  }

  Future<void> submitPayLaterOrder({
    required String paymentTermsId,
    required DateTime dueDate,
    required bool sendReminder,
    bool shouldPrint = false,
  }) async {
    final payload = _buildBaseOrderPayload();
    payload["paymentMethod"] = "pay_later";
    payload["payLater"] = {
      "dueDate": dueDate.toIso8601String(),
      "sendReminder": sendReminder,
      "paymentTermsId": paymentTermsId,
    };

    await _submitOrder(payload, shouldPrint: shouldPrint);
  }

  Future<void> submitUpiOrder({bool shouldPrint = false}) async {
    if (cartItems.isEmpty) {
      AppSnackbar.error("Cart is empty");
      return;
    }
    if (selectedCustomer.value == null) {
      AppSnackbar.error("Please select a customer");
      return;
    }

    final payload = _buildBaseOrderPayload();
    payload["paymentMethod"] = "upi";
    payload["multiplePayments"] = [
      {"method": "upi", "amount": totalAmount.value.toStringAsFixed(2)},
    ];

    await _submitOrder(payload, shouldPrint: shouldPrint);
  }

  Future<void> holdOrder({bool shouldPrint = false}) async {
    if (cartItems.isEmpty) {
      AppSnackbar.error("Cart is empty");
      return;
    }
    if (selectedCustomer.value == null) {
      AppSnackbar.error("Please select a customer");
      return;
    }

    final payload = _buildBaseOrderPayload();
    payload["status"] = "hold";

    await _submitOrder(
      payload,
      successMessage: "Order placed on hold",
      shouldPrint: shouldPrint,
    );
  }

  Map<String, dynamic> _buildBaseOrderPayload() {
    final payload = {
      "items": cartItems
          .map(
            (item) => {
              "productId": item['id'],
              "qty": item['qty'],
              "mrp": item['mrp'],
              "discountAmount": item['discount'],
              "additionalDiscountAmount": item['additionalDisc'],
              "unitCost": item['unitCost'],
              "netAmount": item['netAmount'],
            },
          )
          .toList(),
      "customerId": selectedCustomer.value?.id,
      "orderType": orderType.value == 0 ? "walk_in" : "delivery",
      "salesManId": selectedSalesman.value?.id,
      "totalQty": totalQuantity.value.toStringAsFixed(2),
      "totalMrp": totalMRP.value.toStringAsFixed(2),
      "totalTaxAmount": taxAmount.value.toStringAsFixed(2),
      "totalDiscount": totalDiscount.value.toStringAsFixed(2),
      "totalAdditionalCharge": addCharges.value,
      "flatDiscountAmount": flatDiscount.value,
      "additionalCharges": [],
      "roundOff": roundOffController.text,
      "totalAmount": totalAmount.value.toStringAsFixed(2),
      "couponDiscount": appliedCoupon.value != null
          ? promoDiscountAmount.value
          : 0,
      "loyaltyDiscount": appliedLoyalty.value != null
          ? (appliedLoyalty.value?.discountValue ?? 0)
          : 0,
      "discountAmount": appliedDiscount.value != null
          ? promoDiscountAmount.value
          : 0,
      "redeemCreditAmount": appliedRedemption.value?.amount ?? 0,
      "freeProducts": [],
    };

    // Add optional IDs only if they are applied and have values to avoid backend validation errors
    if (appliedCoupon.value != null &&
        (appliedCoupon.value?.id.isNotEmpty ?? false)) {
      payload["couponId"] = appliedCoupon.value?.id;
    }

    if (appliedDiscount.value != null &&
        (appliedDiscount.value?.id.isNotEmpty ?? false)) {
      payload["discountId"] = appliedDiscount.value?.id;
      payload["discountMode"] = "normal";
    }

    if (appliedLoyalty.value != null &&
        (appliedLoyalty.value?.loyaltyId.isNotEmpty ?? false)) {
      payload["loyaltyId"] = appliedLoyalty.value?.loyaltyId;
    }

    if (appliedRedemption.value != null &&
        appliedRedemption.value!.id.isNotEmpty) {
      payload["redeemCreditId"] = appliedRedemption.value?.id;
      payload["redeemCreditType"] = appliedRedemption.value?.type;
    }

    return payload;
  }

  Future<void> _submitOrder(
    Map<String, dynamic> payload, {
    String? successMessage,
    bool shouldPrint = false,
  }) async {
    try {
      isLoading.value = true;

      // If editing and status not explicitly set (e.g. by holdOrder), set to done
      if (isEditMode.value && payload["status"] == null) {
        payload["status"] = "completed";
      }

      final res = isEditMode.value
          ? await _orderRepo.editPosOrder({
              ...payload,
              "posOrderId": editingOrderId.value,
            })
          : await _orderRepo.addPosOrder(payload);

      if (res.status == 200 || res.status == 201) {
        if (shouldPrint && res.data != null) {
          // Trigger printing without awaiting to avoid blocking success message and navigation
          _printOrderReceipt(res.data);
        }
        AppSnackbar.success(successMessage ?? "Order placed successfully");
        clearCart();
        if (Get.isBottomSheetOpen ?? false) Get.back();
        await checkRegisterStatus();
      } else {
        AppSnackbar.error(res.message ?? "Something went wrong");
      }
    } catch (e) {
      AppSnackbar.error(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _printOrderReceipt(dynamic orderData) async {
    // Capture current state before any potential cart clearing
    final currentCustomer = selectedCustomer.value;
    final currentCart = List<Map<String, dynamic>>.from(cartItems);

    try {
      // Handle cases where the API might return nested data or a list
      dynamic data = orderData;
      if (data is Map && data.containsKey('data')) {
        data = data['data'];
      } else if (data is Map && data.containsKey('order')) {
        data = data['order'];
      }

      if (data is List && data.isNotEmpty) {
        data = data.first;
      }

      // Patch the data map to handle string IDs returned by the API
      // The model expects Map objects, but API returns String IDs
      if (data is Map<String, dynamic>) {
        final Map<String, dynamic> patchedData = Map<String, dynamic>.from(
          data,
        );

        // 1. Handle CustomerId (Enrich with selected customer name)
        if (patchedData['customerId'] is String) {
          patchedData['customerId'] = {
            '_id': patchedData['customerId'],
            'firstName': currentCustomer?.firstName ?? "Walk-in",
            'lastName': currentCustomer?.lastName ?? "Customer",
          };
        }

        // 2. Handle SalesManId
        if (patchedData['salesManId'] is String) {
          patchedData['salesManId'] = {
            '_id': patchedData['salesManId'],
            'firstName': "Salesman",
            'lastName': "",
          };
        }

        // 3. Handle Top-level relation fields that expect objects
        for (var key in [
          'createdBy',
          'companyId',
          'branchId',
          'posCashRegisterId',
          'salesManId',
          'customerId',
        ]) {
          // Note: salesManId and customerId are already handled above but this handles them
          // if they weren't matched or if we just want a generic fallback.
          if (patchedData[key] is String) {
            if (key == 'customerId') {
              // Handled above in step 1
            } else if (key == 'salesManId') {
              // Handled above in step 2
            } else {
              patchedData[key] = {'_id': patchedData[key]};
            }
          }
        }

        // 5. Handle PayLater nested fields
        if (patchedData['payLater'] is Map) {
          final payLater = Map<String, dynamic>.from(patchedData['payLater']);
          if (payLater['paymentTermsId'] is String) {
            payLater['paymentTermsId'] = {'_id': payLater['paymentTermsId']};
          }
          patchedData['payLater'] = payLater;
        }

        // 6. Handle Items (Enrich with product names from cart)
        if (patchedData['items'] is List) {
          final List<dynamic> items = List<dynamic>.from(patchedData['items']);
          for (int i = 0; i < items.length; i++) {
            if (items[i] is Map<String, dynamic>) {
              final Map<String, dynamic> item = Map<String, dynamic>.from(
                items[i],
              );
              if (item['productId'] is String) {
                final prodId = item['productId'];
                // Try to find name in captured cart
                final cartItem = currentCart.firstWhereOrNull(
                  (element) => element['id'] == prodId,
                );
                item['productId'] = {
                  '_id': prodId,
                  'name': cartItem?['name'] ?? "Product",
                };
                items[i] = item;
              }
            }
          }
          patchedData['items'] = items;
        }

        data = patchedData;
      }

      final order = OrderListModel.fromJson(data);
      final pdfData = PdfMappers.mapPOSOrder(order);
      await PdfService.generateAndPrint(pdfData);
    } catch (e) {
      debugPrint("POS Print Error: $e");
      AppSnackbar.error("Failed to print receipt: $e");
    }
  }

  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        selectedImage.value = File(pickedFile.path);
        AppSnackbar.success("Image selected successfully");
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      AppSnackbar.error("Failed to pick image: $e");
    }
  }

  void removeImage() {
    selectedImage.value = null;
    AppSnackbar.info("Image removed");
  }

  void showImageOptions(BuildContext context) {
    Get.bottomSheet(
      ImageSourceBottomSheet(
        onSourceSelected: (source) => pickImage(source),
        onRemove: () => removeImage(),
        hasImage: selectedImage.value != null,
      ),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
