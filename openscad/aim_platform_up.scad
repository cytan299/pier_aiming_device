/*

    aim_platform_up.scad is the code to generate the 3D upper platform for
    the Pro-aim adjustable wedge.
    
    Copyright (C) 2019  C.Y. Tan
    Contact: cytan299@yahoo.com

    This file is part of the aiming device distribution

    aim_platform_up.scad is free software: you can redistribute it
    and/or modify it under the terms of the GNU General Public License
    as published by the Free Software Foundation, either version 3 of
    the License, or (at your option) any later version.

    aim_platform_up.scad is distributed in the hope that it will be
    useful, but WITHOUT ANY WARRANTY; without even the implied
    warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    See the GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with aim_platform_up.scad.  If not, see
    <http://www.gnu.org/licenses/>.

*/

$fn=100;

mm2inch = 1/25.4;

// dimensions are in inches

// constants

// cylindrical wall
OUTER_R = 3.8125;
INNER_R = 3.3125;
WALL_H = 0.7+0.5;
DH = 0.7;

// the size of the PROAIM device
A_L = 8.25;
A_W = 4.9;

//screw holes

// hole on the wall
SCREW_R16 = 0.328/2.0; // average radius of hole for thermal 1/4-20 threaded insert
SCREW_R16_AZ = 0.8554; // aiming hole
SCREW_R16_Z = 0.3446;  // hole for threaded insert


// slots on the base
SCREW_R4 = 0.25/2.0; // 1/4" hole
SCREW_R4_X = 1.2231;
SCREW_R4_Y = 2.55;

SCREW_R4_Xa = 1.2231; // 1/4" hole
SCREW_R4_Ya = 2.8;

SL_X = 1.2231; // and then the square part
SL_Y = 2.675;


module make_base()
{
  difference(){
    // round part of the wall
    cylinder(h = WALL_H, r = OUTER_R);
    
    translate([0, 0, -DH]){
      cylinder(h = WALL_H, r = INNER_R);
    }


    // trim off the sides
    L = 10;
    translate([A_W/2, -L/2, -L/2]){
      cube(L, center=false);
    }

    translate([-L-A_W/2, -L/2, -L/2]){
      cube(L, center=false);
    }

    // and then remove the bottom rounds
    translate([-L/2, -L+1.7948, -L/2]){
      cube(L, center=false);
    }

  }
}



difference(){
  // make the solid parts first
  make_base();

  // then make the screw holes
  
  // the aiming hole on the wall
  translate([0,0,SCREW_R16_AZ]){
    rotate([90,0,0]){
      cylinder(h=10, r=SCREW_R16, center=true);
    }
  }

  // the threaded hole on the wall
  translate([0,0,SCREW_R16_Z]){
    rotate([90,0,0]){
      cylinder(h=10, r=SCREW_R16, center=true);
    }
  }

  // the slot on the base (right side)
  // make the holes of the slot first
  translate([SCREW_R4_X, SCREW_R4_Y, 0]){
    cylinder(h=10, r=SCREW_R4, center=true);
  }
  translate([SCREW_R4_Xa, SCREW_R4_Ya, 0]){
    cylinder(h=10, r=SCREW_R4, center=true);
  }
  // and then the straight part of the slot
  translate([SL_X, SL_Y, 0]){
    cube([2*SCREW_R4, 2*SCREW_R4, 10], true);
  }

  // the slot on the base (left side)
  // make the holes of the slot first
  translate([-SCREW_R4_X, SCREW_R4_Y, 0]){
    cylinder(h=10, r=SCREW_R4, center=true);
  }
  translate([-SCREW_R4_Xa, SCREW_R4_Ya, 0]){
    cylinder(h=10, r=SCREW_R4, center=true);
  }    
  // and then the straight part of the slot
  translate([-SL_X, SL_Y, 0]){
    cube([2*SCREW_R4, 2*SCREW_R4, 10], true);
  }

}

