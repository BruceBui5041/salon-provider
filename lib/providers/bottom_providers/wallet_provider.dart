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
  bool isLoadingMore = false;
  String? error;

  // Pagination properties
  int currentOffset = 0;
  int pageSize = 5;
  bool hasMoreData = true;

  int statusIndex = 0;
  bool hasActiveFilters = false;

  List<List<Condition>>? _buildConditions() {
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

    return conditions;
  }

  Future<void> resetPagination() async {
    paymentList = [];
    currentOffset = 0;
    hasMoreData = true;
    error = null;
    notifyListeners();
  }

  Future<void> fetchPayments() async {
    await resetPagination();
    await loadPayments();
  }

  Future<void> loadMorePayments() async {
    if (isLoading || isLoadingMore || !hasMoreData) return;

    isLoadingMore = true;
    notifyListeners();

    await loadPayments(loadMore: true);
  }

  Future<void> loadPayments({bool loadMore = false}) async {
    try {
      if (!loadMore) {
        isLoading = true;
      } else {
        isLoadingMore = true;
      }
      notifyListeners();

      var conditions = _buildConditions();

      var newPayments = await _paymentRepository.getPayments(
        conditions: conditions,
        limit: pageSize,
        offset: loadMore ? currentOffset : 0,
      );

      if (loadMore) {
        paymentList.addAll(newPayments);
      } else {
        paymentList = newPayments;
      }

      hasMoreData = newPayments.length >= pageSize;
      if (hasMoreData) {
        currentOffset += newPayments.length;
      }

      error = null;
    } catch (e) {
      error = e.toString();
      if (!loadMore) {
        paymentList = [];
      }
    } finally {
      isLoading = false;
      isLoadingMore = false;
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
