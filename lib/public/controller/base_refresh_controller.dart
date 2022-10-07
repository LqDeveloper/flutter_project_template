import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/public/controller/base_controller.dart';

abstract class BaseRefreshController<T> extends BaseController {
  /// 分页第一页页码
  static const int pageNumFirst = 0;

  /// 分页条目数量
  static const int pageSize = 20;

  /// 当前页码
  int _currentPageNum = pageNumFirst;

  /// 页面数据
  List<T> list = [];

  late EasyRefreshController refreshController = EasyRefreshController();
  late ScrollController scrollController = ScrollController();

  Future refresh() async {
    try {
      _currentPageNum = pageNumFirst;
      final data = await loadData(pageNumFirst);
      list.clear();
      list.addAll(data);
      refreshCompleted(data);
      notifyListeners();
    } catch (e, s) {
      refreshFailed();
      printErrorStack(e, s);
    }
  }

  Future loadMore() async {
    try {
      _currentPageNum++;
      var data = await loadData(_currentPageNum);
      if (data.isEmpty) {
        _currentPageNum--;
      } else {
        list.addAll(data);
      }
      loadCompleted(data);
      notifyListeners();
    } catch (e, s) {
      _currentPageNum--;
      loadFailed();
      printErrorStack(e, s);
    }
  }

  //根据data的length判断是否可以loadMore
  void refreshCompleted(List<T> data) {
    if (data.isEmpty) {
      refreshController.finishRefresh(IndicatorResult.noMore);
    } else {
      refreshController.finishRefresh(IndicatorResult.success);
    }
  }

  void refreshFailed() {
    refreshController.finishRefresh(IndicatorResult.fail);
  }

  //根据data的length判断是否可以loadMore
  void loadCompleted(List<T> data) {
    if (data.isEmpty) {
      refreshController.finishLoad(IndicatorResult.noMore);
    } else {
      refreshController.finishLoad(IndicatorResult.success);
    }
  }

  void loadFailed() {
    refreshController.finishLoad(IndicatorResult.fail);
  }

  Future<List<T>> loadData(int pageNum);
}
