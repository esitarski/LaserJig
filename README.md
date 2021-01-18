# LaserJig
Bike Jig using lasers.  Designed to be used in a fixed location (i.e. a velodrome).
It is heavy and non-portable.
The intent is for riders to check their own bikes.  As such, the jig must be "bomb-proof" as it will be subject to
use and abuse while remaining extremely accurate.  Hence the use of contactless lasers.

Plywood parts are extracted from the OpenSCAD design via the extract.py script and written to dxf and svg files.
These files can be used by a digital router that can cut the parts out of 19mm birch plywood.
Assembly is relatively straight-forward with biscuit joinery.  The design is somewhat assembly-friendly and is it
relatively easy to align the parts on all the critical dimensions just be pushing the boards together.
Add dimensions are in millimeters.

It is important that the router makes highly accurate cuts otherwise the jig will not fit together.  However, it is possible to overcome some inaccuracies
by compensating in the final positioning of the lasers.

The design is parameterized in all key dimensions (see params.scad).  It is easy to change for different sized laser modules etc.

19mm birch plywood is a great material choice.  However, if you want to use a different plywood, just change sheet_thickness
in the params.scad file.  Be sure to measure the thickness accurately and convert to mm.

Requires OpenSCAD and Python3.

The full design can be viewed in main.scad.  It includes the other module files.
