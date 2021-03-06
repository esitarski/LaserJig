include <column.scad>

clamp_width = 330;

module wheel( x, y, z ) {
    translate([x,y,z])
    rotate([0,90,90])
    cylinder(h=wheel_width, d=wheel_height, center="true");
}

module tandem_extension( p, front ) {
    te_length = 600;
    te_width = channel_thickness * 2;
    te_base = [te_length, te_width, sheet_thickness];
    echo( te_base=te_base );
    te_rail = [te_length, channel_thickness-wheel_width/2, sheet_thickness];
    echo( "2x", te_rail=te_rail );
    te_under = [150, te_width, sheet_thickness];
    echo( te_under=te_under );
    te_over = [120, channel_thickness-wheel_width/2, sheet_thickness];
    echo( "2x", te_over=te_over );
    
    translate( p ) {
        mirror( [front ? 1 : 0, 0, 0] ) {
            cube( te_base );
            
            translate( [0, 0, sheet_thickness] ) {
                cube( te_rail );
                translate( [-20, 0, sheet_thickness] )
                cube( te_over );
            }
            
            translate( [0, te_width-te_rail[1], sheet_thickness] ) {
                cube( te_rail );
                translate( [-20, 0, sheet_thickness] )
                cube( te_over );
            }

            translate( [-50, 0, -sheet_thickness] )
            cube( te_under );
            
            translate( [te_length-50, te_width/2, -p[2]/2])
            cylinder( h=p[2], r=30, center=true );
        }
    }
}

module body() {
    // base
    base_cube = [base_length, base_width, sheet_thickness];
    echo( base_cube=base_cube );
        
    color( [1,0,0] )
    translate( [0,0,base_bottom-sheet_thickness] )
    cube( base_cube );
    
    // back
    back_cube = [base_length, sheet_thickness, back_height];
    
    // Split the back in half horizontally so both parts can be cut from a 4x8 sheet.
    back_1 = [back_cube[0], back_cube[1], back_cube[2]*0.75];
    echo( back_1=back_1 );
    
    back_2 = [back_cube[0], back_cube[1], back_cube[2]*0.25];
    echo( back_2=back_2 );
    
    color( [1,1,.5] )
    translate( [0,base_width-sheet_thickness-5,base_bottom] )
    cube( back_2 );
    
    color( [1,1,1] )
    translate( [0,base_width-sheet_thickness,base_bottom] )
    cube( back_cube );
    
    // back braces
    // hb braces
    back_brace_hb_thickness = channel_offset/4;
    back_brace_hb_y1 = wheel_height*2/3;
    back_brace_hb_y2 = wheel_height*1/4;
    back_brace_hb = [
        [0,0],
        [0,wheel_height-100+20],
        [back_brace_hb_thickness,back_brace_hb_y1],
        [back_brace_hb_thickness,back_brace_hb_y2],
        [channel_offset-channel_thickness, sheet_thickness],
        [channel_offset-channel_thickness, 0],
    ];
    echo( "2x", back_brace_hb=back_brace_hb );

    x_max_hb = back_brace_hb[len(back_brace_hb)-1][0];
    y_tab_hb = back_brace_hb[len(back_brace_hb)-3][1] - sheet_thickness;
    x_tab_hb = x_max_hb - back_brace_hb[len(back_brace_hb)-3][0];
    a_tab_hb = atan( y_tab_hb / x_tab_hb );
    back_brace_hb_tab = [
        [0,0],
        [0,tab_height],
        [channel_offset-channel_thickness - (tab_height - sheet_thickness)/tan(a_tab_hb), tab_height],
        [channel_offset-channel_thickness, sheet_thickness],
        [channel_offset-channel_thickness, 0],
    ];
    echo( "2x", back_brace_hb_tab=back_brace_hb_tab );
    
    color( [1,1,1] ) {
        for( x = [0, column_x] ) {
            translate([x+sheet_thickness,
                base_width-sheet_thickness,
                base_bottom])
            rotate([90,0,-90])
            linear_extrude( height=sheet_thickness )
            polygon( points=back_brace_hb );
            
            translate([x+(x==0?+sheet_thickness*2:0),
                base_width-sheet_thickness,
                base_bottom])
            rotate([90,0,-90])
            linear_extrude( height=sheet_thickness )
            polygon( points=back_brace_hb_tab );
        }
    }
    
    // hb braces struts.
    back_stiffener_thickness = 80;
    hb_brace_pad = [
        sheet_thickness,
        back_stiffener_thickness,
        back_stiffener_thickness
    ];
    echo( "2x", hb_brace_pad=hb_brace_pad );
    hb_brace_strut = [
        sheet_thickness,
        back_stiffener_thickness,
        back_stiffener_thickness + tab_height,
    ];
    echo( "2x", hb_brace_strut=hb_brace_strut );
    
    color( [1,0,0] ) {
        translate( [sheet_thickness, base_width-sheet_thickness-back_stiffener_thickness,
        base_bottom+tab_height] )
        cube( hb_brace_pad );

        translate( [sheet_thickness*2, base_width-sheet_thickness-back_stiffener_thickness,
        base_bottom] )
        cube( hb_brace_strut );
        
        translate( [column_x-sheet_thickness, base_width-sheet_thickness-back_stiffener_thickness,
        base_bottom+tab_height] )
        cube( hb_brace_pad );

        translate( [column_x-sheet_thickness*2, base_width-sheet_thickness-back_stiffener_thickness,
        base_bottom] )
        cube( hb_brace_strut );

    }
    
    // bb braces
    clamp_y = base_width-sheet_thickness-channel_offset-channel_thickness - wheel_width/2;
    clamp_length = base_width-clamp_y-sheet_thickness;
    clamp_height = base_bottom + wheel_height;
    
    back_brace_bb_thickness = channel_offset/3;
    back_brace_bb = [
        [0,0],
        [0,wheel_height],
        [clamp_length/2-sheet_thickness,wheel_height],
        [back_brace_bb_thickness,wheel_height*3/4],
        [back_brace_bb_thickness,wheel_height*1/4],
        [channel_offset-channel_thickness, sheet_thickness],
        [channel_offset-channel_thickness, 0],
    ];
    echo( "2x", back_brace_bb=back_brace_bb );
    
    x_max_bb = back_brace_bb[len(back_brace_bb)-1][0];
    y_tab_bb = back_brace_bb[len(back_brace_bb)-3][1] - sheet_thickness;
    x_tab_bb = x_max_bb - back_brace_bb[len(back_brace_bb)-3][0];
    a_tab_bb = atan( y_tab_bb / x_tab_bb );
    back_brace_bb_tab = [
        [0,0],
        [0,tab_height],
        [channel_offset-channel_thickness - (tab_height - sheet_thickness)/tan(a_tab_bb), tab_height],
        [channel_offset-channel_thickness, sheet_thickness],
        [channel_offset-channel_thickness, 0],
    ];
    echo( "2x", back_brace_bb_tab=back_brace_bb_tab );
    
    color( [1,1,1] ) {
        for( x = [base_length-sheet_thickness,base_length-clamp_width] ) {
            translate([x+sheet_thickness,
                base_width-sheet_thickness,
                base_bottom])
            rotate([90,0,-90])
            linear_extrude( height=sheet_thickness )
            polygon( points=back_brace_bb );

            translate([x+(x==base_length-clamp_width?+sheet_thickness*2:0),
                base_width-sheet_thickness,
                base_bottom])
            rotate([90,0,-90])
            linear_extrude( height=sheet_thickness )
            polygon( points=back_brace_bb_tab );

        }
    }
    
    // channels.
    channel_cube = [base_length, channel_thickness-wheel_width/2, sheet_thickness];
    echo( "2x", channel_cube=channel_cube );
    
    color( [1,1,1] ) {
        translate( [0, base_width-sheet_thickness-channel_offset-channel_thickness, base_bottom] )
        cube( channel_cube );
        
        translate( [0, base_width-sheet_thickness-channel_offset+wheel_width/2, base_bottom] )
        cube( channel_cube );
    }
    
    //-------------------------------------------------------
    // back wheel clamp.
    color([0,.7,.7,1]) {
        
        //-----------------------------------
        bike_clamp_support = [clamp_width, clamp_length/2, sheet_thickness];
        echo( bike_clamp_support=bike_clamp_support );
        translate( [base_length-clamp_width, clamp_y+clamp_length/2, clamp_height] )
        cube( bike_clamp_support );
        
        //-----------------------------------
        bike_clamp = [clamp_width, clamp_length/2, sheet_thickness];
        echo( bike_clamp=bike_clamp );
        
        translate( [base_length-clamp_width, clamp_y, clamp_height] )
        cube( bike_clamp );
        
        //-----------------------------------
       bike_clamp_channel = [clamp_width, channel_thickness, sheet_thickness];
        echo( "2x", bike_clamp_channel=bike_clamp_channel );
        
        // Bike clamp channels.
        translate( [base_length-clamp_width,clamp_y,clamp_height-sheet_thickness] )
        cube( bike_clamp_channel );
        
        translate( [base_length-clamp_width,clamp_y+channel_thickness+wheel_width,clamp_height-sheet_thickness] )
        cube( bike_clamp_channel );

    };
    
    // colored indicators.
    translate( [0, base_width-sheet_thickness-1, base_bottom] )
    color( [1,0,0] )
    cube( [hb_85-0, 1, back_height] );
    
    translate( [hb_85, base_width-sheet_thickness-1, base_bottom] )
    color( [1,.75,0] )
    cube( [hb_80-hb_85, 1, back_height] );

    translate( [hb_80, base_width-sheet_thickness-1, base_bottom] )
    color( [1,1,0] )
    cube( [hb_75-hb_80, 1, back_height] );

    translate( [hb_75, base_width-sheet_thickness-1, base_bottom] )
    color( [0,1,0] )
    cube( [150, 1, back_height] );

    translate( [bb_0-150, base_width-sheet_thickness-1, base_bottom] )
    color( [1,0,0] )
    cube( [150, 1, back_height] );
    
    translate( [bb_0, base_width-sheet_thickness-1, base_bottom] )
    color( [1,1,0] )
    cube( [bb_5-bb_0, 1, back_height] );
    
    translate( [bb_5, base_width-sheet_thickness-1, base_bottom] )
    color( [0,1,0] )
    cube( [150, 1, back_height] );
    
    // tandem extension
    tandem_extension( [base_length,base_width-sheet_thickness-channel_offset-channel_thickness,base_bottom-sheet_thickness], false );
    tandem_extension( [0,base_width-sheet_thickness-channel_offset-channel_thickness,base_bottom-sheet_thickness], true );
}

body();

if( 0 ) {
    for( x = [wheel_height/2+base_bottom, wheel_height/2+base_bottom+1000] ) {
        wheel(
            x,
            base_width-sheet_thickness-channel_offset-wheel_width/2,
            wheel_height/2+base_bottom );
    }
}