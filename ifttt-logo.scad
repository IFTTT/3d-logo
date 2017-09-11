// IFTTT Logo

// ifttt-logo.dxf is 878.42mm x 232.83mm
IFTTT_W = 878.42; // width of IFTTT DXF object
IFTTT_H = 232.83; // height of IFTTT DXF object

linear_extrude(height=200, scale=2, slices=200, twist=0)
// center dxf, so extrude scale origin is 0,0
translate([-IFTTT_W / 2, -IFTTT_H / 2, 0])
import("ifttt-logo.dxf");
