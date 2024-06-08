sealed class NavigationState {
  const NavigationState(this.currentIndex);
  final int currentIndex;
}

class NavigationInitial extends NavigationState {
  const NavigationInitial() : super(0);
}

class NavigationUpdateIndex extends NavigationState {
  const NavigationUpdateIndex(super.currentIndex);

  @override
  String toString() {
    return 'NavigationUpdateIndex { currentIndex: $currentIndex }';
  }
}
