$fn=100;

function rail_and_bearing_block_x(bearing_dia, rail_dia) = bearing_dia*2 + rail_dia*1.5;

function rail_and_bearing_block_y(rail_dia, rail_sep_y) = rail_dia*5 + rail_sep_y;

function rail_and_bearing_block_z(bearing_dia, rail_sep_z) = bearing_dia*3 + rail_sep_z;

module rail_and_bearing_block(bearing_dia, bearing_y, rail_sep_z, rail_dia, rail_sep_y) {
  rail_and_bearing_block_x = rail_and_bearing_block_x(bearing_dia, rail_dia);
  rail_and_bearing_block_y = rail_and_bearing_block_y(rail_dia, rail_sep_y);
  rail_and_bearing_block_z = rail_and_bearing_block_z(bearing_dia, rail_sep_z);

  difference() {
    translate([-rail_and_bearing_block_x/2, -rail_and_bearing_block_y/2, 0]) {
      cube([rail_and_bearing_block_x, rail_and_bearing_block_y, rail_and_bearing_block_z]);
    }
    for (shaft_z = [bearing_dia*1.5, rail_and_bearing_block_z - bearing_dia*1.5]) {
      // bearing shafts
      bearing_shaft_x = -rail_and_bearing_block_x/2 + bearing_dia;
      translate([bearing_shaft_x, -rail_and_bearing_block_y/2-1, shaft_z]) {
        rotate([-90, 0, 0]) {
          cylinder(d=rail_dia+1, h=rail_and_bearing_block_y+2);
        }
      }
      translate([bearing_shaft_x, -rail_and_bearing_block_y/2-1, shaft_z]) {
        rotate([-90, 0, 0]) {
          cylinder(d=bearing_dia, h=bearing_y+5);
        }
      }
      translate([bearing_shaft_x, rail_and_bearing_block_y/2+1, shaft_z]) {
        rotate([90, 0, 0]) {
          cylinder(d=bearing_dia, h=bearing_y+5);
        }
      }
      // rail mounts
      translate([rail_and_bearing_block_x/2+1, -rail_and_bearing_block_y/2, shaft_z]) {
        for (rail_shaft_y = [rail_dia *2.5, rail_and_bearing_block_y - rail_dia*2.5]) {
          translate([0, rail_shaft_y, 0]) {
            rotate([0, -90, 0]) {
              cylinder(d=rail_dia, h=rail_dia*1.5+1);
            }
          }
        }
      }
    }
  }
}

rail_and_bearing_block(
  bearing_dia = 15,
  bearing_y = 24,
  rail_sep_z = 100,
  rail_dia = 8,
  rail_sep_y = 100
);

// TODO
// cut out extra between rails?  less weight, faster printing, no downside?
// heatsets for rails, also bearing (<-new)
// think about strength and print direction
