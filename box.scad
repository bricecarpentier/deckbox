include <./lib/color-mask.scad>;
include <./lib/parts.scad>

module _box(areas) {
  module separators() {
    module translated_separator(areas, idx = 0) {
      if (idx < len(areas)) {
        translate([ 0, areas[idx] * CARD_DIMS.z + AREA_SEPARATOR_THICKNESS / 2 ]) {
          separator();
          translate([ 0, AREA_SEPARATOR_THICKNESS / 2 ])
              translated_separator(areas, idx + 1);
        }
      }
    }
    translate([ 0, -INNER_BOX_DIMS.y / 2 ]) translated_separator(areas = areas);
  }

  difference() {
    union() {
      translate([ 0, 0, BOX_THICKNESS * 2 ]) {
        internal();
        separators();
      }
      side(flip = true, tolerance = TOLERANCE);
    }
    translate([ 0, 0, INNER_BOX_DIMS.z + BOX_THICKNESS * 2 ])
        thumb_bit(dims = [ 20, 25, 200 ], radius = 4);
  }
}

module _masked_box(current_color, areas) {
  intersection() {
    _box(areas = areas);
    colorCurrent(current_color = current_color,
                 dims =
                     [ OUTER_BOX_DIMS.x, OUTER_BOX_DIMS.y, OUTER_BOX_DIMS.z ],
                 ring_thickness = COLOR_RING_THICKNESS);
  }
}

module box(current_color, areas) {
  colors = [ "white", "blue", "red" ];
  for (i = [1:3]) {
    if (current_color == i || current_color == 0) {
      color(colors[i - 1]) _masked_box(current_color = i, areas = areas);
    }
  }
}