import '../../../config.dart';
import 'package:salon_provider/screens/bottom_screens/home_screen/layouts/popular_service_layout.dart';

class PopularServiceScreen extends StatefulWidget {
  const PopularServiceScreen({super.key});

  @override
  State<PopularServiceScreen> createState() => _PopularServiceScreenState();
}

class _PopularServiceScreenState extends State<PopularServiceScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, value, _) {
      return Scaffold(
          appBar: AppBarCommon(title: appFonts.myService),
          body: SingleChildScrollView(
              child: Column(children: [
            SearchTextFieldCommon(
                    focusNode: value.searchFocus, controller: value.searchCtrl)
                .padding(bottom: Insets.i20),
            const FeaturedServicesLayout()
          ]).paddingSymmetric(horizontal: Insets.i20)));
    });
  }
}
