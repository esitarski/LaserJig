include <lasers.scad>

laser_reveal = 165;
column_width = bb_0 - hb_75 - laser_reveal * 2;
column_height = laser_position_z+lasers_back_yz[1];

column_x = (bb_0+hb_75-column_width)/2;

module column() {
    translate( [0, 0, base_bottom] ) {
        // Add a lip on the column front for alignment.
        column_front = [column_width, sheet_thickness, column_height+2];
        
        echo( column_front=column_front );
        
        echo( column_x=column_x );
        translate( [column_x,0,0] )
        cube( column_front );
        
        column_laser_x = laser_reveal + hb_75-hb_85 + laser_clearance + sheet_thickness;
        echo( column_laser_x=column_laser_x );
        
        column_support_break_y = (lasers_effective_width + laser_setback)/2.5;
        column_support_break_z = .25*column_height;
        column_support_z2 = column_height-abs(lasers_back_yz[1]-lasers_front_yz[1]);
        column_support = [
            [0,0],
            [0,column_height],
            [lasers_effective_width,column_support_z2],
            [column_support_break_y,column_support_break_z],
            [lasers_effective_width + laser_setback-channel_thickness,sheet_thickness],
            [lasers_effective_width + laser_setback-channel_thickness,0]
        ];
        echo( "3x", column_support=column_support );
        
        column_support_spacing = (column_width - sheet_thickness) / 2;
        translate( [column_x, sheet_thickness, 0] ) {
            for( i = [0:2] ) {
                translate([i*column_support_spacing,0,0])
                rotate([90,0,90])
                linear_extrude(height=sheet_thickness)
                polygon(points=column_support);
            }
        }
        
        column_support_brace_1 = [
            (column_width - 3*sheet_thickness)/2,
            column_support_break_y,
            sheet_thickness
        ];
        column_support_brace_2 = [
            (column_width - 3*sheet_thickness)/2,
            (column_support_break_y+lasers_effective_width)/2,
            sheet_thickness
        ];
        echo( "2x", column_support_brace_1=column_support_brace_1 );
        echo( "2x", column_support_brace_2=column_support_brace_2 );
        
        column_support_brace_height_1 = column_support_break_z-sheet_thickness;
        column_support_brace_height_2 = (column_support_z2+column_support_break_z)/2;
        echo( column_support_brace_height_1=column_support_brace_height_1,
            column_support_brace_height_2=column_support_brace_height_2 );
        
        color( [1,0,0,.2] )
        translate( [column_x, 0, 0] )
        for ( x = [sheet_thickness, (column_width+sheet_thickness)/2] ) {
            translate( [x, sheet_thickness, column_support_brace_height_1] )
            cube( column_support_brace_1 );

            translate( [x, sheet_thickness, column_support_brace_height_2] )
            cube( column_support_brace_2 );            
        }
        
        //----------------------------------------------------
        // Electronics box.
        //
        electronics_cover = [
            (column_width - 3*sheet_thickness)/2,
            sheet_thickness,
            (column_support_z2 - column_support_break_z)/2 - sheet_thickness*3,
        ];
        echo( electronics_cover=electronics_cover );
       
        electronics_cover_block = [
            sheet_thickness,
            sheet_thickness*2,
            electronics_cover[2]
        ];
        echo( "2x", electronics_cover_block=electronics_cover_block );
        
        // Draw the cover (pain!).
        xy0 = column_support[2];
        xy1 = column_support[3];
        x = xy1[0] - xy0[0];
        y = xy1[1] - xy0[1];
        a = atan( x/y );
        
        color( [0,1,1] )
        translate( [column_x + sheet_thickness*2 + electronics_cover[0], 0, xy0[1]] )
        rotate( [-a,0,0] ) {
            translate( [0, lasers_effective_width, -electronics_cover[2]-sheet_thickness*2] )
            cube( electronics_cover );
            
            translate( [0, lasers_effective_width - electronics_cover_block[1], -electronics_cover[2]-sheet_thickness*2] )
            cube( electronics_cover_block );
            
            translate( [electronics_cover[0]-sheet_thickness, lasers_effective_width - electronics_cover_block[1], -electronics_cover[2]-sheet_thickness*2] )
            cube( electronics_cover_block );
        }
    }
}

color( [1,1,1] )
column();
