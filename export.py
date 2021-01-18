import re
from collections import defaultdict
from subprocess import Popen, DEVNULL, PIPE
import svgwrite
import ezdxf
import shutil
import os

cmd = ['openscad', 'main.scad', '-o', 'main.png']

proc = Popen( cmd, stdout=PIPE, stderr=PIPE )
out, err = proc.communicate()

sheet_thickness = 0

board_height, board_width = 8*12*2.54, 4*12*2.54

count = defaultdict( int )
polys = {}

def cube_to_points( cube ):
	points = [v for v in cube if v != sheet_thickness]
	while len(points) < 2:
		points.append( sheet_thickness )
	x, y = points
	return ((0,0), (x,0), (x,y), (0,y))

for line in err.decode().split('\n'):
	if line.startswith('ECHO:') and '=' in line:
		line = line[5:].strip()
		if line.startswith('"'):
			repeat, line = line.split('", ', 2)
			repeat = int( re.sub('[^0-9]', '', repeat) )
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

#-----------------------------------------------------------------------
doc = ezdxf.new()
doc.units = 4	# mm

msp = doc.modelspace()

x_cur = y_cur = 0
def to_poly_dxf( msp, label, points ):
	global x_cur, y_cur
	dxf_points = [(x_cur + x, y_cur + y) for x, y in points]
	p = msp.add_lwpolyline( dxf_points )
	p.close( True )
	x_cur = max( x for x,y in dxf_points ) + 30
	return p

#-----------------------------------------------------------------------
# Save all polygons in one dxf format.
#
for k,v in polys.items():
	for c in range(count[k]):
		to_poly_dxf( msp, '{}_{}'.format(k,c+1), v )
doc.saveas('BikeJig.dxf')

#-----------------------------------------------------------------------
# Save all polygons in dxf format, one file for each, in a directory.
#
target_dir = 'dxf_files'
shutil.rmtree( target_dir, ignore_errors=True )
	
os.mkdir( target_dir )
for k,v in polys.items():
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
# Save all polygons in svg format, one file for each, in a directory.
#
target_dir = 'svg_files'
shutil.rmtree( target_dir, ignore_errors=True )
	
def to_poly_svg( dwg, label, points ):
	dwg.add( dwg.polyline(points=points,
			stroke='none',
			fill='blue',
		) )

os.mkdir( target_dir )
for k,v in polys.items():
	for c in range(count[k]):
		fname = '{}_{}.svg'.format(k, c+1) if count[k] > 1 else '{}.svg'.format(k)
		dwg = svgwrite.Drawing( os.path.join(target_dir, fname), profile='tiny' )
		to_poly_svg( dwg, '{}_{}'.format(k,c+1), v )
		print( k, c, count[k], fname )
		dwg.save()
