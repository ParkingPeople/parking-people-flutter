import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/route_manager.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:late_init/late_init.dart';
import 'package:parking_people_flutter/constants/custom_colors.dart';
import 'package:parking_people_flutter/views/components/go_back_button.dart';
import 'package:parking_people_flutter/utils/extensions/safe_state.dart';
import 'package:state_persistence/state_persistence.dart';

///
class CommonScaffold extends StatefulWidget {
  /// Default constructor
  const CommonScaffold({
    required this.body,
    this.centerBody = false,
    this.title = '',
    this.backgroundColor = CustomColors.white,
    this.hideBackButton = false,
    this.actions,
    this.drawerBuilder,
    this.stickyBuilder,
    this.scrollController,
    this.onSnapshotChanged,
    Key? key,
  }) : super(key: key);

  /// Body
  final Widget body;

  /// Whether to center body content
  final bool centerBody;

  /// Title string
  final String title;

  /// Background color
  final Color backgroundColor;

  /// Whether to hide back button on home screen
  final bool hideBackButton;

  final List<Widget>? actions;

  final Function? drawerBuilder;

  final Widget Function(BuildContext context, bool isKeyboardVisible)?
      stickyBuilder;

  final ScrollController? scrollController;

  final ValueChanged<AsyncSnapshot>? onSnapshotChanged;

  @override
  State<StatefulWidget> createState() => CommonScaffoldState();
}

class CommonScaffoldState extends SafeState<CommonScaffold>
    with LateInitMixin<CommonScaffold> {
  late BuildContext currentScaffoldContext;

  @override
  Widget build(BuildContext context) {
    final bool shouldHideBackButton =
        widget.hideBackButton || !navigator!.canPop();

    return KeyboardDismisser(
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          if (!isKeyboardVisible) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _onScroll();
            });
          }
          final child = widget.stickyBuilder == null
              ? widget.body
              : LayoutBuilder(
                  builder: (
                    BuildContext context,
                    BoxConstraints viewportConstraints,
                  ) =>
                      SingleChildScrollView(
                    controller: _scrollController,
                    physics: isKeyboardVisible
                        ? const BouncingScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: widget.body,
                    ),
                  ),
                );

          return Scaffold(
            appBar: AppBar(
              title: Text(
                widget.title,
                style: const TextStyle(
                  color: CustomColors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              leading:
                  shouldHideBackButton ? Container() : const GoBackButton(),
              leadingWidth: shouldHideBackButton ? 0 : 72,
              backgroundColor: widget.backgroundColor,
              foregroundColor: CustomColors.grey,
              toolbarHeight: 72,
              elevation: _isScrolling ? 4 : 0,
              shadowColor: CustomColors.grey.withOpacity(0.2),
              centerTitle: true,
              systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
                statusBarColor: Colors.black,
              ),
              actions: widget.actions ?? [],
            ),

            bottomSheet: widget.stickyBuilder != null && isKeyboardVisible
                ? SafeArea(
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: widget.stickyBuilder!(context, true),
                    ),
                  )
                : null,
            // resizeToAvoidBottomInset: keyboardStickyChild == null,
            body: Builder(
              builder: (context) {
                currentScaffoldContext = context;

                return PersistedStateBuilder(
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    widget.onSnapshotChanged?.call(snapshot);

                    if (snapshot.hasData) {
                      return Container(
                        color: widget.backgroundColor,
                        child: SafeArea(
                          minimum: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Expanded(
                                child: widget.centerBody
                                    ? Center(
                                        child: child,
                                      )
                                    : child,
                              ),
                              if (widget.stickyBuilder != null)
                                widget.stickyBuilder!(
                                  context,
                                  isKeyboardVisible,
                                ),
                            ],
                          ),
                        ),
                      );
                    }

                    return const CircularProgressIndicator.adaptive();
                  },
                );
              },
            ),
            // endDrawer: widget.drawerBuilder == null
            //     ? null
            //     : Builder(
            //         // ignore: unnecessary_lambdas, avoid_dynamic_calls
            //         builder: (context) => widget.drawerBuilder!(context),
            //       ),
            // drawerScrimColor: CustomColors.darkGrey.withOpacity(0.2),
          );
        },
      ),
    );
  }

  bool _isScrolling = false;

  late final ScrollController _scrollController;

  void _onScroll() {
    if (_scrollController.hasClients) {
      final top = _scrollController.position.minScrollExtent;
      final curr = _scrollController.offset;
      final dist = curr - top;
      if (dist > 9 && !_isScrolling) {
        setState(() {
          _isScrolling = true;
        });
      }
      if (dist < 9 && _isScrolling) {
        setState(() {
          _isScrolling = false;
        });
      }
    }
  }

  @override
  void lateInitState() {
    _scrollController = widget.scrollController ?? ScrollController();

    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
