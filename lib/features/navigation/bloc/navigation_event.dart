sealed class NavigationEvent {
  const NavigationEvent();
}

class NavigationIndexUpdated extends NavigationEvent {
  const NavigationIndexUpdated(this.index);
  final int index;
}
