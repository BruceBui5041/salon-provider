import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:salon_provider/config/injection_config.dart';
import 'package:salon_provider/model/request/generate_qr_req.dart';
import 'package:salon_provider/model/response/bank_account_res.dart';
import 'package:salon_provider/model/response/payment_response.dart';
import 'package:salon_provider/repositories/payment_repository.dart';
import 'package:salon_provider/screens/app_pages_screens/payment_qr_screen/layouts/qr_generate_dialog.dart';
import '../../config.dart';

class PaymentQrProvider with ChangeNotifier {
  final PaymentRepository paymentRepository = getIt<PaymentRepository>();
  List<BankAccountRes> bankAccounts = [];
  BankAccountRes? selectedBank;
  bool isLoading = false;
  String? errorMessage;
  BuildContext? _context;
  String? paymentId;
  Payment? payment;
  bool isGeneratingQr = false;

  onReady(BuildContext context, {String? paymentId}) {
    _context = context;
    this.paymentId = paymentId;
    if (paymentId != null) {
      _loadPayment();
    }
    fetchBanks();
  }

  Future<void> _loadPayment() async {
    try {
      payment = await paymentRepository.getPaymentById(paymentId!);
      notifyListeners();
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> fetchBanks() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      bankAccounts = await paymentRepository.getBankAccounts();
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      errorMessage = "Failed to load banks: ${e.toString()}";
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
    notifyListeners();
  }

  void refreshBanks(BuildContext context) {
    _context = context;
    fetchBanks();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(language(context, appFonts.refresh))),
    );
  }

  Future<void> generateQrCode(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => QrGenerateDialog(
        selectedBank: selectedBank,
        payment: payment,
        paymentId: paymentId,
        isGeneratingQr: isGeneratingQr,
        onGenerateQr: () async {
          if (paymentId == null || selectedBank == null) return;

          isGeneratingQr = true;
          notifyListeners();

          try {
            final request = GenerateQRReq(
              paymentId: paymentId!,
              bankAccountId: selectedBank!.id!,
            );

            await paymentRepository.genPaymentQrCode(request);

            isGeneratingQr = false;
            notifyListeners();

            // Close the generate dialog
            if (dialogContext.mounted) {
              Navigator.of(dialogContext).pop();
              await _loadPayment();
            }

            if (context.mounted) {
              route.popAndPushNamed(
                context,
                routeName.paymentQr,
                arg: paymentId,
              );
            }
          } catch (e) {
            isGeneratingQr = false;
            notifyListeners();

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to generate QR: ${e.toString()}'),
              ),
            );
          }
        },
      ),
    );
  }
}
