
sheet_thickness = 19;
laser_height = 26;
laser_width = 20;
laser_length = 50;

module laser_clamp( p ) {
    clearance = 10;
    clamp_thickness = clearance - 1;
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
        color( [1,1,1] )
        translate( [0,0,0] )
        translate( [-pad_middle,sheet_thickness,0] )
        rotate( [90,0,0] )
        linear_extrude( height=sheet_thickness )
        polygon( laser_clamp_points );
        
        color( [1,.5,0] )
        translate( [-laser_width/2, 0, 0] )
        cube( [laser_width, laser_length, laser_height] );
    }
}

laser_clamp( [0,0,0] );
laser_clamp( [50,0,0] );
translate( [0, laser_length, 0] )
rotate( [0,0,180] )
laser_clamp( [50,0,0] );