# LaserJig
Bike Jig using lasers.  Designed to be non-portable used in a fixed location (i.e. a velodrome).  The intent
is for riders to check their own bikes.  As such, the jig must be "bomb-proof" as it will be subject to
use and abuse, while remaining extremely accurate.

Plywood parts are then extracted from the OpenSCAD design via extract.py and output into dxf and svg files.
These files can then be used to drive a digital router that can cut the parts out of 19mm birch plywood.
Assembly is relatively straight-forward with biscuit joinery.  The design is somewhat assembly-friendly and is it
relatively easy to align the parts on all the critical dimensions just be pushing the boards together.

It is important that the router cuts are highly accurate - otherwise the jig will not go together.

The design is parameterized in all key dimensions.  It is easy to change for different sized laser modules etc.

Requires OpenSCAD and Python3.

The full design can be viewed in main.scad.  It includes the other module files.
