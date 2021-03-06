# LaserJig

![LaserJig Rendering](https://github.com/esitarski/LaserJig/blob/main/main.png?raw=true)

Bike Jig using lasers.  Designed to be used in a fixed location (i.e. a velodrome).
It is heavy and non-portable.
The intent is for riders to check their own bikes.  As such, the jig must be "bomb-proof" as it will be subject to
daily abuse while remaining extremely accurate.  Lasers are used for the measuring as they are accurate and contactless.

The OpenSCAD files contain "echo" statements that output the polygons for the plywood parts.
The shapes are extracted from OpenSCAD via "export.py" and written to dxf and svg files.

The LaserJigSheet.svg file is further processed using [Deepnest.io](//https://deepnest.io//) to nest the parts (10mm separation).
The 3-sheet layout is then processed to create .dxf files that can be processed by a CNC router.

Assembly is relatively straight-forward with biscuit joinery.  The design has a number of assembly-friendly features including lips and
alignment points to make it easier to line up the parts at assembly.
The laser modules are held in place with adjustable clamps which make it possible to fine-tune the accuracy during assembly.
Some critial assembly dimensions are also output including the position of the column and laser module.

It is important that your CNC router makes highly accurate cuts otherwise the jig will not fit together.
Some inaccuracies can be overcome in the final positioning of the lasers.

The design is parameterized in all key dimensions (see params.scad).  It is easy to change for different sized laser modules etc.
Add dimensions are in millimeters.

18mm birch plywood is a great material choice.  However, if you wish to use a different plywood, just change "sheet_thickness"
in the params.scad file.  All aspects of the design will adjust appropriately.
Be sure to measure the thickness of your material accurately and make sure to express it in mm.

Requires OpenSCAD and Python3.

The full design can be viewed in main.scad.  It includes the other module files.
