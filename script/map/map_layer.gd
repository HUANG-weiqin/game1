extends TileMapLayer


func _getLeftTiles(lu : Vector2, rd : Vector2) -> Array:
	var L = []
	for i in range(lu.y + 1, rd.y):
		L.append(Vector2(lu.x,i))
	return L

func _getRightTiles(lu : Vector2, rd : Vector2) -> Array:
	var R = []
	for i in range(lu.y + 1, rd.y):
		R.append(Vector2(rd.x,i))
	return R

func _getUpTiles(lu : Vector2, rd : Vector2) -> Array:
	var U = []
	for i in range(lu.x + 1, rd.x):
		U.append(Vector2(i,lu.y))
	return U
	
func _getDownTiles(lu : Vector2, rd : Vector2) -> Array:
	var D = []
	for i in range(lu.x + 1, rd.x):
		D.append(Vector2(i,rd.y))
	return D
	
func _getRU(lu : Vector2, rd : Vector2) -> Vector2:
	return Vector2(rd.x,lu.y)
	
func _getLD(lu : Vector2, rd : Vector2) -> Vector2:
	return Vector2(lu.x,rd.y) 
	
func _getGround(lu : Vector2, rd : Vector2) -> Array:
	var GROUND = []
	for i in range(lu.x , rd.x + 1):
		for j in range(lu.y , rd.y + 1):
			GROUND.append(Vector2(i,j));
	return GROUND


func _generateWall(luTiles : Vector2, rdTiles : Vector2, pos : Vector2, size : Vector2, TileSetID = 0 , alternative_tile = 0 ) -> void:
	var LU = luTiles
	var RU = _getRU(luTiles, rdTiles)
	var LD = _getLD(luTiles, rdTiles)
	var RD = rdTiles
	var L = _getLeftTiles(luTiles, rdTiles)
	var U = _getUpTiles(luTiles, rdTiles)
	var R = _getRightTiles(luTiles, rdTiles)
	var D = _getDownTiles(luTiles, rdTiles)
	
	var w = size.x
	var h = size.y
	
	for x in w:
		set_cell(Vector2(pos.x + x, pos.y), TileSetID, U.pick_random(), alternative_tile);
		set_cell(Vector2(pos.x + x, pos.y+h-1), TileSetID, D.pick_random(),alternative_tile);
	
	for y in h:
		set_cell(Vector2(pos.x, pos.y+y), TileSetID, L.pick_random(),alternative_tile);
		set_cell(Vector2(pos.x + w-1, pos.y+y), TileSetID, R.pick_random(),alternative_tile);
		
	set_cell(Vector2(pos.x, pos.y), TileSetID, LU,alternative_tile);
	set_cell(Vector2(pos.x, pos.y + h-1), TileSetID, LD,alternative_tile);
	set_cell(Vector2(pos.x + w-1, pos.y), TileSetID, RU,alternative_tile);
	set_cell(Vector2(pos.x + w-1, pos.y + h-1), TileSetID, RD,alternative_tile);

func _generateGround(luTiles : Vector2, rdTiles : Vector2, pos : Vector2, size : Vector2, TileSetID = 0 , alternative_tile = 0 ) -> void:
	var GROUND = _getGround(luTiles, rdTiles)
	for x in size.x:
		for y in size.y:
			set_cell(Vector2(pos.x + x, pos.y + y), TileSetID, GROUND.pick_random(), alternative_tile);
	
			

func generateMap(w: int, h: int , pos = Vector2(0,0)) -> void:
	
	var groundLU = Vector2(6,0)
	var groundRD = Vector2(9,2)
	_generateGround(groundLU,groundRD,pos,Vector2(w,h),0,0)
	
	var wallLU = Vector2(0,0)
	var wallRD = Vector2(5,4)
	_generateWall(wallLU,wallRD,pos,Vector2(w,h),0,0)

	var wallLU2 = Vector2(1,1)
	var wallRD2 = Vector2(4,3)
	_generateWall(wallLU2, wallRD2, pos + Vector2(1,1), Vector2(w-2,h-2), 0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	
func eraseMap(w:int, h:int, pos = Vector2(0,0)) -> void:
	print ("erase",pos)
