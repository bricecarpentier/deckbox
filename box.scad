include <./lib/color-mask.scad>;
include <./lib/parts.scad>
include <./vendor/Round-Anything/polyround.scad>;

module _box() {
  difference() {
    union() {
      translate([ 0, 0, BOX_THICKNESS * 2 ]) internal();
      side(flip = true, tolerance = TOLERANCE);
    }
    translate([ 0, 0, INNER_BOX_DIMS.z + BOX_THICKNESS * 2 ])
        thumb_bit(dims = [ 20, 25, 200 ], radius = 4);
  }
}

module _masked_box(current_color) {
  intersection() {
    _box();
    colorCurrent(current_color = current_color,
                 dims =
                     [ OUTER_BOX_DIMS.x, OUTER_BOX_DIMS.y, OUTER_BOX_DIMS.z ],
                 ring_thickness = COLOR_RING_THICKNESS);
  }
}

module box(current_color) {
  colors = [ "white", "blue", "red" ];
  for (i = [1:3]) {
    if (current_color == i || current_color == 0) {
      color(colors[i - 1]) _masked_box(current_color = i);
    }
  }
}