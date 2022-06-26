import re
import sys
import subprocess

version = '2'

svg_fname = 'main-2d-{}.svg'.format( version )
dxt_fname = 'main-2d-{}.dxt'.format( version )
svg_prenest_fname = 'main-2d-prenest-{}.svg'.format( version )

get_svg = True
if get_svg:
	subprocess.run([sys.executable, "convert-2d.py", "main.scad", svg_fname])
	subprocess.run([sys.executable, "convert-2d.py", "main.scad", dxt_fname])

subprocess.run([sys.executable, "export.py"])

print( 'adding full sheets to svg file...' )
with open(svg_fname) as f:
	svg = f.read()
	width = int(re.search( 'width="([0-9]+)mm', svg ).group(1))
	height = int(re.search( 'height="([0-9]+)mm', svg ).group(1))
	path = re.search( '<path d="\n([^"]*)"', svg ).group(1)
	
# Full sheet of 4'x8' plywood
sheet_width = 4*12*25.4
sheet_height = 8*12*25.4
sheet_count = 3

sheet_width, sheet_height = sheet_height, sheet_width

vspace = 100

height += (sheet_height + vspace) * sheet_count
width = max( width, sheet_width )

sheet_svg = []
top = -(height-0.1)
for i in range(sheet_count):
	bottom = top + sheet_height
	sheet_svg.append( 'M {width},{top} L 0,{top} L 0,{bottom} L {width},{bottom} z'.format( width=sheet_width, top=top, bottom=bottom ) )
	top += sheet_height + vspace

path = '\n'.join( sheet_svg ) + path

# Sequence each object by decreasing bounding box area.
shapes = [s.strip() for s in path.split( 'z' ) if s.strip()]
def get_area_2( shape ):
	first_line = shape.split( '\n', 3 )[0]
	numbers = [float(n) for n in re.sub( '[^0-9.-]', ' ', first_line ).split()]
	pairs = zip(numbers, numbers[1:])
	print( first_line, numbers )
	x_min, y_min = next(pairs)
	x_max, y_max = x_min, y_min
	for x, y in pairs:
		x_min, x_max = min( x_min, x ), max( x_max, x )
		y_min, y_max = min( y_min, y ), max( y_max, y )
	return (x_max - x_min)**2 + (y_max - y_min)**2
	
shapes.sort( key=get_area_2, reverse=True )
shapes.append( '' )
path = ' z\n'.join( shapes )

with open(svg_prenest_fname, 'w') as f:
	header = '''<?xml version="1.0" standalone="no"?>
	<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
	<svg width="{width}mm" height="{height}mm" viewBox="0 -{height} {width} {height}" xmlns="http://www.w3.org/2000/svg" version="1.1">
	<title>OpenSCAD Model Nested</title>
	<path d="\n'''.format( width=width, height=height )
	f.write( header )
	f.write( path )
	footer = '''" stroke="black" fill="lightgray" stroke-width="0.5"/>
	</svg>'''
	f.write( footer )
