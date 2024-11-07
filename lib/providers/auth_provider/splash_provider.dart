import 'dart:async';
import 'dart:developer';
import '../../config.dart';

class SplashProvider extends ChangeNotifier {
  double size = 10;
  double roundSize = 10;
  double roundSizeWidth = 10;
  AnimationController? controller;
  Animation<double>? animation;

  AnimationController? controller2;
  Animation<double>? animation2;

  AnimationController? controller3;
  Animation<double>? animation3;

  AnimationController? controllerSlide;
  Animation<Offset>? offsetAnimation;

  AnimationController? popUpAnimationController;



  onReady(TickerProvider sync, context) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    var freelancer = prefs.getBool("isFreelancer") ?? false;
    var login = prefs.getBool(session.isLogin) ?? false;
    log("FREEELANCEERRR $freelancer");
    log("LOGGIINN $login");

    isFreelancer = freelancer;
    isLogin = login;

    controller =
        AnimationController(vsync: sync, duration: const Duration(seconds: 2))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              controller!.stop();
              notifyListeners();
            }
            if (status == AnimationStatus.dismissed) {
              controller!.forward();
              notifyListeners();
            }
          });

    animation = CurvedAnimation(parent: controller!, curve: Curves.easeIn);
    controller!.forward();

    controller2 =
        AnimationController(vsync: sync, duration: const Duration(seconds: 2));
    animation2 = CurvedAnimation(parent: controller2!, curve: Curves.easeIn);

    if (controller2!.status == AnimationStatus.forward ||
        controller2!.status == AnimationStatus.completed) {
      controller2!.reverse();
      notifyListeners();
    } else if (controller2!.status == AnimationStatus.dismissed) {
      Timer(const Duration(seconds: 2), () {

        controller2!.forward();
        notifyListeners();
      });
    }

    controllerSlide =
        AnimationController(vsync: sync, duration: const Duration(seconds: 2));

    offsetAnimation =
        Tween<Offset>(begin: const Offset(0.0, 1.0), end: Offset.zero)
            .animate(controllerSlide!);

    controller3 =
        AnimationController(duration: const Duration(seconds: 2), vsync: sync)
          ..repeat();
    animation3 = CurvedAnimation(parent: controller3!, curve: Curves.easeIn);

    popUpAnimationController =
        AnimationController(vsync: sync, duration: const Duration(seconds: 2));

    Timer(const Duration(seconds: 2), () {
      popUpAnimationController!.forward();
      notifyListeners();
    });

    Timer(const Duration(seconds: 4), () async {
      log("IS LOGINN $login");
      if(login){
        route.pushReplacementNamed(context, routeName.dashboard);
      } else {
        route.pushReplacementNamed(context, routeName.intro);
      }
    });
  }

  onDispose() {
    controller2!.dispose();
    controller3!.dispose();
    controller!.dispose();
    controllerSlide!.dispose();
    popUpAnimationController!.dispose();
  }

  onChangeSize() {
    size = size == 10 ? 115 : 115;
    notifyListeners();
  }
}
