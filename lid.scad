



include <./lib/color-mask.scad>;
include <./lib/parts.scad>;
include <./vendor/Round-Anything/polyround.scad>;

module _lid() { side(flip = true, tolerance = TOLERANCE); }

module lid() {
  intersection() {
    _lid();
    colorCurrent(current_color = COLOR,
                 dims =
                     [ OUTER_BOX_DIMS.x, OUTER_BOX_DIMS.y, OUTER_BOX_DIMS.z ],
                 ring_thickness = COLOR_RING_THICKNESS);
  }
}