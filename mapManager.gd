extends Node2D

var MAP_BLOCK_SIZE = 6
@onready var MAP = get_node("mapLayer")
var CUR_CENTER = Vector2.ZERO
var BLOCKS_LOADED = []
	
func genMap() -> void:
	Net.update_world(MAP.generateMap)
	
func back(viewPos:Vector2):
	print(viewPos)
	
func _updateMap(viewPos:Vector2)  -> void:
	var viewBlockPos = Vector2(floor(viewPos.x / MAP_BLOCK_SIZE),floor(viewPos.y / MAP_BLOCK_SIZE))
	
	for block in BLOCKS_LOADED:
		if (block - viewBlockPos).length_squared() > 2:
			_unLoadBlock(block)

	for i in [-1,0,1]:
		for j in [-1,0,1]:
			var pos = Vector2(i,j) + viewBlockPos
			if pos not in BLOCKS_LOADED:
				_loadBlock(pos * MAP_BLOCK_SIZE)
				BLOCKS_LOADED.append(pos)
				
	
	print(BLOCKS_LOADED)	
	
func _loadBlock(leftUpPos:Vector2)  -> void:
	MAP.generateMap(MAP_BLOCK_SIZE,MAP_BLOCK_SIZE,leftUpPos);
	
func _unLoadBlock(leftUpPos:Vector2) -> void:
	pass
	
func updateMap(viewPos:Vector2)  -> void:
	_updateMap(viewPos)

func _on_pig_befor_move(curPos,offset) -> void:
	updateMap(curPos+offset)
	
func _input(event: InputEvent) -> void:
	if(Input.is_key_pressed(KEY_E)):
		genMap()
