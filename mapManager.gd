extends Node2D

var MAP_BLOCK_SIZE = 8
@onready var MAP = get_node("map")
var CUR_CENTER = Vector2.ZERO
var BLOCKS_LOADED = []

func  _ready() -> void:
	var MAP = get_node("map")
	_updateMap(Vector2.ZERO)

func _updateMap(viewPos:Vector2)  -> void:
	var ix = floor(viewPos.x / MAP_BLOCK_SIZE)
	var iy = floor(viewPos.y / MAP_BLOCK_SIZE)
	print(Vector2(ix,iy),viewPos)

	for i in [-1,0,1]:
		for j in [-1,0,1]:
			var pos = Vector2(i,j) + Vector2(ix,iy)
			if pos not in BLOCKS_LOADED:
				_loadBlock(pos * MAP_BLOCK_SIZE)
				BLOCKS_LOADED.append(pos)
	
	
	
func _loadBlock(leftUpPos:Vector2)  -> void:
	MAP.generateMap(MAP_BLOCK_SIZE,MAP_BLOCK_SIZE,leftUpPos);
	
func updateMap(viewPos:Vector2)  -> void:
	_updateMap(viewPos)


func _on_pig_befor_move(curPos,offset) -> void:
	updateMap(curPos+offset)
