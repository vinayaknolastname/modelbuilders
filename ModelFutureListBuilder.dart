import 'package:flutter/material.dart';

class ModelFutureListBuilder<T> extends StatelessWidget {
  const ModelFutureListBuilder({
    Key? key,
    required this.busy,
    required this.data,
    required this.builder,
    this.empty,
    this.loading,
    this.onRefresh,
    this.hasRefreshButton = true,
    this.emptyText,
    this.emptyTextStyle,
    this.isTutorial = false,
  }) : super(key: key);

  final bool busy;
  final List<T> data;
  final Widget? empty;
  final Widget? loading;
  final RefreshCallback? onRefresh;
  final bool hasRefreshButton;
  final String? emptyText;
  final TextStyle? emptyTextStyle;
  final ValueWidgetBuilder<List<T>> builder;
  final bool isTutorial;

  @override
  Widget build(BuildContext context) {
    if (isTutorial) {
      return onRefresh != null
          ? RefreshIndicator(
              onRefresh: onRefresh!,
              child: builder(context, data, null),
            )
          : builder(context, data, null);
    }

    if (busy) {
      return loading ?? const Center(child: CustomLoader());
    } else {
      if (data.isEmpty) {
        return empty ??
            ModelErrorWidget(
              onRefresh: hasRefreshButton ? onRefresh : null,
              errorText: emptyText ?? 'List is empty',
              textStyle: emptyTextStyle,
            );
      } else {
        return onRefresh != null
            ? RefreshIndicator(
                onRefresh: onRefresh!,
                child: builder(context, data, null),
              )
            : builder(context, data, null);
      }
    }
  }
}
