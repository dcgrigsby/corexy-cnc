$fn=100;

function stepper_mount_xy(stepper_body_xy, base_heatset_z) = stepper_body_xy + base_heatset_z*2;

module stepper_mount(stepper_body_xy, stepper_body_z, stepper_offset_z, stepper_shaft_base_dia, stepper_mounting_hole_offset, stepper_mounting_hole_dia, base_heatset_z, base_heatset_external_dia) {
  difference() {
    // body
    stepper_mount_xy = stepper_mount_xy(stepper_body_xy, base_heatset_z);
    translate([-(stepper_mount_xy)/2, -(stepper_mount_xy)/2, 0]) {
      cube([stepper_mount_xy, stepper_mount_xy, stepper_offset_z + stepper_body_z + base_heatset_z]);
    }
    // cavity
    translate([-stepper_body_xy/2, -stepper_body_xy/2 - base_heatset_z - 1, base_heatset_z]) {
      cube([stepper_body_xy, stepper_body_xy + base_heatset_z*2 + 2, stepper_offset_z + stepper_body_z - base_heatset_z]);
    }
    // stepper shaft base
    translate([0, 0, base_heatset_z]) {
      cylinder(d=stepper_shaft_base_dia, h=stepper_offset_z + stepper_body_z + 1);
    }
    // stepper mounting holes
    let (h = stepper_offset_z + stepper_body_z) {
      translate([stepper_mounting_hole_offset, stepper_mounting_hole_offset, h-1]) {
        cylinder(d=stepper_mounting_hole_dia, h=base_heatset_z+2);
      }
      translate([-stepper_mounting_hole_offset, stepper_mounting_hole_offset, h-1]) {
        cylinder(d=stepper_mounting_hole_dia, h=base_heatset_z+2);
      }
      translate([stepper_mounting_hole_offset, -stepper_mounting_hole_offset, h-1]) {
        cylinder(d=stepper_mounting_hole_dia, h=base_heatset_z+2);
      }
      translate([-stepper_mounting_hole_offset, -stepper_mounting_hole_offset, h-1]) {
        cylinder(d=stepper_mounting_hole_dia, h=base_heatset_z+2);
      }
    }
    // base mounting holes
    translate([stepper_mounting_hole_offset, stepper_mounting_hole_offset, -1]) {
      cylinder(d=base_heatset_external_dia, h=base_heatset_z+2);
    }
    translate([-stepper_mounting_hole_offset, stepper_mounting_hole_offset, -1]) {
      cylinder(d=base_heatset_external_dia, h=base_heatset_z+2);
    }
    translate([stepper_mounting_hole_offset, -stepper_mounting_hole_offset, -1]) {
      cylinder(d=base_heatset_external_dia, h=base_heatset_z+2);
    }
    translate([-stepper_mounting_hole_offset, -stepper_mounting_hole_offset, -1]) {
      cylinder(d=base_heatset_external_dia, h=base_heatset_z+2);
    }
  }
}

/*
stepper_mount(
  stepper_body_xy=42.3,
  stepper_body_z=38,
  stepper_offset_z=50,
  stepper_shaft_base_dia=22,
  stepper_mounting_hole_offset=31/2,
  stepper_mounting_hole_dia=3,
  base_heatset_z=5,
  base_heatset_external_dia=6.3
);
*/
