include <params.scad>
include <lasercut/lasercut.scad>

module thickness_in_z( thickness ) {
	children();
}

module thickness_in_y( thickness ) {
	translate( [0, thickness, 0] )
	rotate( [90,0,0] )
	children();
}

module thickness_in_x( thickness ) {
	rotate( [90,0,90] )
	children();
}

module cutCube(cube,
        simple_tabs=[], simple_tab_holes=[], 
        captive_nuts=[], captive_nut_holes = [],
        finger_joints = [],
        bumpy_finger_joints = [],
        screw_tabs=[], screw_tab_holes=[],
        twist_holes=[], twist_connect=[],
        clips=[], clip_holes=[],
        circles_add = [],
        circles_remove = [],
        slits = [],
        cutouts = [],
        cutouts_vb = [],
        flat_adjust = [],
        milling_bit = milling_bit
) {
    transVal = cube[1] == sheet_thickness ? [0,sheet_thickness,0] : [0,0,0];
    rotVal = cube[0] == sheet_thickness ? [90,0,90] : cube[1] == sheet_thickness ? [90,0,0] : [0,0,0];
    
    values = [ for( v = cube ) if( v != sheet_thickness ) v ];
    
    translate( transVal )
    rotate( rotVal )
    lasercutoutSquare(
        thickness=sheet_thickness,
        x=values[0], y=values[1],
        simple_tabs = simple_tabs, 
        simple_tab_holes = simple_tab_holes, 
        captive_nuts = captive_nuts, 
        captive_nut_holes = captive_nut_holes,
        finger_joints = finger_joints,
        bumpy_finger_joints = bumpy_finger_joints,
        screw_tabs= screw_tabs, screw_tab_holes= screw_tab_holes,
        twist_holes=twist_holes, twist_connect=twist_connect,
        clips=clips, clip_holes=clip_holes,
        circles_add = circles_add,
        circles_remove = circles_remove,
        slits = slits,
        cutouts = cutouts,
        cutouts_vb = cutouts_vb,
        flat_adjust = flat_adjust,
        milling_bit = milling_bit
    );
}

module cutPoints(points,
        simple_tabs=[], simple_tab_holes=[], 
        captive_nuts=[], captive_nut_holes = [],
        finger_joints = [],
        bumpy_finger_joints = [],
        screw_tabs=[], screw_tab_holes=[],
        twist_holes=[], twist_connect=[],
        clips=[], clip_holes=[],
        circles_add = [],
        circles_remove = [],
        slits = [],
        cutouts = [],
        cutouts_vb = [],
        flat_adjust = [],
        milling_bit = milling_bit
) {
    lasercutout(
        thickness=sheet_thickness,
        points=points,
        simple_tabs = simple_tabs, 
        simple_tab_holes = simple_tab_holes, 
        captive_nuts = captive_nuts, 
        captive_nut_holes = captive_nut_holes,
        finger_joints = finger_joints,
        bumpy_finger_joints = bumpy_finger_joints,
        screw_tabs= screw_tabs, screw_tab_holes= screw_tab_holes,
        twist_holes=twist_holes, twist_connect=twist_connect,
        clips=clips, clip_holes=clip_holes,
        circles_add = circles_add,
        circles_remove = circles_remove,
        slits = slits,
        cutouts = cutouts,
        cutouts_vb = cutouts_vb,
        flat_adjust = flat_adjust,
        milling_bit = milling_bit
    );
}
