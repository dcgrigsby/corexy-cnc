$fn=100;

function rail_and_bearing_block_x(rail_dia, bearing_dia) = rail_dia*5 + bearing_dia*2;

function rail_and_bearing_block_y_padding(rail_dia, bearing_y) = rail_dia*5 > bearing_y*2 + 20? rail_dia*5 : bearing_y*2 + 20;
function rail_and_bearing_block_y(rail_dia, bearing_y, rail_sep_y) = rail_and_bearing_block_y_padding(rail_dia, bearing_y) + rail_sep_y;

function rail_and_bearing_block_z_padding(rail_dia, bearing_dia) = rail_dia*5 > bearing_dia*3 ? rail_dia*5 : bearing_dia*3;
function rail_and_bearing_block_z(rail_dia, bearing_dia, rail_sep_z) = rail_and_bearing_block_z_padding(rail_dia, bearing_dia) + rail_sep_z;

module rail_and_bearing_block(rail_sep_z, rail_dia, rail_sep_y, bearing_dia, bearing_y, heatset_outer_dia, heatset_inner_dia, heatset_z) {
  rail_and_bearing_block_x = rail_and_bearing_block_x(rail_dia, bearing_dia);
  rail_and_bearing_block_y = rail_and_bearing_block_y(rail_dia, bearing_dia, rail_sep_y);
  rail_and_bearing_block_z = rail_and_bearing_block_z(rail_dia, bearing_dia, rail_sep_z);
  difference() {
    translate([-rail_and_bearing_block_x/2, -rail_and_bearing_block_y/2, 0]) {
      cube([rail_and_bearing_block_x, rail_and_bearing_block_y, rail_and_bearing_block_z]);
    }
    for (shaft_z = [rail_and_bearing_block_z/2 + rail_sep_z/2, rail_and_bearing_block_z/2 - rail_sep_z/2]) {
      // rails shafts (to legs)
      rail_and_bearing_shaft_x = -rail_and_bearing_block_x/2 + bearing_dia;
      translate([rail_and_bearing_shaft_x, -rail_and_bearing_block_y/2 - 1, shaft_z]) {
        rotate([-90, 0, 0]) {
          // all the way through
          cylinder(d=rail_dia+1, h=rail_and_bearing_block_y+2);
        }
      }
      for (sign = [-1, 1]) {
        // bearing shafts
        translate([rail_and_bearing_shaft_x, sign*(rail_and_bearing_block_y/2 + 1), shaft_z]) {
          rotate([90*sign, 0, 0]) {
            cylinder(d=bearing_dia, h=rail_and_bearing_block_y/2 - rail_sep_y/2 + bearing_y/2 + 1);
          }
        }
      }
      // rail shafts (to gantry)
      translate([rail_and_bearing_block_x / 2 + 1, 0, shaft_z]) {
        for (sign = [1, -1]) {
          translate([0, sign*rail_sep_y/2, 0]) {
            rotate([0, -90, 0]) {
              cylinder(d=rail_dia, h=rail_dia*5+1);
            }
          }
        }
      }
      // bearing shaft heatsets
      for (sign = [-1, 1]) {
        translate([-rail_and_bearing_block_x/2 - 1, sign*(rail_sep_y/2 +  bearing_y/2 + heatset_inner_dia/2), shaft_z]) {
          rotate([0, 90, 0]) {
            cylinder(d=heatset_inner_dia, h=bearing_dia+1);
            cylinder(d=heatset_outer_dia, h=heatset_z+1);
          }
        }
      }
      // rail heatsets
      for (sign = [-1, 1]) {
        translate([rail_and_bearing_block_x/2 - rail_dia*2.5, sign*(rail_and_bearing_block_y/2 + 1), shaft_z]) {
          rotate([sign*90, 0, 0]) {
            cylinder(d=heatset_inner_dia, h=rail_and_bearing_block_z_padding(rail_dia, bearing_dia)/2 + 1);
            cylinder(d=heatset_outer_dia, h=heatset_z+1);
          }
        }
      }
    }
  }
}

rail_and_bearing_block(
  rail_sep_z = 100,
  rail_dia = 8,
  rail_sep_y = 100,
  bearing_dia = 15,
  bearing_y = 24,
  heatset_outer_dia=4.1,
  heatset_inner_dia=3,
  heatset_z=5
);
