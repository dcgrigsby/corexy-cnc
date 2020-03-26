include <leg.scad>
include <rail.scad>
include <stepper_mount.scad>
include <rail_and_bearing_block.scad>

pulley_dia = 10;

rail_length=406;
rail_dia=8;

first_rail_z=40;
rail_sep=100;

small_heatset_z=3;
small_heatset_internal_dia=3;
small_heatset_external_dia=4.1;

large_heatset_z=5;
large_heatset_external_dia=6.3;

stepper_body_xy=42.3;
stepper_body_z=38;
stepper_shaft_base_dia=22;
stepper_shaft_z=5;
stepper_shaft_dia=24;

stepper_mounting_hole_offset=31/2;
stepper_mounting_hole_dia=3;

left_stepper_offset_z = first_rail_z + rail_sep/2 - stepper_body_z - stepper_shaft_z/2 + 5;
right_stepper_offset_z = first_rail_z + rail_sep/2 - stepper_body_z - stepper_shaft_z/2 - 5;

leg_base_xy = leg_base_xy(rail_dia);
stepper_mount_xy = stepper_mount_xy(stepper_body_xy, large_heatset_z);
left_stepper_mount_offset_y = -(leg_base_xy/2 + stepper_mount_xy/2 + 5);
leg_xy = leg_xy(rail_dia);
left_stepper_mount_offset_x = leg_xy/2 + pulley_dia/2 + 5;

right_stepper_mount_offset_y = left_stepper_mount_offset_y;
right_stepper_mount_offset_x = -left_stepper_mount_offset_x;

bearing_dia = 15;
bearing_y = 24;

rail_and_bearing_block_z_offset = (rail_and_bearing_block_z(rail_dia, bearing_dia, rail_sep) - rail_and_bearing_block_z_padding(rail_dia, bearing_dia))/4 - bearing_dia/2;
rail_and_bearing_block_bearing_x_offset = rail_and_bearing_block_x(rail_dia, bearing_dia)/2 - rail_and_bearing_block_bearing_padding_x(bearing_dia)/2;

module _rail_and_bearing_block() {
  rail_and_bearing_block(
    rail_sep_z = rail_sep,
    rail_dia = rail_dia,
    rail_sep_y = rail_sep, //could|should change
    bearing_dia = bearing_dia,
    bearing_y = bearing_y,
    heatset_external_dia=small_heatset_external_dia,
    heatset_internal_dia=small_heatset_internal_dia,
    heatset_z=small_heatset_z
  );
}

module _stepper_mount(stepper_offset_z) {
  stepper_mount(
    stepper_body_xy=stepper_body_xy,
    stepper_body_z=stepper_body_z,
    stepper_offset_z=stepper_offset_z,
    stepper_shaft_base_dia=stepper_shaft_base_dia,
    stepper_mounting_hole_offset=stepper_mounting_hole_offset,
    stepper_mounting_hole_dia=small_heatset_external_dia,
    base_heatset_z=large_heatset_z,
    base_heatset_external_dia=large_heatset_external_dia
  );
}

module _rail_pair() {
  translate([0, 0, first_rail_z]) {
    _rail();
    translate([0, 0, rail_sep]) {
      _rail();
    }
  }
}

module _rail() {
  rail(
    dia=rail_dia,
    length=rail_length
  );
}

module _leg() {
  leg(
    rail_dia=rail_dia,
    first_rail_z=first_rail_z,
    rail_sep=rail_sep,
    rail_heatset_z=small_heatset_z,
    rail_heatset_internal_dia=small_heatset_external_dia,
    rail_heatset_external_dia=small_heatset_external_dia,
    base_heatset_z=large_heatset_z,
    base_heatset_external_dia=large_heatset_z
  );
}

translate([rail_length/2 + rail_dia, rail_length/2 + rail_dia, 0]) {
    rotate([0, 0, 180]) {
    _leg();
    _rail_pair();
  }
}

translate([-rail_length/2 - rail_dia, -rail_length/2 - rail_dia, 0]) {
  _leg();
  _rail_pair();
  translate([left_stepper_mount_offset_x, left_stepper_mount_offset_y, 0]) {
    _stepper_mount(left_stepper_offset_z);
  }
}

translate([-rail_length/2 - rail_dia, rail_length/2 + rail_dia, 0]) {
  rotate([0,0,-90]) {
    _leg();
    _rail_pair();
  }
}

translate([rail_length/2 + rail_dia, -rail_length/2 - rail_dia, 0]) {
  rotate([0,0,90]) {
    _leg();
    _rail_pair();
  }
  translate([right_stepper_mount_offset_x, right_stepper_mount_offset_y, 0]) {
    _stepper_mount(right_stepper_offset_z);
  }
}

translate([-rail_length/2 - rail_dia + rail_and_bearing_block_bearing_x_offset, 0, rail_and_bearing_block_z_offset]) {
  _rail_and_bearing_block();
}

rotate([0, 0, 90]) {
  translate([-rail_length/2 - rail_dia + rail_and_bearing_block_bearing_x_offset, 0, rail_and_bearing_block_z_offset]) {
    _rail_and_bearing_block();
  }
}

rotate([0, 0, 180]) {
  translate([-rail_length/2 - rail_dia + rail_and_bearing_block_bearing_x_offset, 0, rail_and_bearing_block_z_offset]) {
    _rail_and_bearing_block();
  }
}

rotate([0, 0, 270]) {
  translate([-rail_length/2 - rail_dia + rail_and_bearing_block_bearing_x_offset, 0, rail_and_bearing_block_z_offset]) {
    _rail_and_bearing_block();
  }
}

/*
todo:
gantry, of course
table corner thingie
*/
