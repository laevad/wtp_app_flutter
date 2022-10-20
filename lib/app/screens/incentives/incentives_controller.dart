import 'package:flutter/cupertino.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../../../data/repository/incentive/data_incentive_repository.dart';
import '../../../domain/entities/incentive.dart';
import '../../utils/constant.dart';
import 'incentives_presenter.dart';

class IncentivesController extends Controller {
  final IncentivePresenter presenter;

  List<Incentive>? _incentive;
  int? _lastPage;
  int? get lastPage => _lastPage;
  int _page = 0;
  /* */
  final ScrollController _scrollController = ScrollController();
  /* static ~ total amount */
  double _amount = 0;

  ScrollController? get scrollController => _scrollController;
  List<Incentive>? get incentive => _incentive;
  double get amount => _amount;

  IncentivesController(DataIncentiveRepository repository)
      : presenter = IncentivePresenter(repository);

  @override
  void initListeners() {
    Constant.configLoading();
    if (_page == 0) {
      print(_page);
      EasyLoading.show(status: 'loading please wait...');
      presenter.getIncentive(++_page);
      refreshUI();
    }

    /* */
    presenter.getIncentiveOnNext = (IncentiveModel incentive) {
      if (incentive.incentive != null) {
        for (var i = 0; i < incentive.incentive!.length; i++) {
          _amount = amount + (incentive.incentive![i].amount as double);
        }
      }
      if (_incentive == null) {
        EasyLoading.show(status: "loading please wait...");
      }
      if (_page == 1) {
        _incentive = incentive.incentive!;
      } else {
        _incentive = _incentive! + incentive.incentive!;
      }
      _lastPage = incentive.lastPage;
      print("incentive on next");
      refreshUI();
    };
    presenter.getIncentiveOnError = (e) {
      print("Incentive on Error: ${e.toString()}");
      EasyLoading.dismiss();
    };
    presenter.getIncentiveOnComplete = () async {
      _scrollController.addListener(() {
        if (_page < (lastPage!.toInt())) {
          if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent) {
            EasyLoading.show(status: "loading please wait...");
            presenter.getIncentive(++_page);
            refreshUI();
          }
        }
      });
      EasyLoading.dismiss();
      print("trip on complete");
    };
  }

  @override
  void onDisposed() {
    presenter.dispose();
    super.onDisposed();
  }

  Future refresh() async {
    _page = 0;
    presenter.getIncentive(++_page);
  }
}
