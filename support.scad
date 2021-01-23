include <body.scad>

support_brace_width_offset = 70;
support_brace_length_offset = castor_radius + castor_plate/2 + 10;
support_brace_height = castor_height - 20;

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
    
    horizonal_braces = 6;
    echo( "6x", width_brace_cube=width_brace_cube );
    
    width_brace_offset = (length_brace_cube[0] - sheet_thickness) / (horizonal_braces-1);
    
    for ( i = [0:horizonal_braces-1] ) {
       translate( [support_brace_length_offset+i*width_brace_offset,
            support_brace_width_offset+2*sheet_thickness,
            castor_height-support_brace_height] )
        cube( width_brace_cube );
    }
    
    // Castors
    for( x = [castor_plate, base_length-castor_plate] ) {
        for( y = [castor_plate, base_width-castor_plate] ) {
            translate( [x, y, castor_height/2] )
            cylinder(h = castor_height, r=castor_radius, center = true);
        }
    }
}

support();

