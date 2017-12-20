// IFTTT Logo
// dimensionless
$fs = 0.1; // mm per facet in cylinder
$fa = 5; // degrees per facet in cylinder
$fn = 100;

// ifttt-logo.dxf is 878.42mm x 232.83mm
IFTTT_W = 878.42; // width of IFTTT DXF object
IFTTT_H = 232.83; // height of IFTTT DXF object

module logo(width) {
    scale([width/IFTTT_W, width/IFTTT_W, width/IFTTT_W]) {
        linear_extrude(height=IFTTT_H, scale=1, slices=100, twist=0)
        // center dxf, so extrude scale origin is 0,0
        translate([-IFTTT_W / 2, -IFTTT_H / 2, 0])
        import("ifttt-logo.dxf");
    }
}

// the logo
width = 50;
logo(width);

// connective bar
bar=width/20;
translate([-width/2+1, (width*IFTTT_H/IFTTT_W-bar*1.7)/2, width*IFTTT_H/IFTTT_W/2])
rotate([0,90,0])
cylinder(h=width-1, d=bar);

// hanging loop
translate([0,  (width*IFTTT_H/IFTTT_W-bar)/2, width*IFTTT_H/IFTTT_W/2])
rotate([0,90,0])
rotate_extrude(angle=180, convexity = 10)
translate([bar, 0, 0])
circle(r = bar/4, $fn = 100);