use <lasercut/lasercut.scad>;
$fn=60;
module flat(){
projection(cut = false)

lasercutout(thickness = 18, 
          points = [[0, 0], [940, 0], [940, 60], [0, 60], [0, 0]]
        , circles_remove = [[14.45, 610, 30]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [976, 0], [976, 78], [0, 78], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [940, 0], [940, 20], [0, 20], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [78, 0], [78, 55], [0, 55], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [78, 0], [78, 55], [0, 55], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [710, 0], [710, 37], [0, 37], [0, 0]]
        , circles_remove = [[10, 395, 18.5], [10, 415, 18.5]]
        , cutouts = [[395, 8.5, 20, 20]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [710, 0], [710, 37], [0, 37], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [420, 0], [420, 1103.95], [0, 1103.95], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 1101.95], [68.2203, 1064.14], [191.088, 201], [248.415, 100.5], [427.72, 18], [427.72, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 50.8], [356.433, 50.8], [427.72, 18], [427.72, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 1101.95], [68.2203, 1064.14], [191.088, 201], [248.415, 100.5], [427.72, 18], [427.72, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 50.8], [356.433, 50.8], [427.72, 18], [427.72, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 1101.95], [68.2203, 1064.14], [191.088, 201], [248.415, 100.5], [427.72, 18], [427.72, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 50.8], [356.433, 50.8], [427.72, 18], [427.72, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [183, 0], [183, 191.088], [0, 191.088], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [183, 0], [183, 129.654], [0, 129.654], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [183, 0], [183, 191.088], [0, 191.088], [0, 0]]
        , circles_remove = [[17, 91.5, 35]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [183, 0], [183, 129.654], [0, 129.654], [0, 0]]
        , circles_remove = [[17, 91.5, 35]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [183, 0], [183, 427.818], [0, 427.818], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [36, 0], [36, 427.818], [0, 427.818], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [36, 0], [36, 427.818], [0, 427.818], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [55.05, 0], [55.05, 130], [0, 130], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [75, 0], [75, 103.05], [0, 103.05], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [75, 0], [75, 100], [0, 100], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [75, 0], [75, 85], [0, 85], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1500, 0], [1500, 784.461], [0, 784.461], [0, 0]]
        , circles_remove = [[17, 645, 155]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1500, 0], [1500, 317.716], [0, 317.716], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1500, 0], [1500, 953.148], [0, 953.148], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 590], [18, 590], [67.5, 489.1], [67.5, 100.5], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 50.8], [159.37, 50.8], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 590], [18, 590], [67.5, 489.1], [67.5, 100.5], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 50.8], [159.37, 50.8], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 670], [150.5, 670], [150.5, 602], [90, 569.5], [90, 100.5], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 50.8], [168.315, 50.8], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 670], [150.5, 670], [150.5, 602], [90, 569.5], [90, 100.5], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [0, 50.8], [168.315, 50.8], [220, 18], [220, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1500, 0], [1500, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1500, 0], [1500, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [330, 0], [330, 168.5], [0, 168.5], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [330, 0], [330, 168.5], [0, 168.5], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [330, 0], [330, 50], [0, 50], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [330, 0], [330, 50], [0, 50], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [245, 0], [245, 50], [0, 50], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [245, 0], [245, 50], [0, 50], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [40, 0], [40, 40], [0, 40], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [600, 0], [600, 100], [0, 100], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [600, 0], [600, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [120, 0], [120, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [600, 0], [600, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [120, 0], [120, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [150, 0], [150, 100], [0, 100], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [600, 0], [600, 100], [0, 100], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [600, 0], [600, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [120, 0], [120, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [600, 0], [600, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [120, 0], [120, 33], [0, 33], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [150, 0], [150, 100], [0, 100], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1300, 0], [1300, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1300, 0], [1300, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [1300, 0], [1300, 39], [0, 39], [0, 0]]
        , circles_remove = [[10, 540, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [530.461, 0], [530.461, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [530.461, 0], [530.461, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [530.461, 0], [530.461, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [530.461, 0], [530.461, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [530.461, 0], [530.461, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [530.461, 0], [530.461, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [530.461, 0], [530.461, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [195.667, 0], [195.667, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [195.667, 0], [195.667, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [195.667, 0], [195.667, 39], [0, 39], [0, 0]]
        , circles_remove = [[10, 97.8333, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [195.667, 0], [195.667, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [195.667, 0], [195.667, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

lasercutout(thickness = 18, 
          points = [[0, 0], [195.667, 0], [195.667, 39], [0, 39], [0, 0]]
        , milling_bit = 10
        ) 

;
}

flat();
