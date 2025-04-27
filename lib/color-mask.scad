

module colorAll(dims) { cube([ dims.x, dims.y, dims.z ]); }

module color1(dims, ring_thickness) {
  cube([ dims.x, dims.y, dims.z / 2 - ring_thickness ]);
}

module color2(dims, ring_thickness) {
  translate([ 0, 0, dims.z / 2 - ring_thickness ])
      cube([ dims.x, dims.y, ring_thickness ]);
}

module color3(dims, ring_thickness) {
  translate([ 0, 0, dims.z / 2 ]) cube([ dims.x, dims.y, dims.z / 2 ]);
}

module colorCurrent(current_color, dims, ring_thickness) {
  translate([ -dims.x / 2, -dims.y / 2 ]) union() {
    if (current_color == 0)
      colorAll(dims);
    else if (current_color == 1)
      color1(dims, ring_thickness);
    else if (current_color == 2)
      color2(dims, ring_thickness);
    else if (current_color == 3)
      color3(dims, ring_thickness);
  }
}