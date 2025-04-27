include <./box.scad>;
include <./lid.scad>;

/* [General] */
// Can be a number between 0 and 2, 0 means "all", 1 means "box", 2 means "lid"
PART = 0;
// Can be a number between 0 and 3, 0 means "all"
COLOR = 0; // 1

/* [Card dimensions] */

// The dimensions of the card, including sleeves
CARD_DIMS = [ 66.5, 93.4, .75 ]; // [.1, .1, .01]

/* [Box dimensions] */

// Number of cards you want to fit in the box
CARD_COUNT = 60; // [10:100]

// The thickness of the box
BOX_THICKNESS = 2; // .5

// Radius of the box's corners
BOX_RADIUS = 2; // 1

/* [Color dimensions] */
COLOR_RING_THICKNESS = 10; // 2

/* [Printer settings] */

// Tolerance of the printer
TOLERANCE = 0.1; // .01

/* [Debug] */
fn = 60;
$fn = fn;


INNER_BOX_DIMS = [ CARD_DIMS.x, CARD_DIMS.z * CARD_COUNT, CARD_DIMS.y ];
OUTER_BOX_DIMS = [
  INNER_BOX_DIMS.x + 4 * BOX_THICKNESS, INNER_BOX_DIMS.y + 4 * BOX_THICKNESS,
  INNER_BOX_DIMS.z + 4 *
  BOX_THICKNESS
];

module scene() {
  lid_x_offset = PART == 0 ? OUTER_BOX_DIMS.x + 20 : 0;
  union() {
    if (PART == 0 || PART == 1)
      box(current_color = COLOR);
    if (PART == 0 || PART == 2)
      translate([ lid_x_offset, 0, 0 ]) lid(current_color = COLOR);
  }
}

scene();