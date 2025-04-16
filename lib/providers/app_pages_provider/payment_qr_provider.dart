import 'package:flutter/material.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/response/bank_account_res.dart';
import 'package:salon_provider/repositories/payment_repository.dart';
import '../../config.dart';

class PaymentQrProvider with ChangeNotifier {
  final PaymentRepository paymentRepository = getIt<PaymentRepository>();
  List<BankAccountRes> bankAccounts = [];
  BankAccountRes? selectedBank;
  bool isLoading = false;
  String? errorMessage;
  BuildContext? _context;

  onReady(BuildContext context) {
    _context = context;
    fetchBanks();
  }

  Future<void> fetchBanks() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      bankAccounts = await paymentRepository.getBankAccounts();

      if (bankAccounts.isNotEmpty) {
        debugPrint(
            "Banks loaded successfully: ${bankAccounts.length} banks found");
      } else {
        debugPrint("No banks found from repository");
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Failed to load banks: ${e.toString()}";
      debugPrint(errorMessage);
      notifyListeners();

      // Show error to user if context is available
      if (_context != null) {
        ScaffoldMessenger.of(_context!).showSnackBar(
          SnackBar(content: Text(errorMessage!)),
        );
      }
    }
  }

  void selectBank(BankAccountRes? bank) {
    selectedBank = bank;
    debugPrint("Selected bank: ${bank?.name ?? 'None'} with ID: ${bank?.id}");
    notifyListeners();
  }

  void refreshBanks(BuildContext context) {
    _context = context;
    fetchBanks();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Refreshing banks list...')),
    );
  }

  void generateQrCode(BuildContext context) {
    if (selectedBank == null) {
      showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
          height: Sizes.s100,
          title: 'Select Bank',
          singleText: 'OK',
          image: eGifAssets.error,
          subtext: 'Please select a bank first',
          singleTap: () => route.pop(context),
        ),
      );
      return;
    }

    debugPrint("Generating QR code for bank: ${selectedBank!.name}");

    // Here you would typically generate or fetch a QR code
    // For now we'll just show a success dialog
    showDialog(
      context: context,
      builder: (context1) => AppAlertDialogCommon(
        height: Sizes.s100,
        title: 'QR Generated',
        singleText: 'OK',
        image: eGifAssets.successGif,
        subtext: 'QR code generated successfully for ${selectedBank!.name}',
        singleTap: () => route.pop(context),
      ),
    );
  }
}
