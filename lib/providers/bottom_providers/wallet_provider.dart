import 'package:salon_provider/config.dart';
import 'package:salon_provider/model/response/payment_response.dart';
import 'package:salon_provider/repositories/payment_repository.dart';
import 'package:salon_provider/model/request/search_request_model.dart';
import 'package:salon_provider/common/enum_value.dart';
import 'package:salon_provider/screens/bottom_screens/wallet_screen/layouts/wallet_filter_layout.dart';

class WalletProvider with ChangeNotifier {
  final PaymentRepository _paymentRepository = PaymentRepository();
  List<Payment> paymentList = [];
  bool isLoading = false;
  String? error;

  int statusIndex = 0;
  bool hasActiveFilters = false;

  Future<void> fetchPayments() async {
    try {
      isLoading = true;
      notifyListeners();

      List<List<Condition>>? conditions;

      // Add status filter condition
      if (statusIndex > 0 && statusIndex <= PaymentStatus.values.length) {
        String status = PaymentStatus.values[statusIndex - 1].value;
        conditions = [
          [
            Condition(
              source: "payment.transaction_status",
              operator: "=",
              target: status,
            ),
          ]
        ];
      }

      paymentList = await _paymentRepository.getPayments(
          conditions: conditions, limit: 10);
      error = null;
    } catch (e) {
      error = e.toString();
      paymentList = [];
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  onReady() {
    fetchPayments();
  }

  onTapFilter(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const WalletFilterLayout();
      },
    );
  }

  onStatus(index) {
    statusIndex = index;
    notifyListeners();
  }

  onApplyFilter(context) {
    hasActiveFilters = statusIndex > 0;
    route.pop(context);
    fetchPayments();
  }

  onClearFilter(context) {
    statusIndex = 0;
    hasActiveFilters = false;
    route.pop(context);
    fetchPayments();
  }
}
