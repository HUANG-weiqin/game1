extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var map = get_node("map")
	#map.generateMap(150,150,Vector2(-50,-50));
	map.generateMap(34,18,Vector2(5,5));


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
