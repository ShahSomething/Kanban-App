import 'package:animations/animations.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kanban/core/constants/app_assets.dart';
import 'package:kanban/core/extensions/context.dart';
import 'package:kanban/features/board/presentation/view/board_page.dart';
import 'package:kanban/features/navigation/bloc/navigation_bloc.dart';
import 'package:kanban/features/navigation/bloc/navigation_event.dart';
import 'package:kanban/features/navigation/bloc/navigation_state.dart';
import 'package:kanban/l10n/l10n.dart';

class NavigationPage extends StatelessWidget {
  const NavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: const NavigationView(),
    );
  }
}

class NavigationView extends StatelessWidget {
  const NavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            foregroundColor: context.secondaryColor,
            onPressed: () {
              //context.read<NavigationBloc>().add(NavigationIndexUpdated(1));
            },
            label: Text(l10n.addTask),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          body: PageTransitionSwitcher(
            transitionBuilder: (child, primaryAnimation, secondaryAnimation) {
              return FadeThroughTransition(
                animation: primaryAnimation,
                secondaryAnimation: secondaryAnimation,
                child: child,
              );
            },
            child: getViewForIndex(state.currentIndex),
          ),
          extendBody: true,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.r),
              topRight: Radius.circular(30.r),
            ),
            child: BottomNavigationBar(
              currentIndex: state.currentIndex,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              onTap: (index) {
                context
                    .read<NavigationBloc>()
                    .add(NavigationIndexUpdated(index));
              },
              items: [
                _bottomNavItem(
                  iconPath: SvgAssets.kanban,
                  label: l10n.board,
                  context: context,
                ),
                _bottomNavItem(
                  iconPath: SvgAssets.history2,
                  label: l10n.history,
                  context: context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  BottomNavigationBarItem _bottomNavItem({
    required String iconPath,
    required String label,
    required BuildContext context,
  }) {
    Widget getIcon({bool isActive = false}) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 24.r,
            width: 24.r,
            colorFilter: ColorFilter.mode(
              isActive ? context.primaryColor : context.onPrimary,
              BlendMode.srcIn,
            ),
          ),
          // 10.verticalSpace,
          Text(
            label,
            style: context.label12500.copyWith(
              color: isActive ? context.primaryColor : context.onPrimary,
            ),
          ),
        ],
      );
    }

    return BottomNavigationBarItem(
      icon: getIcon(),
      activeIcon: getIcon(isActive: true),
      label: label,
    );
  }

  Widget getViewForIndex(int index) {
    switch (index) {
      case 0:
        return const BoardPage();
      case 1:
        return const ColoredBox(
          color: Colors.red,
          child: Center(
            child: Text('History'),
          ),
        );

      default:
        return const SizedBox();
    }
  }
}
