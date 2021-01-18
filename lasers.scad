include <params.scad>

laser_clearance = 10;   // Clearance around the laser modules.
lasers_x = hb_85-laser_width/2-laser_clearance-sheet_thickness;
lasers_margin = laser_width/2+laser_clearance+sheet_thickness;
lasers_length = (bb_5-hb_85)+2*lasers_margin;
lasers_height = sheet_thickness*2 + laser_height + laser_clearance;
lasers_width = laser_length+sheet_thickness;

lasers_back_yz = rotate_point( [-laser_length, -laser_origin_height-sheet_thickness],
                    -laser_position_angle );
lasers_front_yz = rotate_point( [sheet_thickness, -laser_origin_height-sheet_thickness],
                    -laser_position_angle );
                    
lasers_effective_width = abs(lasers_back_yz[0]-lasers_front_yz[0]);

base_width =
    sheet_thickness +
    abs(lasers_back_yz[0]) + laser_setback +
    channel_offset +
    sheet_thickness;
 
back_height_over = 5;
back_height=(laser_setback + channel_offset) * tan(laser_spread_angle/2 - laser_position_angle) + laser_position_z + back_height_over;
    
channel_center = base_width - sheet_thickness + channel_offset;

show_laser_lines = 0;

module laser_clamp( p, back ) {
    laser_clearance = 10;
    clamp_thickness = laser_clearance - 1;
    foot_length = 14 + clamp_thickness;
    border = 2.25;
    pad = 10;
    overlap = 0.25;
    
    laser_clamp_points = [
        [0,0],
        [foot_length, 0],
        [foot_length, laser_height + border],
        [foot_length + border + laser_width/2 - pad/2, laser_height + border],
        [foot_length + border + laser_width/2 - pad/2, laser_height - overlap],
        [foot_length + border + laser_width/2 + pad/2, laser_height - overlap],
        [foot_length + border + laser_width/2 + pad/2, laser_height + clamp_thickness],
        [foot_length - border - clamp_thickness + border, laser_height + clamp_thickness],
        [foot_length - border - clamp_thickness + border, sheet_thickness],    
        [0, sheet_thickness],    
    ];
    echo( laser_clamp_points=laser_clamp_points );
    pad_middle = laser_clamp_points[5][0] - pad/2;
    
    translate( p ) {
        color( [.9,.9,0] )
        if( back ) {
            translate( [0,10,0] )
            translate( [-pad_middle,sheet_thickness,0] )
            rotate( [90,0,0] )
            linear_extrude( height=sheet_thickness )
            polygon( laser_clamp_points );
        }
        else {
            translate( [laser_clamp_points[3][0]+laser_width/2-pad/2,laser_length-sheet_thickness,0] )
            rotate( [90,0,180] )
            linear_extrude( height=sheet_thickness )
            polygon( laser_clamp_points );
        }
    }
}

module lasers() {
    translate( [lasers_x, sheet_thickness+abs(lasers_back_yz[0]), base_bottom+laser_position_z] )
    rotate( [-laser_position_angle, 0, 0] )
    translate( [0,-(lasers_width-sheet_thickness),-(laser_origin_height+sheet_thickness)] ) {
        // Draw the laser modules and clamps.
        laser_start = sheet_thickness+laser_clearance;
        laser = [laser_width, laser_length, laser_height];
        translate( [laser_start, 0, sheet_thickness] ) {
            lps = [hb_85-hb_85, hb_80-hb_85, hb_75-hb_85, bb_0-hb_85, bb_5-hb_85];
            for( lp = lps ) {
                translate( [lp, 0, 0] )
                color( [1,.5,0] )
                cube( laser );
                
                laser_clamp( [lp+laser_width/2, 0, 0], lp==lps[1] || lp==lps[2] || lp==lps[4] );
            }
        }
        
        color( [.9,.9,.9] ) {
            //------------------------------------------
            lasers_bottom = [lasers_length-sheet_thickness*2, laser_length, sheet_thickness];
            echo( lasers_bottom=lasers_bottom );
            
            translate( [sheet_thickness, 0, 0] )
            cube( lasers_bottom );
            
            //------------------------------------------
            lasers_top = [lasers_length, lasers_width, sheet_thickness];
            echo( lasers_top=lasers_top );
            
            translate( [0, 0, lasers_height-sheet_thickness] )
            cube( lasers_top );
            
            //------------------------------------------
            lip = 2;
            lasers_front = [lasers_length-sheet_thickness*2, sheet_thickness, sheet_thickness+lip];
            echo( lasers_front=lasers_front );

            translate( [sheet_thickness, lasers_width-sheet_thickness, 0] )
            cube( lasers_front );
            
            //------------------------------------------
            lasers_end = [sheet_thickness, lasers_width, lasers_height-sheet_thickness];
            echo( "2x", lasers_end=lasers_end );
            
            translate( [0,0,0] )
            cube( lasers_end );
            translate( [lasers_length-sheet_thickness,0,0] )
            cube( lasers_end );
 
            //------------------------------------------
            lasers_spacer = [sheet_thickness, lasers_width-sheet_thickness, lasers_height-sheet_thickness*2];
            echo( "5x", lasers_spacer=lasers_spacer );
            
            spacer_start = lasers_margin + (hb_75 - hb_85) + laser_width/2 + laser_clearance;
            spacer_end = lasers_length - lasers_margin - (bb_5-bb_0) - laser_width/2 - laser_clearance - sheet_thickness;
            spacer_inc = (spacer_end - spacer_start) / 4;
            echo(lasers_length=lasers_length, spacer_start=spacer_start, spacer_end=spacer_end, spacer_inc=spacer_inc);
            for (i = [0:4]) {
                translate( [spacer_start + i * spacer_inc,laser_clearance,sheet_thickness] )
                cube( lasers_spacer );
            }
        }
    }
}

module laser_lines() {
	a = laser_spread_angle/2+laser_position_angle;
	base_intersect = laser_position_z / tan( a );
	points = [
		[0,0],
		[-laser_position_z, base_intersect],
		[-laser_position_z, laser_setback + channel_offset],
		[back_height-laser_position_z-back_height_over, laser_setback + channel_offset],
	];
    y = base_width - sheet_thickness - channel_offset - laser_setback;  
    x = lasers_x+sheet_thickness+laser_clearance+laser_width/2;
	color( [0,1,0,.05] ) {
        translate( [x, y, laser_position_z + base_bottom] )
		for( lp = [hb_85-hb_85, hb_80-hb_85, hb_75-hb_85, bb_0-hb_85, bb_5-hb_85] ) {
			translate( [lp, 0, 0] )
			rotate( a=[0,270,0] )
			linear_extrude( height=1 )
			polygon( points );
		}
	}
}

lasers();
if( show_laser_lines ) {
	laser_lines();
}
