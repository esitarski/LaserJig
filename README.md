# LaserJig

![LaserJig Rendering](https://github.com/esitarski/LaserJig/blob/main/main.png?raw=true)

Bike Jig using lasers.  Designed to be used in a fixed location (i.e. a velodrome).
It is heavy and non-portable (about 70kg - 150lbs).
The jig is designed to be "bomb-proof" as it will be subject to
daily abuse while remaining extremely accurate.  Lasers are used for the measuring as they are accurate and contactless.

Updated for the equipment UCI rule changes effective Jan 1, 2023.
In particular, this requires an additional vertical line at 83cm forward of the bottom bracket.

The OpenSCAD files use the lasercut library to output the polygons for the plywood parts via the "prenest.py" script.
A labeled dimensioned parts list is also created main-2d-parts-list.txt.  This makes it easier to determine what all the parts are from their dimentions.

The main-2d-prenest.svg file can be further processed using [Deepnest.io](//https://deepnest.io//) to nest the parts (10mm milling bit separation).
The 3-sheet layout is then processed to create .dxf files that can be processed by a CNC router.

Assembly is relatively straight-forward with biscuit joinery.  The design has a number of assembly-friendly features including some
features to make it easier to orient the parts at assembly.

The laser modules are held in place with aluminum angle and screws which make it possible to fine-tune the accuracy during assembly.
Some critial dimensions are also echoed in the OPENScad output, for example, the position of the column and laser module.

It is important that your CNC router makes highly accurate cuts otherwise the jig will not fit together properly.
Some inaccuracies can be overcome in the final positioning of the lasers.

The design is parameterized in all key dimensions (see params.scad).  It is easy to change for different sized laser modules etc.
Add dimensions are in millimeters.

18mm Birch Plywood is recommended for stability and toughness.  However, if you wish to use a different plywood, just change "sheet_thickness"
in the params.scad file.  All aspects of the design will adjust appropriately.
Be sure to measure the thickness of your material accurately and make sure to express it in mm.

Requires OpenSCAD and Python3 (see requirements.txt for dependent Python modules).

The full design can be viewed in main.scad.  It includes the other module files as required.
