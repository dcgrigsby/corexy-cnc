$fn=100;

module rail(dia, length) {
  rotate([-90,0,0]) {
    cylinder(h=length, d=dia);
  }
}

/*
rail(
  dia=8,
  length=330
);
*/
