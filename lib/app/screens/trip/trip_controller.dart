import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:wtp_app/app/screens/trip/trip_presenter.dart';

import '../../../domain/entities/trip.dart';
import '../navigate/navigate_view.dart';

enum LoadingMoreStatus { loading, stable }

class MyTripController extends Controller {
  final TripPresenter presenter;

  late List<Trip> _trip;
  List<Trip> get trip => _trip;
  int? _lastPage;
  int? get lastPage => _lastPage;
  static int _page = 0;
  bool isLoading = false;
  final ScrollController _scrollController = ScrollController();
  ScrollController? get scrollController => _scrollController;

  MyTripController(tripRepository) : presenter = TripPresenter(tripRepository);
  @override
  void initListeners() async {
    /**/
    if (_page == 0) {
      presenter.getData(++_page);
      refreshUI();
    }

    presenter.getTripOnNext = (TripModel trip) {
      if (_page == 1) {
        _trip = trip.trips!;
      } else {
        _trip = _trip + trip.trips!;
      }
      _lastPage = trip.lastPage;
      print("trip on next");
      refreshUI();
    };
    presenter.getTripOnError = (e) {
      print("trip on error ${e.toString()}");
    };
    presenter.getTripOnComplete = () async {
      _scrollController.addListener(() {
        if (_page < (lastPage!.toInt())) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            presenter.getData(++_page);
            refreshUI();
          }
        }
      });
      print("trip on complete");
    };
    /**/
  }

  void navigate() {
    Navigator.pushNamed(getContext(), NavigateView.routeName);
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
