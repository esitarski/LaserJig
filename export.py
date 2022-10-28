import os
import re
import sys
import shutil
import operator
from collections import defaultdict
from subprocess import Popen, DEVNULL, PIPE
import ezdxf
import svgwrite

def is_line( coords ):
	if len(coords) != 4:
		return False
	
	upper_left = coords[2]
	lower_right = coords[0]

	# Check that the rectangle is the right thickness to be a line.
	if not( abs(lower_right[0] - upper_left[0]) == 0.5 or abs(lower_right[1] - upper_left[1]) == 0.5 ):
		return False

	# Check that all the lines are co-linear.
	return (
		coords[0][1] == coords[1][1] and
		coords[1][0] == coords[2][0] and
		coords[2][1] == coords[3][1] and
		coords[3][0] == coords[0][0]
	)

def squares_to_lines( svg_fname ):
	print( 'converting squares to lines...' )
	#-------------------------------------------------------------------
	# This is a bit hacky ;)
	#
	# Look for rectangles that have a width or height of 0.5.
	# Convert those to svg lines instead of shapes.
	#
	with open(svg_fname) as f:
		svg = f.read()
		width = int(re.search( 'width="([0-9]+)mm', svg ).group(1))
		height = int(re.search( 'height="([0-9]+)mm', svg ).group(1))
		path = re.search( '<path d="\n([^"]*)"', svg ).group(1)
		
	# Convert indicator lines from squares to lines.
	shapes = []
	lines = []
	for s in path.split( 'z' ):
		s = s.strip()
		if not s:
			continue
		if s.count('L') == 3:
			# This is a rectangle.  Parse the coordinates.
			shape = re.sub('[^-0-9,.]+',' ',s)
			#print( shape )
			coords = [tuple([float(cc) for cc in coord.split(',')]) for coord in shape.split()]
			#print( coords )
			
			# Check that the rectangle is the right thickness to be a line.
			if not is_line(coords):
				shapes.append( s )
				continue
			
			upper_left = coords[2]
			lower_right = coords[0]

			if abs(lower_right[0] - upper_left[0]) > abs(lower_right[1] - upper_left[1]):
				# Horizontal line
				x1 = upper_left[0]
				x2 = lower_right[0]
				y1 = y2 = (lower_right[1] + upper_left[1]) / 2
			else:
				# Vertical line.
				y1 = lower_right[1]
				y2 = upper_left[1]
				x1 = x2 = (lower_right[0] + upper_left[0]) / 2
			
			lines.append( '<line x1="{x1}" y1="{y1}" x2="{x2}" y2="{y2}" stroke="black" stroke-width="0.5" />'.format( x1=x1, y1=y1, x2=x2, y2=y2 ) )
		else:
			shapes.append( s )
			
	shapes.append( '' )	
	path = ' z\n'.join( shapes )
	
	lines.append( '' )

	with open(svg_fname, 'w') as f:
		header = '''<?xml version="1.0" standalone="no"?>
		<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
		<svg width="{width}mm" height="{height}mm" viewBox="0 -{height} {width} {height}" xmlns="http://www.w3.org/2000/svg" version="1.1">
		<title>OpenSCAD Model Nested</title>
		<path d="\n'''.format( width=width, height=height )
		f.write( header )
		f.write( path )
		f.write( '" stroke="black" fill="lightgray" stroke-width="0.5"/>\n' )
		f.write( '\n'.join(lines) )
		f.write( '</svg>' )

# Create the 2-d SVG files for the HandlebarGauge
for name in ('HandlebarGauge', 'HandlebarGaugeManual'):
	fname = '{}.scad'.format( name )
	for draw in ('scoring', 'cutting'):
		fname_svg = '{}-{}.svg'.format( name, draw )
		cmd = ['openscad', fname, '-D', 'draw="{}"'.format(draw), '-o', fname_svg]
		print( cmd )
		proc = Popen( cmd, stdout=PIPE, stderr=PIPE )
		out, err = proc.communicate()
		if out or err:
			print( out, err )
		
		squares_to_lines( fname_svg )

# Create a 3-d rendering.  This also extracts the shapes from the "echo" statements.
cmd = ['openscad', 'main.scad', '-o', 'main.png']

sheet_thickness = 0		# This comes from the scad file.

board_height, board_width = 8*12*25.4, 4*12*25.4

count = defaultdict( int )
polys = {}

def cube_to_points( cube ):
	points = [v for v in cube if v != sheet_thickness]
	while len(points) < 2:
		points.append( sheet_thickness )
	x, y = points
	return ((0,0), (x,0), (x,y), (0,y))

# Extract the model information from the scad file.
proc = Popen( cmd, stdout=PIPE, stderr=PIPE )
out, err = proc.communicate()

# Parse the lines to get the polygons.
# Convert cubes to polygons.
# Also, keep track of the count of each polygon.
for line in err.decode().split('\n'):
	if line.startswith('ECHO:') and '=' in line:
		line = line[5:].strip()
		if line.startswith('"'):
			repeat, line = line.split('", ', 2)
			try:
				repeat = int( re.sub('[^0-9]', '', repeat) )
			except ValueError:
				continue
		else:
			repeat = 1
		try:
			k, v = [s.strip() for s in line.split( '=' )]
		except ValueError:
			continue
		
		v = eval( v.replace('[','(').replace(']',')') )
		if k == 'sheet_thickness':
			sheet_thickness = v
		elif isinstance(v, tuple):		
			if k.endswith('_cube'):
				k = k[:-5]
			if k.endswith('_points'):
				k = k[:-7]
			
			if not isinstance( v[0], tuple ):
				assert len(v) == 3, 'Object must be a cube or list of points.'
				v = cube_to_points( v )
			
			polys[k] = v
			count[k] += repeat

for label, points in polys.items():
	print( '{}[{}]: {}'.format( label, count[label], points ) )

def approx_poly_area( points ):
	return max(x for x,y in points) * max(y for x,y in points)

'''
#-----------------------------------------------------------------------
# Save all polygons in one dxf format.
#
doc = ezdxf.new()
doc.units = 4	# mm

msp = doc.modelspace()

x_cur = y_cur = 0
def to_poly_dxf( msp, label, points ):
	global x_cur, y_cur
	dxf_points = [(x_cur + x, y_cur + y) for x, y in points]
	p = msp.add_lwpolyline( dxf_points )
	p.close( True )
	x_cur = max( x for x,y in dxf_points ) + 20
	return p

for k,v in sorted( polys.items(), key=lambda e: approx_poly_area(e[1]), reverse=True ):
	for c in range(count[k]):
		to_poly_dxf( msp, '{}_{}'.format(k,c+1), v )
doc.saveas('LaserJig.dxf')

#-----------------------------------------------------------------------
# Save all polygons in dxf format, one file for each, in a directory.
#
target_dir = 'dxf_files'
shutil.rmtree( target_dir, ignore_errors=True )
	
os.mkdir( target_dir )
for k,v in sorted( polys.items(), key=lambda e: approx_poly_area(e[1]), reverse=True ):

	for c in range(count[k]):
		doc = ezdxf.new()
		doc.units = 4	# mm
		msp = doc.modelspace()
		x_cur = y_cur = 0
		to_poly_dxf( msp, '{}_{}'.format(k,c+1), v )
		fname = '{}_{}.dxf'.format(k, c+1) if count[k] > 1 else '{}.dxf'.format(k)
		print( k, c, count[k], fname )
		doc.saveas( os.path.join(target_dir, fname) )

#-----------------------------------------------------------------------
# Save all polygons in one svg file.
#
def to_poly_svg( dwg, label, points ):
	global x_cur, y_cur
	y_max = max( y for x,y in points )
	x_max = max( x for x,y in points )
	if x_max > y_max:
		svg_points = [(y + x_cur, x_max - x + y_cur) for x, y in points]
	else:
		svg_points = [(x + x_cur, y_max - y + y_cur) for x, y in points]
	dwg.add( dwg.polygon(points=svg_points, stroke='black', fill='white') )
	x_cur = max( x for x,y in svg_points ) + 20

x_cur = y_cur = 0
dwg = svgwrite.Drawing( 'LaserJig.svg', profile='tiny' )
for k,v in sorted( polys.items(), key=lambda e: approx_poly_area(e[1]), reverse=True ):
	for c in range(count[k]):
		to_poly_svg( dwg, '{}_{}'.format(k,c+1), v )
dwg.save()

# Create an svg file with a sheet in it for nesting.
x_cur = y_cur = 0
dwg = svgwrite.Drawing( 'LaserJigForNesting.svg', profile='tiny' )
to_poly_svg( dwg, 'sheet', cube_to_points((board_width, board_height, sheet_thickness)) )
for k,v in sorted( polys.items(), key=lambda e: approx_poly_area(e[1]), reverse=True ):
	for c in range(count[k]):
		to_poly_svg( dwg, '{}_{}'.format(k,c+1), v )
dwg.save()

#-----------------------------------------------------------------------
# Save all polygons in svg format, one file for each, in a directory.
#
target_dir = 'svg_files'
shutil.rmtree( target_dir, ignore_errors=True )

os.mkdir( target_dir )
for k,v in sorted( polys.items(), key=lambda e: approx_poly_area(e[1]), reverse=True ):
	for c in range(count[k]):
		fname = '{}_{}.svg'.format(k, c+1) if count[k] > 1 else '{}.svg'.format(k)
		dwg = svgwrite.Drawing( os.path.join(target_dir, fname), profile='tiny' )
		x_cur = y_cur = 0
		to_poly_svg( dwg, '{}_{}'.format(k,c+1), v )
		# print( k, c, count[k], fname )
		dwg.save()
'''

#-----------------------------------------------------------------------
# Output the labeled parts list.
#
with open('main-2d-parts-list.txt', 'w') as f:
	for k,v in sorted( polys.items(), key=operator.itemgetter(0) ):
		f.write( '{}: {}\n'.format( k, count[k] ) )
		for p in v:
			f.write( '    {:8.2f},{:8.2f}\n'.format(*p) )
