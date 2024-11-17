const breakpoints = [
  768,
  1024,
];

const maxWidth = 1000.0;

/// Returns the number of breakpoints that the provided
/// [width] exceeds.
int widthToView(double width) {
  return breakpoints.where((b) => b <= width).length;
}
