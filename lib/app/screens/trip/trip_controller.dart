import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:wtp_app/app/screens/trip/trip_presenter.dart';

import '../../../domain/entities/trip.dart';
import '../../utils/constant.dart';
import '../navigate/navigate_view.dart';

enum LoadingMoreStatus { loading, stable }

class TripController extends Controller {
  final TripPresenter presenter;

  List<Trip>? _trip;
  List<Trip>? get trip => _trip;

  int? _lastPage;
  int? get lastPage => _lastPage;
  int _page = 0;
  final ScrollController _scrollController = ScrollController();
  ScrollController? get scrollController => _scrollController;
  TripController(tripRepository, repository)
      : presenter = TripPresenter(tripRepository);

  Future refresh() async {
    _page = 0;
    presenter.getData(++_page);
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
      print("trip on error ${e.toString()}");
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

    /**/
  }

  void navigate({
    String? destination,
    String? source,
    double? fromLatitude,
    double? fromLongitude,
    double? toLatitude,
    double? toLongitude,
  }) {
    Navigator.pushReplacementNamed(getContext(), NavigateView.routeName,
        arguments: {
          'destination': destination,
          'source': source,
          'fromLatitude': fromLatitude,
          'fromLongitude': fromLongitude,
          'toLatitude': toLatitude,
          'toLongitude': toLongitude,
        });
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }
}
