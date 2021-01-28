include <body.scad>

support_x = round(castor_plate/2 + castor_radius * cos(45));
support_brace_width_offset = support_x + 10;
support_brace_length_offset = support_brace_width_offset;
support_brace_height = castor_height-44;  // ground clearance.

module support() {
    // Length braces.  Note we double-up on the front.
    length_brace_cube = [
        base_length-support_brace_length_offset*2,
        sheet_thickness,
        support_brace_height
    ];
    echo( "3x", length_brace_cube=length_brace_cube );
    
    for( y=[support_brace_width_offset,
            support_brace_width_offset + sheet_thickness,
            base_width-support_brace_width_offset-sheet_thickness] ) {
        translate( [support_brace_length_offset,
            y,
            castor_height-support_brace_height] )
        cube( length_brace_cube );
    }
    
    // Width braces.
    width_brace_cube = [
        sheet_thickness,
        base_width - support_brace_width_offset*2 - sheet_thickness*3,
        support_brace_height
    ];
    
    horizonal_braces = 7;
    echo( "7x", width_brace_cube=width_brace_cube );
    
    width_brace_offset = (length_brace_cube[0] - sheet_thickness) / (horizonal_braces-1);
    
    for ( i = [0:horizonal_braces-1] ) {
       translate( [support_brace_length_offset+i*width_brace_offset,
            support_brace_width_offset+2*sheet_thickness,
            castor_height-support_brace_height] )
        cube( width_brace_cube );
        
        echo( "support_brace_x", support_brace_length_offset+i*width_brace_offset );
    }
    
    // Castors
    for( x = [castor_plate/2, base_length-castor_plate/2] ) {
        for( y = [castor_plate/2, base_width-castor_plate/2] ) {
            translate( [x, y, castor_height/2] )
            cylinder(h = castor_height, r=castor_radius, center = true);
        }
    }
}

support();

