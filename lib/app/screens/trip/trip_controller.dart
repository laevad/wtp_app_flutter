import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../data/repository/helpers/auth/is_auth.dart';
import '../../../domain/entities/trip.dart';
import '../../utils/constant.dart';
import '../navigate/navigate_view.dart';
import 'trip_presenter.dart';

enum LoadingMoreStatus { loading, stable }

class TripController extends Controller {
  final TripPresenter presenter;

  List<Trip>? _trip;
  List<Trip>? get trip => _trip;

  List<Trip>? _tripC;
  List<Trip>? get tripC => _tripC;

  int? _lastPage;
  int? get lastPage => _lastPage;

  int? _lastPageC;
  int? get lastPageC => _lastPageC;

  int _page = 0;
  final ScrollController _scrollController = ScrollController();
  ScrollController? get scrollController => _scrollController;

  int _pageC = 0;
  final ScrollController _scrollControllerC = ScrollController();
  ScrollController? get scrollControllerC => _scrollControllerC;
  TripController(tripRepository) : presenter = TripPresenter(tripRepository);

  Future refresh() async {
    _page = 0;
    _trip = [];
    presenter.getData(++_page);
  }

  Future refreshC() async {
    _pageC = 0;
    _tripC = [];
    presenter.getDataComplete(++_pageC);
  }

  @override
  void initListeners() async {
    /**/
    Constant.configLoading();
    if (_page == 0) {
      print(_page);
      EasyLoading.show(status: 'loading please wait...');
      presenter.getData(++_page);
      refreshUI();
    }
    if (_pageC == 0) {
      EasyLoading.show(status: 'loading please wait...');
      presenter.getDataComplete(++_pageC);
      refreshUI();
    }

    presenter.getTripOnNext = (TripModel trip) {
      if (_trip == null) {
        EasyLoading.show(status: "loading please wait...");
      }
      if (_page == 1) {
        _trip = trip.trips!;
      } else {
        _trip = _trip! + trip.trips!;
      }
      _lastPage = trip.lastPage;
      print("trip on next");
      refreshUI();
    };
    presenter.getTripOnError = (e) {
      print("trip on error!!! ${e.toString()}");
      EasyLoading.dismiss();
    };
    presenter.getTripOnComplete = () async {
      _scrollController.addListener(() {
        if (_page < (lastPage!.toInt())) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            EasyLoading.show(status: "loading please wait...");
            presenter.getData(++_page);
            refreshUI();
          }
        }
      });
      EasyLoading.dismiss();
      print("trip on complete");
    };
    presenter.getTripCOnNext = (TripModel trip) {
      if (_tripC == null) {
        EasyLoading.show(status: "loading please wait...");
      }
      if (_pageC == 1) {
        _tripC = trip.trips!;
      } else {
        _tripC = _tripC! + trip.trips!;
      }
      _lastPageC = trip.lastPage;
      print("trip on next");
      refreshUI();
    };
    presenter.getTripCOnError = (e) {
      print("trip on error ${e.toString()}");
      EasyLoading.dismiss();
    };
    presenter.getTripCOnComplete = () async {
      _scrollControllerC.addListener(() {
        if (_pageC < (lastPageC!.toInt())) {
          if (_scrollControllerC.position.pixels ==
              _scrollControllerC.position.maxScrollExtent) {
            EasyLoading.show(status: "loading please wait...");
            presenter.getDataComplete(++_pageC);
            refreshUI();
          }
        }
      });
      EasyLoading.dismiss();
      print("trip on complete");
    };

    /**/
    presenter.updateTripStatusOnNext = (res) {
      print("trip update status on next");
    };
    presenter.updateTripStatusOnComplete = () {
      print("trip update status on complete");
    };
    presenter.updateTripStatusOnError = (e) {
      print("trip update status on error: ${e.toString()}");
    };

    /**/
    refreshUI();
  }

  void navigate({
    required String? bookingId,
    String? destination,
    String? source,
    double? fromLatitude,
    double? fromLongitude,
    double? toLatitude,
    double? toLongitude,
    String? status,
  }) {
    print("====================================");

    if (status != "completed") {
      Navigator.pushReplacementNamed(getContext(), NavigateView.routeName,
          arguments: {
            'destination': destination,
            'source': source,
            'bookingId': bookingId,
            'fromLatitude': fromLatitude,
            'fromLongitude': fromLongitude,
            'toLatitude': toLatitude,
            'toLongitude': toLongitude,
            'status': status,
          });
    }
    if (status == "Yet to Start") {
      presenter.updateStatus(bookingId!, 3);
    }
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
