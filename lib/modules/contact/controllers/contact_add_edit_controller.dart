import 'package:ai_setu/core/constants/enums.dart';
import 'package:ai_setu/core/services/logger_service.dart';
import 'package:ai_setu/data/model/contact_model/contact_model.dart';
import 'package:ai_setu/data/model/location/location_model.dart';
import 'package:ai_setu/data/repositories/contact/contact_repository.dart';
import 'package:ai_setu/data/repositories/inventory/location_repository.dart';
import 'package:ai_setu/modules/contact/controllers/contact_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_setu/core/utils/app_snackbar.dart';
import 'package:intl/intl.dart';

class ContactAddEditController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final isLoading = false.obs;
  final isSaving = false.obs;
  final isEdit = false.obs;

  final contactType = ContactType.customer.obs;
  final isActive = true.obs;

  // Controllers for General Details
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final companyNameController = TextEditingController();
  final phoneController = TextEditingController();
  final whatsappController = TextEditingController();
  final telephoneController = TextEditingController();
  final remarksController = TextEditingController();
  final panNoController = TextEditingController();
  final debitBalanceController = TextEditingController(text: "0");
  final creditBalanceController = TextEditingController(text: "0");
  final transporterIdController = TextEditingController();
  final tanNoController = TextEditingController();

  // Supplier Bank Details
  final bankIfscController = TextEditingController();
  final bankNameController = TextEditingController();
  final bankBranchController = TextEditingController();
  final bankAccountNoController = TextEditingController();

  // Dropdown values
  final paymentMode = Rx<String?>(null);
  final paymentTerms = Rx<String?>(null);
  final customerCategory = Rx<String?>(null);
  final customerType = Rx<String?>(null);
  final supplierType = Rx<String?>(null);

  final dob = Rx<DateTime?>(null);
  final anniversaryDate = Rx<DateTime?>(null);

  // Address Details
  final addresses = <ContactAddress>[].obs;

  // Masters
  final countries = <LocationDropdown>[].obs;
  final paymentTermsList =
      <String>[].obs; // Assuming simple list of names for now

  final _repo = ContactRepository();
  final _locationRepo = LocationRepository();
  // final _paymentTermsRepo = PaymentTermsRepository(); // Add when needed

  ContactModel? _initialContact;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is ContactModel) {
      _initialContact = args;
      isEdit.value = true;
      _fillData(args);
    } else {
      // Add one default address
      addAddress();
    }
    fetchMasters();
  }

  void _fillData(ContactModel contact) {
    contactType.value = ContactType.values.firstWhere(
      (e) => e.name == contact.contactType,
      orElse: () => ContactType.customer,
    );
    isActive.value = contact.isActive;
    firstNameController.text = contact.firstName;
    lastNameController.text = contact.lastName;
    emailController.text = contact.email ?? "";
    companyNameController.text = contact.companyName ?? "";
    phoneController.text = contact.phoneNo?.phoneNo?.toString() ?? "";
    whatsappController.text = contact.whatsappNo?.phoneNo?.toString() ?? "";
    telephoneController.text = contact.telephoneNo ?? "";
    remarksController.text = contact.remarks ?? "";
    panNoController.text = contact.panNo ?? "";
    debitBalanceController.text = contact.openingBalance?.debitBalance ?? "0";
    creditBalanceController.text = contact.openingBalance?.creditBalance ?? "0";
    dob.value = contact.dob;
    anniversaryDate.value = contact.anniversaryDate;
    paymentMode.value = contact.paymentMode;
    paymentTerms.value = contact.paymentTerms;
    customerCategory.value = contact.customerCategory;
    customerType.value = contact.customerType;
    supplierType.value = contact.supplierType;
    transporterIdController.text = contact.transporterId ?? "";

    if (contact.bankDetails != null) {
      bankIfscController.text = contact.bankDetails!.ifscCode ?? "";
      bankNameController.text = contact.bankDetails!.name ?? "";
      bankBranchController.text = contact.bankDetails!.branch ?? "";
      bankAccountNoController.text = contact.bankDetails!.accountNumber ?? "";
    }

    addresses.assignAll(contact.address);
  }

  Future<void> fetchMasters() async {
    try {
      isLoading.value = true;
      final cList = await _locationRepo.countryDropdown();
      countries.assignAll(cList);

      // Fetch other masters like payment terms if repository is ready
    } catch (e) {
      Log.e("Contact Master Error", e);
    } finally {
      isLoading.value = false;
    }
  }

  void addAddress() {
    addresses.add(const ContactAddress(id: ""));
  }

  void removeAddress(int index) {
    if (addresses.length > 1) {
      addresses.removeAt(index);
    }
  }

  void updateAddress(int index, ContactAddress address) {
    addresses[index] = address;
  }

  Future<void> saveContact() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isSaving.value = true;

      final payload = <String, dynamic>{
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "companyName": companyNameController.text,
        "email": emailController.text,
        "phoneNo": {"phoneNo": phoneController.text, "countryCode": "91"},
        "whatsappNo": {"phoneNo": whatsappController.text, "countryCode": "91"},
        "telephoneNo": telephoneController.text,
        "remarks": remarksController.text,

        "openingBalance": {
          "debitBalance": debitBalanceController.text,
          "creditBalance": creditBalanceController.text,
        },
        "address": addresses.map((e) {
          final m = e.toMap();
          m.remove("_id");

          // Backend expects IDs as strings for location fields
          if (e.country != null) m["country"] = e.country!.id;
          if (e.state != null) m["state"] = e.state!.id;
          if (e.city != null) m["city"] = e.city!.id;

          // Ensure contactNo.phoneNo is a string
          if (m["contactNo"] != null && m["contactNo"]["phoneNo"] != null) {
            m["contactNo"]["phoneNo"] = m["contactNo"]["phoneNo"].toString();
          }

          return m;
        }).toList(),
        "contactType": contactType.value.name,
        "status": "active",
      };

      if (dob.value != null) {
        payload["dob"] = DateFormat("yyyy-MM-dd").format(dob.value!);
      }

      if (panNoController.text.isNotEmpty) {
        payload["panNo"] = panNoController.text;
      }
      if (anniversaryDate.value != null) {
        payload["anniversaryDate"] = DateFormat(
          "yyyy-MM-dd",
        ).format(anniversaryDate.value!);
      }
      if (paymentMode.value != null) payload["paymentMode"] = paymentMode.value;
      if (paymentTerms.value != null) {
        payload["paymentTerms"] = paymentTerms.value;
      }
      if (customerCategory.value != null) {
        payload["customerCategory"] = customerCategory.value;
      }
      if (customerType.value != null) {
        payload["customerType"] = customerType.value;
      }
      if (supplierType.value != null) {
        payload["supplierType"] = supplierType.value;
      }
      if (transporterIdController.text.isNotEmpty) {
        payload["transporterId"] = transporterIdController.text;
      }

      if (contactType.value == ContactType.supplier) {
        payload["bankDetails"] = {
          "ifscCode": bankIfscController.text,
          "name": bankNameController.text,
          "branch": bankBranchController.text,
          "accountNumber": bankAccountNoController.text,
        };
      }

      final res = isEdit.value
          ? await _repo.updateContact({
              ...payload,
              "contactId": _initialContact?.id,
            })
          : await _repo.addContact(payload);

      if (res.status == 200 || res.status == 201) {
        await _refreshAndBack();
        AppSnackbar.success(res.message ?? "Contact saved successfully");
      } else {
        AppSnackbar.error(res.message ?? "Failed to save contact");
      }
    } catch (e) {
      Log.e("Save Contact Error", e);
      AppSnackbar.error(e.toString());
    } finally {
      isSaving.value = false;
    }
  }

  Future<void> _refreshAndBack() async {
    final contactController = Get.isRegistered<ContactController>()
        ? Get.find<ContactController>()
        : null;

    if (contactController != null) {
      await contactController.refreshData();
    }
    Get.back(result: true);
  }
}
