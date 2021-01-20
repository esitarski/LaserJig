sheet_thickness=18;

laser_width=20;
laser_height=27;
laser_origin_height=16;
laser_length=60;
laser_spread_angle = 2*atan((110/2)/60);

laser_setback = 44.91*10;
laser_position_z = 122.73*10;
laser_position_angle = 26.51;

laser_low = 50;
laser_high=1350;

laser_y = laser_length;

wheel_width=30;
wheel_height=670;

handlebar_width_max = 500;
channel_offset = handlebar_width_max / 2 + 20;
channel_thickness = 50;

base_length=1500;

hb_85=50+laser_width/2;
hb_80=hb_85+50;
hb_75=hb_80+50;

bb_0=hb_75+750;
bb_5=bb_0+50;

castor_height = 82;
castor_radius = 80;
castor_plate = 36;

base_bottom = sheet_thickness + castor_height;

function rotate_point(p,a) = [p[0]*cos(a) - p[1]*sin(a), p[0]*sin(a) + p[1]*cos(a)];

echo( sheet_thickness=sheet_thickness );


