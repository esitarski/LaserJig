from math import sin, cos, pi, atan

height_top = 135
height_bottom = 5

def x_func( C ):								# C is the angle at the top of the triangle.
	b = height_top - height_bottom				# Required line length in cm.
	B = 2*atan( (110/2) / 60 )					# beam spread angle (fixed).
	A = pi - B - C								# A if the angle at the bottom of triangle.
	
	c = b * sin( C ) / sin( B )
	x = c * sin( A )
	y = c * cos( A ) + height_bottom
	m = pi/2 - (A + B/2)
	return x, y, m
	
if __name__ == '__main__':
	import svgwrite
	dwg = svgwrite.Drawing( 'triangle.svg', profile='tiny' )
	def xy( x, y ):
		return 5*(100-x), 5*(150-y)
	dwg.add( dwg.rect(insert=(0,0), size=xy(0,0), fill='white', stroke='black', stroke_width=1) )
	
	for i in range(0, 180, 2):
		try:
			x, y, m = x_func(i*pi/180)
		except Exception as e:
			print( e )
			pass
		if x < 27:
			continue
		print( '({:.2f},{:.2f})  p={:.2f} m={:.2f}'.format(x, y, i, m/pi*180) )
		dwg.add( dwg.polyline(points=[xy(0,height_top), xy(x,y), xy(0,height_bottom)],
			stroke='black', stroke_width=1,
			fill='none', opacity=1,
		) )
		p_len = 5
		dwg.add( dwg.line( start=xy(x, y), end=xy(x+p_len*cos(m+pi),y+p_len*sin(m+pi)), stroke='black', stroke_width=1) )
		text = '({:.2f}, {:.2f}), {:.2f}'.format(x, y, -m/pi*180)
		dwg.add( dwg.text( text, insert=xy(x,y), text_anchor='end') )
		
	dwg.save()
