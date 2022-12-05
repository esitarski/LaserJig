$fn=128;

thickness=6;

max_length=500;
support_length=50;
max_height=140;
cutout_radius=90;
text_space=4;
font_size=7;
line_length=max_length-support_length-2*cutout_radius-10;
line_width=0.5;
measure_line_length=40;
indicator_line_length=12;
engrave_depth=0.5;
gauge = [
    [0,0],
    [0,max_height*2],
    [max_length,max_height*2],
    [max_length,max_height],
    [max_length-support_length-cutout_radius*2,max_height],
    [max_length-support_length-cutout_radius*2,0]
];

show_text = true;

module scoring() {
    // Top measuring lines.
    translate([0,max_height-line_width/2]) {
        translate([0, 120]) square( [line_length, line_width] );
        translate([0, 100]) square( [line_length, line_width] );            
        translate([0,   0]) square( [line_length, line_width] );
    }

    // Bottom measuring lines.
    translate([0,0-line_width/2]) {
        translate([0, 20]) square( [line_length, line_width] );
        translate([0, 40]) square( [line_length, line_width] );
    }
    
    if( show_text ) {
		// Top labels.
		translate([text_space, max_height-font_size-text_space]) {
			translate([0, 100]) text("+100mm", size=font_size);
			translate([0, 120]) text("+120mm", size=font_size);
			translate([0, 140]) text("+140mm", size=font_size);
		}

		// Bottom labels.
		translate([text_space,text_space]) {
			translate([0,  0]) text("-140mm", size=font_size);
			translate([0, 20]) text("-120mm", size=font_size);
			translate([0, 40]) text("-100mm", size=font_size);
		}
		
		// Length label.
		translate([max_length-85, max_height+140-text_space-font_size]) text("max width 500mm", size=font_size);
    }

    // Useful measurements.
    translate([max_length-measure_line_length, max_height+125-line_width/2]) square( [measure_line_length, line_width] );
    if( show_text ) translate([max_length-measure_line_length, max_height+125-text_space-font_size]) text("125mm", size=font_size);
    translate([max_length-measure_line_length, max_height+60-line_width/2]) square( [measure_line_length, line_width] );
    if( show_text ) translate([max_length-measure_line_length+6, max_height+60-text_space-font_size]) text("60mm", size=font_size);
    translate([max_length-measure_line_length, max_height+85-line_width/2]) square( [measure_line_length, line_width] );
    if( show_text ) translate([max_length-measure_line_length+6, max_height+85-text_space-font_size]) text("85mm", size=font_size);

    // Seat min/max length
    translate([240-line_width/2,max_height*2-indicator_line_length]) square([line_width, indicator_line_length] );
    if( show_text ) translate([240-35,max_height*2-text_space-font_size]) text("240mm", size=font_size );
    translate([300-line_width/2,max_height*2-indicator_line_length]) square([line_width, indicator_line_length] );
    if( show_text ) translate([300-35,max_height*2-text_space-font_size]) text("300mm", size=font_size );

    // Min handlebar width.
    translate([350-line_width/2,max_height*2-indicator_line_length]) square([line_width, indicator_line_length] );
    if( show_text ) translate([350-35,max_height*2-text_space-font_size]) text("350mm", size=font_size );
    
    // Credits
    if( show_text ) translate([120, max_height-font_size-text_space]) text("edward.sitarski@gmail.com 2022", size=font_size );
}

module outline() {
    difference() {
        // Basic outline.
        polygon( points=gauge );
        
        // Access cutout.
        translate( [max_length-support_length-cutout_radius,max_height] )
        circle( r=cutout_radius );
    }
}

//draw="cutting";
//draw="scoring";
draw="shape";
if( draw == "scoring" )
    color( [0,0,0] )
    scoring();
else if( draw == "cutting" )
    color( [.5,.5,.5] )
    outline();
else {
    color( [.5,.5,.5] )
    outline();
    color( [0,0,0] )
    scoring();
    /*
    color([.5,.5,.5]) {
        difference() {
            linear_extrude( height=thickness )
            outline();
            
            translate( [0,0,thickness-engrave_depth] )
            linear_extrude( height=engrave_depth )
            scoring();
        }
    }
    */
}
