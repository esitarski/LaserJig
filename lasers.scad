include <params.scad>
include <thickness.scad>

show_laser_lines = false;

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

module lasers() {
    translate( [lasers_x, sheet_thickness+abs(lasers_back_yz[0]), base_bottom+laser_position_z] )
    rotate( [-laser_position_angle, 0, 0] )
    translate( [0,-(lasers_width-sheet_thickness),-(laser_origin_height+sheet_thickness)] ) {
        // Draw the laser modules.
        laser_start = sheet_thickness+laser_clearance;
        laser = [laser_width, laser_length, laser_height];
        translate( [laser_start, 0, sheet_thickness] ) {
            lps = [hb_85-hb_85, hb_83-hb_85, hb_80-hb_83, hb_75-hb_85, bb_0-hb_85, bb_5-hb_85];
            for( lp = lps ) {
                translate( [lp, 0, 0] )
                color( [1,.5,0] )
                cube( laser );
            }
        }
        
        color( [.9,.9,.9] ) {
            //------------------------------------------
            lasers_bottom = [lasers_length-sheet_thickness*2, laser_length, sheet_thickness];
            echo( lasers_bottom=lasers_bottom );
            
            translate( [sheet_thickness, 0, 0] )
            cutCube(
                lasers_bottom,
                circles_remove = [[0.85*plug_diameter/2, bb_0-300, lasers_bottom[1]/2]]
            );
            
            //------------------------------------------
            lasers_top = [lasers_length, lasers_width, sheet_thickness];
            echo( lasers_top=lasers_top );
            
            translate( [0, 0, lasers_height-sheet_thickness] )
            cutCube( lasers_top );
            
            //------------------------------------------
            lip = 2;
            lasers_front = [lasers_length-sheet_thickness*2, sheet_thickness, sheet_thickness+lip];
            echo( lasers_front=lasers_front );

            translate( [sheet_thickness, lasers_width-sheet_thickness, 0] )
            cutCube( lasers_front );
            
            //------------------------------------------
            lasers_end = [sheet_thickness, lasers_width, lasers_height-sheet_thickness];
            echo( "2x", lasers_end=lasers_end );
            
            translate( [0,0,0] )
            cutCube( lasers_end );

            translate( [lasers_length-sheet_thickness,0,0] )
            cutCube( lasers_end );
 
            //------------------------------------------
            laser_side_start = lasers_margin + (hb_75 - hb_85) + laser_width/2 + laser_clearance;
            laser_side_end = lasers_length - lasers_margin - (bb_5-bb_0) - laser_width/2 - laser_clearance;
            laser_side = [laser_side_end-laser_side_start, sheet_thickness, lasers_height-sheet_thickness*2];
            
            echo( laser_side_start=laser_side_start );
            echo( "2x", laser_side=laser_side );
            
            control_radius = 20.0/2;
            control_tab_start = laser_side[0]/2+40;
            control_tab_end = control_tab_start + control_radius*2;
            translate( [laser_side_start, 0, sheet_thickness] )
            cutCube( laser_side,
                    circles_remove = [[control_radius, control_tab_start, laser_side[2]/2],
                    [control_radius, control_tab_end, laser_side[2]/2]
                    ],
                    cutouts=[
                        [control_tab_start,laser_side[2]/2-control_radius,control_tab_end-control_tab_start,control_radius*2 ],
                    ]
            );
            translate( [laser_side_start, lasers_width-sheet_thickness, sheet_thickness] )
            cutCube( laser_side );
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
		for( lp = [hb_85-hb_85, hb_83-hb_85, hb_80-hb_83, hb_75-hb_85, bb_0-hb_85, bb_5-hb_85] ) {
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
