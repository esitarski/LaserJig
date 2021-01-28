sheet_thickness=18;				// thickness of the plywood sheet.

laser_width=20;					// width of the laser
laser_height=27;				// height of the laser
laser_origin_height=16;			// center of the laser beam
laser_length=60;				// length of the laser (includes cable allowance).
laser_spread_angle = 2*atan((110/2)/60);	// angle the laser spreads out from origin.

laser_setback        =  48.45*10;	// how much the laser is set back from the center of the bike.
laser_position_z     = 119.26*10;	// height of the laser center.
laser_position_angle =  24.51;		// angle the laser points down.

laser_low = 50;
laser_high=1350;

laser_y = laser_length;

wheel_width=30;					// maximum width of a wheel
wheel_height=670;				// height of a 700CC wheel.

handlebar_width_max = 500;
channel_offset = handlebar_width_max / 2 + 20;
channel_thickness = 50;

base_length=1500;

hb_85=50+laser_width/2;			// position of handlebar 85cm line (centered on laser)
hb_80=hb_85+50;					// position of handlebar 80cm line
hb_75=hb_80+50;					// position of handlebar 75cm line

bb_0=hb_75+750;					// position of bottom bracket line
bb_5=bb_0+50;					// position of bottom bracket +5cm line

// castor dimensions GD-60F (2" wheel, leveling castor).
castor_height = 82;
castor_radius = 61;
castor_plate = 73;

// bottom of the jig from the floor.
base_bottom = sheet_thickness + castor_height;

tab_height = 2*25.4;	// Height of the tabs to attach the column and back.

// utility functions.

function rotate_point(p,a) = [p[0]*cos(a) - p[1]*sin(a), p[0]*sin(a) + p[1]*cos(a)];

// output the sheet thickness so export.py knows how to created the files.
echo( sheet_thickness=sheet_thickness );


