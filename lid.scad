



include <./lib/color-mask.scad>;
include <./lib/parts.scad>;
include <./vendor/Round-Anything/polyround.scad>;

module _lid() { side(flip = true, tolerance = TOLERANCE); }

module _masked_lid(current_color) {

  intersection() {
    _lid();
    colorCurrent(current_color = current_color,
                 dims =
                     [ OUTER_BOX_DIMS.x, OUTER_BOX_DIMS.y, OUTER_BOX_DIMS.z ],
                 ring_thickness = COLOR_RING_THICKNESS);
  }
}

module lid(current_color) {
  colors = [ "white", "blue" ];
  for (i = [1:2]) {
    if (current_color == i || current_color == 0) {
      color(colors[i - 1]) _masked_lid(current_color = i);
    }
  }
}