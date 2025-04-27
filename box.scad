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

module box() {
  intersection() {
    _box();
    colorCurrent(current_color = COLOR,
                 dims =
                     [ OUTER_BOX_DIMS.x, OUTER_BOX_DIMS.y, OUTER_BOX_DIMS.z ],
                 ring_thickness = COLOR_RING_THICKNESS);
  }
}