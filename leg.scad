$fn=100;

function leg_xy(rail_dia) = rail_dia*5;

function leg_base_xy(rail_dia) = leg_xy(rail_dia) * 2;

module leg(rail_dia, first_rail_z, rail_sep, rail_heatset_z, rail_heatset_internal_dia, rail_heatset_external_dia, base_heatset_z, base_heatset_external_dia) {
  xy = leg_xy(rail_dia);
  difference() {
    union() { // leg & base
      translate([-xy/2, -xy/2, 0]) {
        cube([xy, xy, first_rail_z + rail_sep + rail_dia*2]);
      }
      base_xy = leg_base_xy(rail_dia);
      translate([-base_xy/2, -base_xy/2, 0]) {
        cube([base_xy, base_xy, base_heatset_z]);
      }
    }
    union() { // rail holes
      for (vertical_offset = [0, rail_sep]) {
        translate([xy/2 + 1, 0, first_rail_z + vertical_offset]) {
          rotate([0, -90, 0]) {
            cylinder(h=rail_dia*1.5+1, d=rail_dia);
          }
        }
        translate([0, xy/2 + 1, first_rail_z + vertical_offset]) {
          rotate([90, 0, 0]) {
            cylinder(h=rail_dia*1.5+1, d=rail_dia);
          }
        }
      }
    }
    union() { // rail mounting screws
      for (vertical_offset = [0, rail_sep]) {
        translate([-xy/2 - 1, xy/2 - rail_dia*.75, first_rail_z + vertical_offset]) {
          rotate([0, 90, 0]) {
            cylinder(h=xy/2+1, d=rail_heatset_internal_dia);
            cylinder(h=rail_heatset_z+1, d=rail_heatset_external_dia);
          }
        }
        translate([xy/2 - rail_dia*.75, -xy/2 - 1, first_rail_z + vertical_offset]) {
          rotate([-90, 0, 0]) {
            cylinder(h=xy/2+1, d=rail_heatset_internal_dia);
            cylinder(h=rail_heatset_z+1, d=rail_heatset_external_dia);
          }
        }
      }
    }
    union() { // base mounting screws
      let(base_heatset_offset = xy - base_heatset_external_dia*2) {
        translate([-base_heatset_offset, -base_heatset_offset, -1]) {
          cylinder(d=base_heatset_external_dia, h=base_heatset_z + 2);
        }
        translate([-base_heatset_offset, base_heatset_offset, -1]) {
          cylinder(d=base_heatset_external_dia, h=base_heatset_z + 2);
        }
        translate([base_heatset_offset, base_heatset_offset, -1]) {
          cylinder(d=base_heatset_external_dia, h=base_heatset_z + 2);
        }
        translate([base_heatset_offset, -base_heatset_offset, -1]) {
          cylinder(d=base_heatset_external_dia, h=base_heatset_z + 2);
        }
      }
    }
  }
}

/*
leg(
  rail_dia=8,
  first_rail_z=40,
  rail_sep=100,
  rail_heatset_z=3,
  rail_heatset_internal_dia=3,
  rail_heatset_external_dia=4.1,
  base_heatset_z=5,
  base_heatset_external_dia=6.3
);
*/
