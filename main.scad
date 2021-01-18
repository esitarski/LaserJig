echo( "-----------------------------------------------" );
echo( "-----------------------------------------------" );

include <support.scad>

module bike_tt( x, y, z ) {
    m = 1.03;
    translate( [x,y,z] ) {
        translate( [1473,-228,-5] ) {
            scale( [m, m, m] )
            rotate( [90,0,180] ) {
                color([.5,.5,1])
                import("TT bike2012 - tt1a-1.STL");
                color([.2,.2,.2])
                import("TT bike2012 - tt1-brs-1.STL");
                color([150/255,75/255,0])
                import("TT bike2012 - tt1 saddle-1.STL");
                color([.5,.5,.5]) {
                import("TT bike2012 - crankspiderminimalleft-1.STL");
                import("TT bike2012 - crankspiderminimal 2-1.STL");
                }
            }
        }
    }
}

module man( x ) {
    //color([1,1,1,.9])
    //translate( [-1000,-1000,1960] )
    //cube( [4000,4000,2] );
    
    m = 1.08;
    translate([1450,-230,0])
//    rotate( [90,0,180] )
    rotate( [90,0,270] )
    translate([-800,0,0])
    scale([m,m,m])
    import("James.STL" );
}

bike_tt(bb_0-719-$t*160,base_width-sheet_thickness-channel_offset,base_bottom);
//man();