thickness=6;

max_length=500;
support_length=50;
max_height=140;
cutout_radius=90;
text_space=4;
font_size=7;
line_length=max_length-support_length-2*cutout_radius-10;
measure_line_length=40;
engrave_depth=0.5;
gauge = [
    [0,0],
    [0,max_height*2],
    [max_length,max_height*2],
    [max_length,max_height],
    [max_length-support_length-cutout_radius*2,max_height],
    [max_length-support_length-cutout_radius*2,0]
];

color([.5,.5,.5]) {
    difference() {
        // Basic outline.
        linear_extrude( height=thickness ) polygon( points=gauge );
        // Access cutout.
        translate( [max_length-support_length-cutout_radius,max_height,0] )
        cylinder( h=thickness*4, r=cutout_radius, center=true );
        
        // Top measuring lines.
        translate([0,max_height,thickness]) {
            translate([0, 120, 0]) cube( [line_length*2, 1, engrave_depth*2], center=true );
            translate([0, 100, 0]) cube( [line_length*2, 1, engrave_depth*2], center=true );
            
            translate([0,   0, 0]) cube( [line_length*2, 1, engrave_depth*2], center=true );
        }

        // Bottom measuring lines.
        translate([0,0,thickness]) {
            translate([0, 20, 0]) cube( [line_length*2, 1, engrave_depth*2], center=true );
            translate([0, 40, 0]) cube( [line_length*2, 1, engrave_depth*2], center=true );
        }
        
        // Top labels.
        translate([text_space, max_height-font_size-text_space, thickness-engrave_depth]) {
            translate([0, 100, 0]) linear_extrude( height=engrave_depth ) text("+10cm (category 1)", size=font_size);
            translate([0, 120, 0]) linear_extrude( height=engrave_depth ) text("+12cm (category 2)", size=font_size);
            translate([0, 140, 0]) linear_extrude( height=engrave_depth ) text("+14cm (category 3)", size=font_size);
        }

        // Bottom labels.
        translate([text_space,text_space,thickness-engrave_depth]) {
            translate([0,  0, 0]) linear_extrude( height=engrave_depth ) text("-14cm (category 3)", size=font_size);
            translate([0, 20, 0]) linear_extrude( height=engrave_depth ) text("-12cm (category 2)", size=font_size);
            translate([0, 40, 0]) linear_extrude( height=engrave_depth ) text("-10cm (category 1)", size=font_size);
        }

        // Length label.
        translate([max_length-75, max_height+140-text_space-font_size, thickness-engrave_depth]) linear_extrude( height=engrave_depth ) text("max width 50cm", size=font_size);

        // Useful measurements.
        translate([max_length, max_height+125, thickness]) cube( [measure_line_length*2, 1, engrave_depth*2], center=true );
        translate([max_length-measure_line_length, max_height+125-text_space-font_size, thickness-engrave_depth]) linear_extrude( height=engrave_depth ) text("125mm", size=font_size);
        translate([max_length, max_height+60,  thickness]) cube( [measure_line_length*2, 1, engrave_depth*2], center=true );
        translate([max_length-measure_line_length, max_height+60-text_space-font_size, thickness-engrave_depth]) linear_extrude( height=engrave_depth ) text("60mm", size=font_size);
        translate([max_length, max_height+85,  thickness]) cube( [measure_line_length*2, 1, engrave_depth*2], center=true );
        translate([max_length-measure_line_length, max_height+85-text_space-font_size, thickness-engrave_depth]) linear_extrude( height=engrave_depth ) text("85mm", size=font_size);

        // Seat min/max length
        translate([240,max_height*2,thickness]) cube([1, 24, engrave_depth*2], center=true);
        translate([240+text_space,max_height*2-10,thickness-engrave_depth]) linear_extrude(height=engrave_depth ) text("24cm", size=font_size );
        translate([300,max_height*2,thickness]) cube([1, 24, engrave_depth*2], center=true);
        translate([300+text_space,max_height*2-10,thickness-engrave_depth]) linear_extrude(height=engrave_depth ) text("30cm", size=font_size );
    }
}
