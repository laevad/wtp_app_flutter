import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/navigate/navigate_presenter.dart';

import '../../../domain/entities/location.dart';

class NavigateController extends Controller {
  final NavigatePresenter presenter;
  LocationModel? _location;
  LocationModel? get location => _location;
  NavigateController(repository) : presenter = NavigatePresenter(repository);
  @override
  void initListeners() {
    /**/
    presenter.getUserLocationOnNext = (LocationModel location) {
      _location = location;
      print("user location on next");
    };
    presenter.getUserLocationOnError = (e) {
      print("User location error ${e.toString()}");
    };
    presenter.getUserLocationOnComplete = () {
      print("user location on complete");
    };
  }

  void addLocation() {
    presenter.addUserLocation(12, 12);
  }
}
