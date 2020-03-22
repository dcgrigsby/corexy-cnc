$fn=100;

module stepper(body_xy, body_z, shaft_base_dia, shaft_dia, shaft_z, mount_hole_offset, mount_hole_dia, mount_hole_z) {
  translate([-body_xy/2, -body_xy/2, 0]) {
    difference() {
      union() {
        cube([body_xy, body_xy, body_z]);
        translate([body_xy/2, body_xy/2, body_z]) {
          cylinder(d=shaft_base_dia, h=2); // h not specified
        }
        translate([body_xy/2, body_xy/2, body_z]) {
          cylinder(d=shaft_dia, h=shaft_z);
        }
      }
      translate([body_xy/2, body_xy/2, body_z - mount_hole_z]) {
        translate([mount_hole_offset, mount_hole_offset, 0]) {
          cylinder(d=mount_hole_dia, h=mount_hole_z + 1);
        }
        translate([-mount_hole_offset, mount_hole_offset, 0]) {
          cylinder(d=mount_hole_dia, h=mount_hole_z + 1);
        }
        translate([mount_hole_offset, -mount_hole_offset, 0]) {
          cylinder(d=mount_hole_dia, h=mount_hole_z + 1);
        }
        translate([-mount_hole_offset, -mount_hole_offset, 0]) {
          cylinder(d=mount_hole_dia, h=mount_hole_z + 1);
        }
      }
    }
  }
}

/*
stepper(
  body_xy=42.3,
  body_z=38,
  shaft_base_dia=22,
  shaft_dia=5,
  shaft_z=24,
  mount_hole_offset=31/2,
  mount_hole_dia=3,
  mount_hole_z=4.5
);
*/
