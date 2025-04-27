include <./vendor/Round-Anything/polyround.scad>;

// The dimensions of the card, including sleeves
CARD_DIMS = [ 66.5, 93.4, .75 ]; // [.1, .1, .01]

// Number of cards you want to fit in the box
CARD_COUNT = 60; // 1

// The thickness of the box
BOX_THICKNESS = 2; // .5

// Radius of the box's corners
BOX_RADIUS = 2; // 1

// Tolerance of the printer
TOLERANCE = 0.1; // .01

fn = 60;
$fn = fn;

INNER_BOX_DIMS = [ CARD_DIMS.x, CARD_DIMS.z *CARD_COUNT, CARD_DIMS.y ];
OUTER_BOX_DIMS = [
  INNER_BOX_DIMS.x + 4 * BOX_THICKNESS, INNER_BOX_DIMS.y + 4 * BOX_THICKNESS,
  INNER_BOX_DIMS.z + 4 *
  BOX_THICKNESS
];

module side(flip = false, tolerance = 0) {
  points = [
    [ -OUTER_BOX_DIMS.x / 2, -OUTER_BOX_DIMS.y / 2, BOX_RADIUS ],
    [ OUTER_BOX_DIMS.x / 2, -OUTER_BOX_DIMS.y / 2, BOX_RADIUS ],
    [ OUTER_BOX_DIMS.x / 2, OUTER_BOX_DIMS.y / 2, BOX_RADIUS ],
    [ -OUTER_BOX_DIMS.x / 2, OUTER_BOX_DIMS.y / 2, BOX_RADIUS ]
  ];

  lid_extrusion = [
    OUTER_BOX_DIMS.x - 2 * BOX_THICKNESS + tolerance,
    OUTER_BOX_DIMS.y - 2 * BOX_THICKNESS + tolerance, OUTER_BOX_DIMS.z +
    tolerance
  ];

  translate([ 0, 0, OUTER_BOX_DIMS.z / 4 ]) mirror([ 0, 0, flip ? 1 : 0 ])
      translate([ 0, 0, -OUTER_BOX_DIMS.z / 4 ]) difference() {
    polyRoundExtrude(radiiPoints = points, length = OUTER_BOX_DIMS.z / 2,
                     r1 = BOX_RADIUS, r2 = 0, fn = fn, convexity = 10);
    translate([
      -lid_extrusion.x / 2, -lid_extrusion.y / 2,
      -lid_extrusion.z / 2 - BOX_THICKNESS * 2
    ]) #cube([ lid_extrusion.x, lid_extrusion.y, lid_extrusion.z ],
             center = false);
  }
}

module internal() {
  outer_dims = [
    INNER_BOX_DIMS.x + BOX_THICKNESS * 2, INNER_BOX_DIMS.y + BOX_THICKNESS * 2,
    INNER_BOX_DIMS.z
  ];
  extrusion_dims = [ INNER_BOX_DIMS.x, INNER_BOX_DIMS.y, INNER_BOX_DIMS.z ];
  difference() {
    translate([ -outer_dims.x / 2, -outer_dims.y / 2 ])
        cube(outer_dims, center = false);
    translate([ -extrusion_dims.x / 2, -extrusion_dims.y / 2 ])
        cube(extrusion_dims, center = false);
  }
}

module thumb_bit(dims = [ 15, 25, 200 ], radius = 4) {

  module circle_fourth(radius) {
    cut_size = radius * 2;
    translate([ -cut_size / 4, -cut_size / 4 ]) difference() {
      circle(r = radius);
      translate([ 0, -cut_size ]) square(cut_size, center = false);
      translate([ -cut_size, -cut_size / 2 ])
          square([ radius * 2, radius * 2 ]);
    }
  }

  module extra(radius) {
    difference() {
      square(radius, center = true);
      circle_fourth(radius = radius);
    }
  }

  translate([ 0, -dims.z / 2, -dims.y / 2 ]) #rotate([ -90, 0, 0 ])
      linear_extrude(height = dims.z)
          translate([ -dims.x / 2, -dims.y / 2 ]) union() {
    square([ dims.x, dims.y - radius ]);
    translate([ -radius / 2, radius / 2 ]) rotate(a = 270)
        extra(radius = radius);
    translate([ dims.x + radius / 2, radius / 2 ]) rotate(a = 180)
        extra(radius = radius);
    translate([ dims.x / 2, dims.y - radius ]) circle(r = dims.x / 2);
  }
}

module box() {
  difference() {
    union() {
      translate([ 0, 0, BOX_THICKNESS * 2 ]) internal();
      side(flip = true);
    }
    translate([ 0, 0, INNER_BOX_DIMS.z + BOX_THICKNESS * 2 ])
        thumb_bit(dims = [ 20, 25, 200 ], radius = 4);
  }
}

module lid() { side(flip = false, tolerance = TOLERANCE); }

union() {
  box();
  translate([ OUTER_BOX_DIMS.x + 20, 0, OUTER_BOX_DIMS.z/2 ]) lid();
}