import 'package:flutter/material.dart';

class ModelFutureBuilder<T> extends StatelessWidget {
  const ModelFutureBuilder({
    Key? key,
    required this.busy,
    required this.data,
    required this.builder,
    this.onError,
    this.loading,
    this.onRefresh,
    this.errorText,
    this.errorTextStyle,
  }) : super(key: key);

  final bool busy;
  final T? data;
  final WidgetBuilder? onError;
  final RefreshCallback? onRefresh;
  final String? errorText;
  final TextStyle? errorTextStyle;
  final Widget? loading;
  final ValueWidgetBuilder<T> builder;

  @override
  Widget build(BuildContext context) {
    if (busy) {
      return loading ?? const Center(child: CustomLoader());
    } else {
      if (data == null) {
        return onError != null
            ? onError!(context)
            : ModelErrorWidget(
                onRefresh: onRefresh,
                errorText: errorText ?? 'Something went wrong',
                textStyle: errorTextStyle,
              );
      } else {
        return onRefresh != null
            ? RefreshIndicator(
                onRefresh: onRefresh!,
                child: builder(context, data as T, null),
              )
            : builder(context, data as T, null);
      }
    }
  }
}
