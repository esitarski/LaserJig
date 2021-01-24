import re
import math
import ezdxf
import xml.sax

def to_poly_dxf( msp, dxf_points ):
	p = msp.add_lwpolyline( dxf_points )
	p.close( True )
	return p

class MyHandler( xml.sax.handler.ContentHandler ):
	def __init__( self ):
		super().__init__()
		self.reset()
		self.sheet_width = 4*12*25.4
		self.sheet_height = 8*12*25.4
		
	def reset( self ):
		self.sheet_count = 0
		self.doc = None
		self.msp = None
		self.reset_transform()
		
	def reset_transform( self ):
		self.translate = (0,0)
		self.rotate = 0
		
	def write_current_doc( self ):
		if self.doc:
			self.sheet_count += 1
			self.doc.saveas('LaserJigSheet_{}.dxf'.format(self.sheet_count) )
			
		self.doc = None
		self.msp = None
		
	def open_doc( self ):
		self.doc = ezdxf.new()
		self.doc.units = 4	# mm
		self.msp = self.doc.modelspace()
		self.reset_transform()
		
	def do_translate( self, points ):
		return tuple( (x+self.translate[0], y+self.translate[1]) for x, y in points )
		
	def do_rotate( self, points ):
		a = self.rotate * math.pi / 180
		cos_a = math.cos( a )
		sin_a = math.sin( a )
		return tuple( (x*cos_a - y*sin_a, x*sin_a + y*cos_a) for x, y in points)
	
	def startElement(self, name, attrs):
		if name == 'g':
			transform = attrs['transform']
			if 'rotate' not in transform:
				self.write_current_doc()
				self.open_doc()
				# to_poly_dxf( self.msp, ((0,0), (self.sheet_width,0), (self.sheet_width,self.sheet_height), (0,self.sheet_height)) )
			else:
				self.rotate = float(re.search( 'rotate\(([^)]+)\)', transform ).group(1)) 
				translate_match = re.search( 'translate\(([^ ]+) ([^)]+)\)', transform )
				self.translate = (float(translate_match.group(1)), float(translate_match.group(2)))
		elif name == 'polygon':
			points = [tuple(float(v) for v in p.split(',')) for p in attrs['points'].split()]
			points = self.do_translate( self.do_rotate(points) )
			to_poly_dxf( self.msp, points )
	
	def endElement( self, name ):
		pass
		
	def endDocument( self ):
		self.write_current_doc()

with open('Nested.svg') as f:
	xml.sax.parse( f, MyHandler() )

