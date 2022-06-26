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
            cutCube( te_base );
            
            translate( [0, 0, sheet_thickness] ) {
                cutCube( te_rail );
                translate( [-20, 0, sheet_thickness] )
                cutCube( te_over );
            }
            
            translate( [0, te_width-te_rail[1], sheet_thickness] ) {
                cutCube( te_rail );
                translate( [-20, 0, sheet_thickness] )
                cutCube( te_over );
            }

            translate( [-50, 0, -sheet_thickness] )
            cutCube( te_under );
            
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
    cutCube( base_cube, circles_remove=[[plug_diameter/2, 645, 155]] );
    
    // back
    back_cube = [base_length, sheet_thickness, back_height];
    
    // Split the back in half horizontally so both parts can be cut from a 4x8 sheet.
    back_1 = [back_cube[0], back_cube[1], back_cube[2]*0.75];
    echo( back_1=back_1 );
    
    back_2 = [back_cube[0], back_cube[1], back_cube[2]*0.25];
    echo( back_2=back_2 );
    
    translate( [0, base_width-sheet_thickness-3, base_bottom] ) {
        color( [1,1,.5] )
        cutCube( back_2 );
        
        translate( [0, 3, back_2[2]] ) {
            color( [1,1,1] )
            cutCube( back_1 );
        }
    }
    
    // back braces
    // hb braces
    back_brace_hb_thickness = channel_offset/4;
    back_brace_hb_y1 = wheel_height*0.73;
    back_brace_hb_y2 = wheel_height*0.15;
    back_brace_hb = [
        [0,0],
        [0,wheel_height-80],
        [sheet_thickness,wheel_height-80],
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
            cutPoints( back_brace_hb );
            
            translate([x+(x==0?+sheet_thickness*2:0),
                base_width-sheet_thickness,
                base_bottom])
            rotate([90,0,-90])
           cutPoints( back_brace_hb_tab );
        }
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
        [clamp_length/2-sheet_thickness,wheel_height-50-sheet_thickness],
        [back_brace_bb_thickness,wheel_height*0.85],
        [back_brace_bb_thickness,wheel_height*0.15],
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
            cutPoints( back_brace_bb );

            translate([x+(x==base_length-clamp_width?+sheet_thickness*2:0),
                base_width-sheet_thickness,
                base_bottom])
            rotate([90,0,-90])
            cutPoints( back_brace_bb_tab );

        }
    }
    
    // channels.
    channel_cube = [base_length, channel_thickness-wheel_width/2, sheet_thickness];
    echo( "2x", channel_cube=channel_cube );
    
    color( [1,1,1] ) {
        translate( [0, base_width-sheet_thickness-channel_offset-channel_thickness, base_bottom] )
        cutCube( channel_cube );
        
        translate( [0, base_width-sheet_thickness-channel_offset+wheel_width/2, base_bottom] )
        cutCube( channel_cube );
    }
    
    //-------------------------------------------------------
    // back wheel clamp.
    color([0,.7,.7,1]) {
        
        //-----------------------------------
        bike_clamp_support = [clamp_width, clamp_length/2, sheet_thickness];
        echo( bike_clamp_support=bike_clamp_support );
        translate( [base_length-clamp_width, clamp_y+clamp_length/2, clamp_height] )
        cutCube( bike_clamp_support );
        
        //-----------------------------------
        bike_clamp = [clamp_width, clamp_length/2, sheet_thickness];
        echo( bike_clamp=bike_clamp );
        
        translate( [base_length-clamp_width, clamp_y, clamp_height] )
        cutCube( bike_clamp );
        
        //-----------------------------------
        bike_clamp_channel = [clamp_width, channel_thickness, sheet_thickness];
        echo( "2x", bike_clamp_channel=bike_clamp_channel );
        
        // Bike clamp channels.
        translate( [base_length-clamp_width,clamp_y,clamp_height-sheet_thickness] )
        cutCube( bike_clamp_channel );
        
        translate( [base_length-clamp_width,clamp_y+channel_thickness+wheel_width,clamp_height-sheet_thickness] )
        cutCube( bike_clamp_channel );
    }

    color([0,.7,0,1]) {
        // Bike clamp tabs.
        bike_clamp_tab = [sheet_thickness, channel_offset-wheel_width/2-8, 50];
        echo( "2x", bike_clamp_tab=bike_clamp_tab );
        
        translate([base_length-sheet_thickness*2,base_width-bike_clamp_tab[1]-sheet_thickness,clamp_height-bike_clamp_tab[2]-sheet_thickness])
        rotate( [3,0,00] )
        cutCube( bike_clamp_tab );
        
        translate([base_length-clamp_width+sheet_thickness,base_width-bike_clamp_tab[1]-sheet_thickness,clamp_height-bike_clamp_tab[2]-sheet_thickness])
        rotate( [3,0,00] )
        cutCube( bike_clamp_tab );
        
    };
    
    // Brace tab
    tab_block =  [sheet_thickness,40,40];
    echo( tab_block=tab_block );
    color([0,1,1]) {
        translate( [base_length-clamp_width, base_width-tab_block[1]-back_brace_bb_tab[2][0]+1.25*sheet_thickness, clamp_height-tab_block[2]-sheet_thickness] )
        cutCube( [sheet_thickness,40,40] );
    }
    
    // colored background.
    translate( [0, base_width-sheet_thickness-1, base_bottom] )
    color( [1,0,0] )
    cube( [hb_85-0, 1, back_height] );
    
    translate( [hb_85, base_width-sheet_thickness-1, base_bottom] )
    color( [1,.5,0] )
    cube( [hb_83-hb_85, 1, back_height] );

    translate( [hb_83, base_width-sheet_thickness-1, base_bottom] )
    color( [1,.75,0] )
    cube( [hb_80-hb_83, 1, back_height] );

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
    
    // tandem extensions
    tandem_extension( [base_length,base_width-sheet_thickness-channel_offset-channel_thickness,base_bottom-sheet_thickness], false );
    tandem_extension( [0,base_width-sheet_thickness-channel_offset-channel_thickness,base_bottom-sheet_thickness], true );
    
    // Seat elevation indicator.
    //color( [0,0,1,.25] )
    //translate( [0, base_width-channel_offset-channel_thickness/2, base_bottom] )
    //cube( [base_length, sheet_thickness, 1200] );
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