import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/route_manager.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:late_init/late_init.dart';
import 'package:parking_people_flutter/gen/colors.gen.dart';
import 'package:parking_people_flutter/utils/extensions/safe_state.dart';
import 'package:parking_people_flutter/views/components/go_back_button.dart';
import 'package:xcontext/xcontext.dart';

///
class CommonScaffold extends StatefulWidget {
  /// Default constructor
  const CommonScaffold({
    required this.body,
    this.centerBody = false,
    this.title = '',
    this.backgroundColor = ColorName.lighterGrey,
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
                style: TextStyle(
                  color: context.theme.textTheme.bodyText2?.color,
                  fontWeight: FontWeight.w500,
                  fontSize: 24,
                ),
              ),
              leading:
                  shouldHideBackButton ? Container() : const GoBackButton(),
              leadingWidth: shouldHideBackButton ? 0 : 72,
              backgroundColor: widget.backgroundColor,
              foregroundColor: context.theme.textTheme.bodyText2?.color,
              toolbarHeight: 72,
              elevation: _isScrolling ? 4 : 0,
              shadowColor:
                  context.theme.textTheme.bodyText2?.color?.withOpacity(0.2),
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
              },
            ),
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
