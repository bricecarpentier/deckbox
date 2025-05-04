include <./box.scad>;
include <./lid.scad>;

/* [General] */
PART = "all"; // [all:Both, box:Just the box, lid: Just the lid]
COLOR = 0;    // [0:Everything, 1:Below the colored ring, 2:The colored ring, 3:Above the colored ring]

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
COLOR_RING_THICKNESS = 5; // 2

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
  lid_x_offset = PART == "all" ? OUTER_BOX_DIMS.x + 20 : 0;
  union() {
    if (PART == "all" || PART == "box")
      box(current_color = COLOR);
    if (PART == "all" || PART == "lid")
      translate([ lid_x_offset, 0, 0 ]) lid(current_color = COLOR);
  }
}

scene();