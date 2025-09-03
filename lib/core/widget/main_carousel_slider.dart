import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as flutter_material;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainCarouselSlider extends StatefulWidget {
  final CarouselOptions options;

  final bool? disableGesture;

  final List<Widget>? items;

  final ExtendedIndexedWidgetBuilder? itemBuilder;

  final CarouselControllerImpl _carouselController;

  final int? itemCount;

  MainCarouselSlider({
    required this.items,
    required this.options,
    this.disableGesture,
    CarouselControllerSlider? carouselController,
    super.key,
  })  : itemBuilder = null,
        itemCount = items != null ? items.length : 0,
        _carouselController = carouselController != null
            ? carouselController as CarouselControllerImpl
            : CarouselControllerSlider() as CarouselControllerImpl;

  MainCarouselSlider.builder({
    required this.itemCount,
    required this.itemBuilder,
    required this.options,
    this.disableGesture,
    CarouselControllerSlider? carouselController,
    super.key,
  })  : items = null,
        _carouselController = carouselController != null
            ? carouselController as CarouselControllerImpl
            : CarouselControllerSlider() as CarouselControllerImpl;

  @override
  MainCarouselSliderState createState() {
    // ignore: no_logic_in_create_state
    return MainCarouselSliderState(_carouselController);
  }
}

class MainCarouselSliderState extends State<MainCarouselSlider>
    with TickerProviderStateMixin {
  final CarouselControllerImpl carouselController;
  Timer? timer;

  CarouselOptions get options => widget.options;

  CarouselState? carouselState;

  PageController? pageController;

  CarouselPageChangedReason mode = CarouselPageChangedReason.controller;

  MainCarouselSliderState(this.carouselController);

  void changeMode(CarouselPageChangedReason myMode) {
    mode = myMode;
  }

  @override
  void didUpdateWidget(MainCarouselSlider oldWidget) {
    carouselState!.options = options;
    carouselState!.itemCount = widget.itemCount;

    pageController = PageController(
      viewportFraction: options.viewportFraction,
      initialPage: carouselState!.realPage,
    );
    carouselState!.pageController = pageController;

    handleAutoPlay();

    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
    carouselState = CarouselState(options, clearTimer, resumeTimer, changeMode);

    carouselState!.itemCount = widget.itemCount;
    carouselController.state = carouselState;
    carouselState!.initialPage = widget.options.initialPage;
    carouselState!.realPage = options.enableInfiniteScroll
        ? carouselState!.realPage + carouselState!.initialPage
        : carouselState!.initialPage;
    handleAutoPlay();

    pageController = PageController(
      viewportFraction: options.viewportFraction,
      initialPage: carouselState!.realPage,
    );

    carouselState!.pageController = pageController;
  }

  Timer? getTimer() {
    return widget.options.autoPlay
        ? Timer.periodic(widget.options.autoPlayInterval, (_) {
            if (!mounted) {
              clearTimer();
              return;
            }

            final route = ModalRoute.of(context);
            if (route?.isCurrent == false) {
              return;
            }

            CarouselPageChangedReason previousReason = mode;
            changeMode(CarouselPageChangedReason.timed);
            int nextPage = carouselState!.pageController!.page!.round() + 1;
            int itemCount = widget.itemCount ?? widget.items!.length;

            if (nextPage >= itemCount &&
                widget.options.enableInfiniteScroll == false) {
              if (widget.options.pauseAutoPlayInFiniteScroll) {
                clearTimer();
                return;
              }
              nextPage = 0;
            }

            carouselState!.pageController!
                .animateToPage(nextPage,
                    duration: widget.options.autoPlayAnimationDuration,
                    curve: widget.options.autoPlayCurve)
                .then((_) => changeMode(previousReason));
          })
        : null;
  }

  void clearTimer() {
    if (timer != null) {
      timer?.cancel();
      timer = null;
    }
  }

  void resumeTimer() {
    timer ??= getTimer();
  }

  void handleAutoPlay() {
    bool autoPlayEnabled = widget.options.autoPlay;

    if (autoPlayEnabled && timer != null) return;

    clearTimer();
    if (autoPlayEnabled) {
      resumeTimer();
    }
  }

  Widget getGestureWrapper(Widget child) {
    Widget wrapper;
    if (widget.options.height != null) {
      wrapper = SizedBox(height: widget.options.height, child: child);
    } else {
      wrapper =
          AspectRatio(aspectRatio: widget.options.aspectRatio, child: child);
    }

    if (true == widget.disableGesture) {
      return NotificationListener(
        onNotification: (Notification notification) {
          if (widget.options.onScrolled != null &&
              notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(carouselState!.pageController!.page);
          }
          return false;
        },
        child: wrapper,
      );
    }

    return RawGestureDetector(
      behavior: HitTestBehavior.opaque,
      gestures: {
        _MultipleGestureRecognizer:
            GestureRecognizerFactoryWithHandlers<_MultipleGestureRecognizer>(
                () => _MultipleGestureRecognizer(),
                (_MultipleGestureRecognizer instance) {
          instance.onStart = (_) {
            onStart();
          };
          instance.onDown = (_) {
            onPanDown();
          };
          instance.onEnd = (_) {
            onPanUp();
          };
          instance.onCancel = () {
            onPanUp();
          };
        }),
      },
      child: NotificationListener(
        onNotification: (Notification notification) {
          if (widget.options.onScrolled != null &&
              notification is ScrollUpdateNotification) {
            widget.options.onScrolled!(carouselState!.pageController!.page);
          }
          return false;
        },
        child: wrapper,
      ),
    );
  }

  Widget getCenterWrapper(Widget child) {
    if (widget.options.disableCenter) {
      return Container(
        child: child,
      );
    }
    return Center(child: child);
  }

  Widget getEnlargeWrapper(Widget? child,
      {double? width,
      double? height,
      double? scale,
      required double itemOffset}) {
    if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.height) {
      return SizedBox(width: width, height: height, child: child);
    }
    if (widget.options.enlargeStrategy == CenterPageEnlargeStrategy.zoom) {
      late Alignment alignment;
      final bool horizontal = options.scrollDirection == Axis.horizontal;
      if (itemOffset > 0) {
        alignment = horizontal ? Alignment.centerRight : Alignment.bottomCenter;
      } else {
        alignment = horizontal ? Alignment.centerLeft : Alignment.topCenter;
      }
      return Transform.scale(scale: scale!, alignment: alignment, child: child);
    }
    return Transform.scale(
        scale: scale!,
        child: SizedBox(width: width, height: height, child: child));
  }

  void onStart() {
    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanDown() {
    if (widget.options.pauseAutoPlayOnTouch) {
      clearTimer();
    }

    changeMode(CarouselPageChangedReason.manual);
  }

  void onPanUp() {
    if (widget.options.pauseAutoPlayOnTouch) {
      resumeTimer();
    }
  }

  @override
  void dispose() {
    super.dispose();
    clearTimer();
  }

  @override
  Widget build(BuildContext context) {
    return getGestureWrapper(
      PageView.builder(
        padEnds: widget.options.padEnds,
        scrollBehavior: ScrollConfiguration.of(context).copyWith(
          scrollbars: false,
          overscroll: false,
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
        clipBehavior: widget.options.clipBehavior,
        physics: widget.options.scrollPhysics,
        scrollDirection: widget.options.scrollDirection,
        pageSnapping: widget.options.pageSnapping,
        controller: carouselState!.pageController,
        reverse: widget.options.reverse,
        itemCount:
            widget.options.enableInfiniteScroll ? null : widget.itemCount,
        key: widget.options.pageViewKey,
        onPageChanged: (int index) {
          int currentPage = getRealIndex(index + carouselState!.initialPage,
              carouselState!.realPage, widget.itemCount);
          if (widget.options.onPageChanged != null) {
            widget.options.onPageChanged!(currentPage, mode);
          }
        },
        itemBuilder: (BuildContext context, int idx) {
          final int index = getRealIndex(idx + carouselState!.initialPage,
              carouselState!.realPage, widget.itemCount);

          return AnimatedBuilder(
            animation: carouselState!.pageController!,
            child: (widget.items != null)
                ? (widget.items!.isNotEmpty
                    ? widget.items![index]
                    : Container())
                : widget.itemBuilder!(context, index, idx),
            builder: (BuildContext context, child) {
              double distortionValue = 1.0;
              double itemOffset = 0;
              if (widget.options.enlargeCenterPage != null &&
                  widget.options.enlargeCenterPage == true) {
                var position = carouselState?.pageController?.position;
                if (position != null &&
                    position.hasPixels &&
                    position.hasContentDimensions) {
                  var page = carouselState?.pageController?.page;
                  if (page != null) {
                    itemOffset = page - idx;
                  }
                } else {
                  BuildContext storageContext = carouselState!
                      .pageController!.position.context.storageContext;
                  final double? previousSavedPosition =
                      PageStorage.of(storageContext).readState(storageContext)
                          as double?;
                  if (previousSavedPosition != null) {
                    itemOffset = previousSavedPosition - idx.toDouble();
                  } else {
                    itemOffset =
                        carouselState!.realPage.toDouble() - idx.toDouble();
                  }
                }

                final double enlargeFactor =
                    options.enlargeFactor.clamp(0.0, 1.0);
                final num distortionRatio =
                    (1 - (itemOffset.abs() * enlargeFactor)).clamp(0.0, 1.0);
                distortionValue =
                    Curves.easeOut.transform(distortionRatio as double);
              }

              final double height = widget.options.height ??
                  MediaQuery.of(context).size.width *
                      (1 / widget.options.aspectRatio);

              if (widget.options.scrollDirection == Axis.horizontal) {
                return getCenterWrapper(getEnlargeWrapper(child,
                    height: distortionValue * height,
                    scale: distortionValue,
                    itemOffset: itemOffset));
              } else {
                return getCenterWrapper(getEnlargeWrapper(child,
                    width: distortionValue * MediaQuery.of(context).size.width,
                    scale: distortionValue,
                    itemOffset: itemOffset));
              }
            },
          );
        },
      ),
    );
  }
}

class _MultipleGestureRecognizer extends PanGestureRecognizer {}

int getRealIndex(int position, int base, int? length) {
  final int offset = position - base;
  return remainder(offset, length);
}

int remainder(int input, int? source) {
  if (source == 0) return 0;
  final int result = input % source!;
  return result < 0 ? source + result : result;
}

class CarouselState {
  CarouselOptions options;
  PageController? pageController;
  int realPage = 10000;
  int initialPage = 0;
  int? itemCount;
  Function onResetTimer;
  Function onResumeTimer;
  Function(CarouselPageChangedReason) changeMode;

  CarouselState(
    this.options,
    this.onResetTimer,
    this.onResumeTimer,
    this.changeMode,
  );
}

typedef ExtendedIndexedWidgetBuilder = Widget Function(
  BuildContext context,
  int index,
  int realIndex,
);

enum CarouselPageChangedReason { timed, manual, controller }

enum CenterPageEnlargeStrategy { scale, height, zoom }

class CarouselOptions {
  final double? height;

  final double aspectRatio;

  final double viewportFraction;

  final int initialPage;

  final bool enableInfiniteScroll;

  final bool animateToClosest;

  final bool reverse;

  final bool autoPlay;

  final Duration autoPlayInterval;

  final Duration autoPlayAnimationDuration;

  final flutter_material.Curve autoPlayCurve;

  final bool? enlargeCenterPage;

  final flutter_material.Axis scrollDirection;

  final Function(int index, CarouselPageChangedReason reason)? onPageChanged;

  final flutter_material.ValueChanged<double?>? onScrolled;

  final flutter_material.ScrollPhysics? scrollPhysics;

  final bool pageSnapping;

  final bool pauseAutoPlayOnTouch;

  final bool pauseAutoPlayOnManualNavigate;

  final bool pauseAutoPlayInFiniteScroll;

  final flutter_material.PageStorageKey? pageViewKey;

  final CenterPageEnlargeStrategy enlargeStrategy;

  final double enlargeFactor;

  final bool disableCenter;

  final bool padEnds;

  final flutter_material.Clip clipBehavior;

  CarouselOptions({
    this.height,
    this.aspectRatio = 16 / 9,
    this.viewportFraction = 0.8,
    this.initialPage = 0,
    this.enableInfiniteScroll = true,
    this.animateToClosest = true,
    this.reverse = false,
    this.autoPlay = false,
    this.autoPlayInterval = const Duration(seconds: 4),
    this.autoPlayAnimationDuration = const Duration(milliseconds: 800),
    this.autoPlayCurve = flutter_material.Curves.fastOutSlowIn,
    this.enlargeCenterPage = false,
    this.onPageChanged,
    this.onScrolled,
    this.scrollPhysics,
    this.pageSnapping = true,
    this.scrollDirection = flutter_material.Axis.horizontal,
    this.pauseAutoPlayOnTouch = true,
    this.pauseAutoPlayOnManualNavigate = true,
    this.pauseAutoPlayInFiniteScroll = false,
    this.pageViewKey,
    this.enlargeStrategy = CenterPageEnlargeStrategy.scale,
    this.enlargeFactor = 0.3,
    this.disableCenter = false,
    this.padEnds = true,
    this.clipBehavior = flutter_material.Clip.hardEdge,
  });

  CarouselOptions copyWith(
          {double? height,
          double? aspectRatio,
          double? viewportFraction,
          int? initialPage,
          bool? enableInfiniteScroll,
          bool? reverse,
          bool? autoPlay,
          Duration? autoPlayInterval,
          Duration? autoPlayAnimationDuration,
          flutter_material.Curve? autoPlayCurve,
          bool? enlargeCenterPage,
          Function(int index, CarouselPageChangedReason reason)? onPageChanged,
          flutter_material.ValueChanged<double?>? onScrolled,
          flutter_material.ScrollPhysics? scrollPhysics,
          bool? pageSnapping,
          flutter_material.Axis? scrollDirection,
          bool? pauseAutoPlayOnTouch,
          bool? pauseAutoPlayOnManualNavigate,
          bool? pauseAutoPlayInFiniteScroll,
          flutter_material.PageStorageKey? pageViewKey,
          CenterPageEnlargeStrategy? enlargeStrategy,
          double? enlargeFactor,
          bool? disableCenter,
          flutter_material.Clip? clipBehavior,
          bool? padEnds}) =>
      CarouselOptions(
        height: height ?? this.height,
        aspectRatio: aspectRatio ?? this.aspectRatio,
        viewportFraction: viewportFraction ?? this.viewportFraction,
        initialPage: initialPage ?? this.initialPage,
        enableInfiniteScroll: enableInfiniteScroll ?? this.enableInfiniteScroll,
        reverse: reverse ?? this.reverse,
        autoPlay: autoPlay ?? this.autoPlay,
        autoPlayInterval: autoPlayInterval ?? this.autoPlayInterval,
        autoPlayAnimationDuration:
            autoPlayAnimationDuration ?? this.autoPlayAnimationDuration,
        autoPlayCurve: autoPlayCurve ?? this.autoPlayCurve,
        enlargeCenterPage: enlargeCenterPage ?? this.enlargeCenterPage,
        onPageChanged: onPageChanged ?? this.onPageChanged,
        onScrolled: onScrolled ?? this.onScrolled,
        scrollPhysics: scrollPhysics ?? this.scrollPhysics,
        pageSnapping: pageSnapping ?? this.pageSnapping,
        scrollDirection: scrollDirection ?? this.scrollDirection,
        pauseAutoPlayOnTouch: pauseAutoPlayOnTouch ?? this.pauseAutoPlayOnTouch,
        pauseAutoPlayOnManualNavigate:
            pauseAutoPlayOnManualNavigate ?? this.pauseAutoPlayOnManualNavigate,
        pauseAutoPlayInFiniteScroll:
            pauseAutoPlayInFiniteScroll ?? this.pauseAutoPlayInFiniteScroll,
        pageViewKey: pageViewKey ?? this.pageViewKey,
        enlargeStrategy: enlargeStrategy ?? this.enlargeStrategy,
        enlargeFactor: enlargeFactor ?? this.enlargeFactor,
        disableCenter: disableCenter ?? this.disableCenter,
        clipBehavior: clipBehavior ?? this.clipBehavior,
        padEnds: padEnds ?? this.padEnds,
      );
}

abstract class CarouselControllerSlider {
  bool get ready;

  Future<Null> get onReady;

  Future<void> nextPage({Duration? duration, Curve? curve});

  Future<void> previousPage({Duration? duration, Curve? curve});

  void jumpToPage(int page);

  Future<void> animateToPage(int page, {Duration? duration, Curve? curve});

  void startAutoPlay();

  void stopAutoPlay();

  factory CarouselControllerSlider() => CarouselControllerImpl();
}

class CarouselControllerImpl implements CarouselControllerSlider {
  final Completer<Null> _readyCompleter = Completer<Null>();

  CarouselState? _state;

  set state(CarouselState? state) {
    _state = state;
    if (!_readyCompleter.isCompleted) {
      _readyCompleter.complete();
    }
  }

  void _setModeController() =>
      _state!.changeMode(CarouselPageChangedReason.controller);

  @override
  bool get ready => _state != null;

  @override
  Future<Null> get onReady => _readyCompleter.future;

  @override
  Future<void> nextPage(
      {Duration? duration = const Duration(milliseconds: 300),
      Curve? curve = Curves.linear}) async {
    final bool isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    _setModeController();
    await _state!.pageController!.nextPage(duration: duration!, curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  @override
  Future<void> previousPage(
      {Duration? duration = const Duration(milliseconds: 300),
      Curve? curve = Curves.linear}) async {
    final bool isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    _setModeController();
    await _state!.pageController!
        .previousPage(duration: duration!, curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  @override
  void jumpToPage(int page) {
    final index = getRealIndex(_state!.pageController!.page!.toInt(),
        _state!.realPage - _state!.initialPage, _state!.itemCount);

    _setModeController();
    final int pageToJump = _state!.pageController!.page!.toInt() + page - index;
    return _state!.pageController!.jumpToPage(pageToJump);
  }

  @override
  Future<void> animateToPage(int page,
      {Duration? duration = const Duration(milliseconds: 300),
      Curve? curve = Curves.linear}) async {
    final bool isNeedResetTimer = _state!.options.pauseAutoPlayOnManualNavigate;
    if (isNeedResetTimer) {
      _state!.onResetTimer();
    }
    final index = getRealIndex(_state!.pageController!.page!.toInt(),
        _state!.realPage - _state!.initialPage, _state!.itemCount);
    int smallestMovement = page - index;
    if (_state!.options.enableInfiniteScroll &&
        _state!.itemCount != null &&
        _state!.options.animateToClosest) {
      if ((page - index).abs() > (page + _state!.itemCount! - index).abs()) {
        smallestMovement = page + _state!.itemCount! - index;
      } else if ((page - index).abs() >
          (page - _state!.itemCount! - index).abs()) {
        smallestMovement = page - _state!.itemCount! - index;
      }
    }
    _setModeController();
    await _state!.pageController!.animateToPage(
        _state!.pageController!.page!.toInt() + smallestMovement,
        duration: duration!,
        curve: curve!);
    if (isNeedResetTimer) {
      _state!.onResumeTimer();
    }
  }

  @override
  void startAutoPlay() {
    _state!.onResumeTimer();
  }

  @override
  void stopAutoPlay() {
    _state!.onResetTimer();
  }
}
