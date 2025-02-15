extends TileMapLayer

class ground:
	var tileId = 0;
	var center = Vector2(0,0);
	var left = Vector2(0,0);
	var up = Vector2(0,0);
	var right = Vector2(0,0);
	var down = Vector2(0,0);
	var lu = Vector2(0,0);
	var ld = Vector2(0,0);
	var ru = Vector2(0,0);
	var rd = Vector2(0,0);
	func _init(id,c,l,u,r,d,llu,lld,rru,rrd) -> void:
		tileId = id
		center = c
		left = l
		up = u
		right = r
		down = d
		lu = llu
		ld = lld
		ru = rru
		rd = rrd
		

var MAP_GRASS = ground.new(0,Vector2(1,1),Vector2(2,1),Vector2(1,2),Vector2(0,1),Vector2(1,0),Vector2(0,3),Vector2(0,4),Vector2(1,3),Vector2(1,4))
var MAP_GRASS2 = ground.new(2,Vector2(1,1),Vector2(2,1),Vector2(1,2),Vector2(0,1),Vector2(1,0),Vector2(0,3),Vector2(0,4),Vector2(1,3),Vector2(1,4))

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func generateMap(w: int, h: int , pos = Vector2(0,0)) -> void:
	for x in w:
		for y in h:
			set_cell(Vector2(pos.x + x, pos.y + y), MAP_GRASS2.tileId, MAP_GRASS2.center,0);
	for x in w:
		set_cell(Vector2(pos.x + x, pos.y), MAP_GRASS.tileId, MAP_GRASS.up,0);
		set_cell(Vector2(pos.x + x, pos.y+h-1), MAP_GRASS.tileId, MAP_GRASS.down,0);
	
	for y in h:
		set_cell(Vector2(pos.x, pos.y+y), MAP_GRASS.tileId, MAP_GRASS.left,0);
		set_cell(Vector2(pos.x + w-1, pos.y+y), MAP_GRASS.tileId, MAP_GRASS.right,0);
		
	set_cell(Vector2(pos.x, pos.y), MAP_GRASS.tileId, MAP_GRASS.lu,0);
	set_cell(Vector2(pos.x, pos.y + h-1), MAP_GRASS.tileId, MAP_GRASS.ld,0);
	set_cell(Vector2(pos.x + w-1, pos.y), MAP_GRASS.tileId, MAP_GRASS.ru,0);
	set_cell(Vector2(pos.x + w-1, pos.y + h-1), MAP_GRASS.tileId, MAP_GRASS.rd,0);
