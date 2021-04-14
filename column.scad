include <lasers.scad>

laser_reveal = 165;
column_width = bb_0 - hb_75 - laser_reveal * 2;
column_height = laser_position_z+lasers_back_yz[1];

column_x = (bb_0+hb_75-column_width)/2;

module horizontal_laser( x, p_bottom, p_top ) {
    track = [3/8*25, 3/4*25.4, 24*25.4];
    laser = [65, 70, 75];
    bolt_xy = [65/2, 40];
    laser_height = 45;
    
    rail_length = 130;
    shuttle_rail = [track[0], sheet_thickness, rail_length];
    shuttle_top = [sheet_thickness, sheet_thickness*2+track[1], shuttle_rail[2]];
    shelf_border = 10;
    shuttle_shelf = [laser[0]+sheet_thickness+track[0], laser[1]+shuttle_top[1]+shelf_border, sheet_thickness];
    
    dx = p_top[0] - p_bottom[0];
    dy = p_top[1] - p_bottom[1];
    angle = atan2( dy, dx ) - 90;
    
    fraction = 0.22;
    p_bottom_new = [p_bottom[0] + dx*fraction, p_bottom[1] + dy*fraction];
    
    echo( "shuttle_angle=", angle );
    echo( "shuttle_height=", p_bottom_new[0] );
    
    echo( "2x", shuttle_rail=shuttle_rail );
    echo( shuttle_top=shuttle_top );
    echo( shuttle_shelf=shuttle_shelf );
        
    translate( [x,p_bottom_new[0],base_bottom+p_bottom_new[1]] ) {
        rotate( [angle,0,0] ) {
            color( [1,0,0] )
            translate( [0,-sheet_thickness, 0] )
            cube( track );
            
            //shuttle_height = track[2]/2;
            shuttle_height = track[2] - shuttle_rail[2];
            
            color( [.5,.5,.5] )
            translate( [0,0, shuttle_height] )
            cube( shuttle_rail );
                
            color( [.5,.5,.5] )
            translate( [0, -track[1] - sheet_thickness, shuttle_height] )
            cube( shuttle_rail );

            color( [1,1,1] )
            translate( [track[0], -track[1] - sheet_thickness, shuttle_height] )
            cube( shuttle_top );

            color( [0,.5,0] )
            translate( [0, -track[1] - sheet_thickness, shuttle_height+shuttle_rail[2]-sheet_thickness-8] ) {
                rotate( [-angle,0,0] ) {
                    cube( shuttle_shelf );
                    translate( [(shuttle_shelf[0]-laser[0])/2,shuttle_shelf[1]-laser[1]-shelf_border,sheet_thickness] )
                    cube( laser );
                }
            }
        };
    };
}

module column() {
        // Add a lip on the column front for alignment.
    column_front = [column_width, sheet_thickness, column_height+2];
    
    echo( column_front=column_front );
    
    column_laser_x = laser_reveal + hb_75-hb_85 + laser_clearance + sheet_thickness;
    echo( column_laser_x=column_laser_x );
    
    echo( hb_85=hb_85 );
    
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
       
    //---------------------------------------------------------------
    translate( [0, 0, base_bottom] ) {
        // Compute the tabs to attach the supports to the base.
        x_max = column_support[len(column_support)-1][0];
        y_tab = column_support[len(column_support)-3][1] - sheet_thickness;
        x_tab = x_max - column_support[len(column_support)-3][0];
        a_tab = atan( y_tab / x_tab );
        
        echo( column_x=column_x );
        translate( [column_x,0,0] )
        cube( column_front );
    
        col_suppport_tab = [
            [0,0],
            [0,tab_height],
            [x_max - (tab_height - sheet_thickness)/tan(a_tab),tab_height],
            [x_max,sheet_thickness],
            [x_max,0],
        ];
        echo( "3x", col_suppport_tab=col_suppport_tab );
        
        column_support_spacing = (column_width - sheet_thickness) / 2;
        translate( [column_x, sheet_thickness, 0] ) {
            for( i = [0:2] ) {
                translate([i*column_support_spacing,0,0])
                rotate([90,0,90])
                linear_extrude(height=sheet_thickness)
                polygon(points=column_support);

                translate([i*column_support_spacing+(i==2?-sheet_thickness:sheet_thickness),0,0])
                rotate([90,0,90])
                linear_extrude(height=sheet_thickness)
                polygon(points=col_suppport_tab);
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
    
    horizontal_laser( column_x+column_width, column_support[3], column_support[2] );
}

// color( [1,1,1] )
column();
