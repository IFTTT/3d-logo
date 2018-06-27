// Apple Thunderbolt mount for laptop
//
// 6/13/2018 Jason Thrasher
//
// Dimensions in millimeters

include <ifttt-logo.scad>

$fs = 0.1; // mm per facet in cylinder
$fa = 5; // degrees per facet in cylinder
$fn = 100;

THUNDERBOLT_THICKNESS = 8.11;
THUNDERBOLT_WIDTH_LOW = 95;//104; // approx
THUNDERBOLT_WIDTH_HIGH = 149;//140; // approx
THUNDERBOLT_HEIGHT = 300;

MBP_THICKNESS = 17.9;
MBP_WIDTH = 304.1;
MBP_DEPTH = 212.4;

WIRE_DIA = 15;

module STAND() {
    color( "LightGrey", 1.0 )
    translate([-THUNDERBOLT_THICKNESS,0,0])
    difference() {
        hull() {
            translate([0,-THUNDERBOLT_WIDTH_HIGH/2,-THUNDERBOLT_HEIGHT/2])
            cube(size = [THUNDERBOLT_THICKNESS, THUNDERBOLT_WIDTH_HIGH, 1], center = false);
            translate([0,-THUNDERBOLT_WIDTH_LOW/2,THUNDERBOLT_HEIGHT/2])
            cube(size = [THUNDERBOLT_THICKNESS, THUNDERBOLT_WIDTH_LOW, 1], center = false);
        }
        translate([-1.4, 0, 0])
            rotate([0, 90, 0]) {
                cylinder(d1=68, d2=53, THUNDERBOLT_THICKNESS);
                cylinder(d=53, THUNDERBOLT_THICKNESS * 10);
            }
    }
}

module MBP() {
    color( "DarkGray", 1.0 )
    translate([0,-MBP_WIDTH/2,-MBP_DEPTH/2])
    cube([MBP_THICKNESS, MBP_WIDTH, MBP_DEPTH]);
}

module WIRES() {

    color( "Crimson", 1.0 )
    translate([WIRE_DIA/2,WIRE_DIA/2,-THUNDERBOLT_HEIGHT/2])
    hull() {
        rotate([90,0,0]) {
            translate([0,-THUNDERBOLT_HEIGHT/2/2,0]) cylinder(d = WIRE_DIA, h = WIRE_DIA);
            translate([0,THUNDERBOLT_HEIGHT/2,0]) cylinder(d = WIRE_DIA, h = WIRE_DIA);
            translate([-100,THUNDERBOLT_HEIGHT/2+50,0]) cylinder(d = WIRE_DIA, h = WIRE_DIA);
        }
    }
}

module LOWER_LEFT() {
    R_L_BRACKET = MBP_THICKNESS;
    R_U_BRACKET = R_L_BRACKET * 0.9;
    R_L_CRADLE = MBP_THICKNESS*.5;
    R_U_CRADLE = R_L_CRADLE;
    R_CRADLE_THICKNESS = MBP_THICKNESS * .2;
    WIDTH = THUNDERBOLT_WIDTH_HIGH/2 + 10;

    rotate([90,0,0]) {
        hull() {
            cylinder(r=R_L_BRACKET, h = WIDTH);

            translate([R_U_BRACKET - R_L_BRACKET, 50, 0])
            cylinder(r = R_U_BRACKET, h = WIDTH);
        }


        // taco
        R_TACO = WIDTH*.5;
        DEPTH = WIRE_DIA + THUNDERBOLT_THICKNESS + 14;        
        hull() {
          translate([DEPTH, R_L_CRADLE-R_L_BRACKET, 0])
          cylinder(r = R_L_CRADLE, h = WIDTH);

          translate([DEPTH, R_TACO-15, 0])
          cylinder(r = R_CRADLE_THICKNESS, h = WIDTH-R_TACO);

					translate([DEPTH, -15, WIDTH - R_TACO])
					rotate([0,-90,0])
					    rotate_extrude(angle = 90, convexity = 100)
					translate([R_TACO, 0, 0])
					circle(r = R_CRADLE_THICKNESS);
        }

        // floor
        hull() {
          translate([0, R_L_CRADLE-R_L_BRACKET, 0])
          cylinder(r=R_L_CRADLE, h = WIDTH);

          translate([DEPTH, R_L_CRADLE-R_L_BRACKET, 0])
          cylinder(r = R_L_CRADLE, h = WIDTH);

        }
    }
}
module LOWER() {
//    hull() {
        LOWER_LEFT();
        mirror(v= [0,1,0] ) LOWER_LEFT();

            //difference() {

//                rotate([0,90,0])
//                translate([-MBP_THICKNESS,0,5])
//                cylinder(r=THUNDERBOLT_WIDTH_HIGH/2 + 10, h=MBP_THICKNESS*2);
//                offset = THUNDERBOLT_WIDTH_HIGH;
//                translate([0,-100,-offset])
//                cube([100,200,offset]);

//            translate([WIRE_DIA + THUNDERBOLT_THICKNESS,0,0])
//rotate([90,0,90])
//    rotate_extrude(angle = 180, convexity = 100)
//translate([THUNDERBOLT_WIDTH_HIGH/2 + 10 - MBP_THICKNESS, 0, 0])
//circle(r = MBP_THICKNESS);

//            }
//    }
}

module PART() {
    difference() {
        translate([0,0,-MBP_DEPTH/2]) LOWER();

        //WIRES();

        translate([WIRE_DIA,0,0]) scale([1.05,1,1]) MBP();

        scale([1.1, 1, 1]) STAND();

        translate([0,0,0]) scale([100,0.9,1]) STAND();

        translate([0,0,-THUNDERBOLT_HEIGHT/2]) scale([0.48, 0.9, 1])
        cylinder(d1=THUNDERBOLT_WIDTH_HIGH, d2=THUNDERBOLT_WIDTH_LOW, h=THUNDERBOLT_HEIGHT);

//        translate([-THUNDERBOLT_WIDTH_HIGH+WIRE_DIA+MBP_THICKNESS/2,-THUNDERBOLT_WIDTH_HIGH,-70])
//        cube([THUNDERBOLT_WIDTH_HIGH,THUNDERBOLT_WIDTH_HIGH*2,THUNDERBOLT_WIDTH_HIGH]);

        sides();

        // holes for wire junction
        WIRE_JUNCTION_DIA = 13.2; // 13.0 actual
        translate([0,0,-MBP_DEPTH/2-7])
        rotate([0,90,0])
        cylinder(d = WIRE_JUNCTION_DIA, h=THUNDERBOLT_HEIGHT);

    }
    
}

module sides() {
    modifier = 1.1;
    translate([50,0,0]) {
        difference() {
    translate([-THUNDERBOLT_THICKNESS * 10,2*modifier*-THUNDERBOLT_WIDTH_HIGH/2, -THUNDERBOLT_HEIGHT/2])
    cube([THUNDERBOLT_THICKNESS * 10,2*modifier*THUNDERBOLT_WIDTH_HIGH,THUNDERBOLT_HEIGHT]);
            scale([10, modifier, 1]) STAND();

        }
    }
}

//STAND();
//scale(1.1)STAND();
//translate([WIRE_DIA,0,0]) scale([1.0,1,1]) MBP();

PART();
