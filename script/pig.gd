extends Node2D

signal befor_move()
const stepLen = 16
var moveDest = Vector2.ZERO
var moveFrom = Vector2.ZERO
var moving = false
var moveDelta = 0
const moveStepTime = 0.2

func getPos() -> Vector2:
	return position / stepLen;

func move(offset : Vector2) -> void:
	if moving : return
	emit_signal("befor_move",getPos(),offset.normalized())
	moveDelta = 0
	moveDest = position + offset
	moveFrom = position
	moving = true
	
func _process(delta: float) -> void:
	if not moving: return
	moveDelta = min(1, moveDelta + delta/0.3)
	position = (moveDest - moveFrom) * moveDelta + moveFrom;
	if moveDelta == 1:
		moving = false;
	

func _input(event: InputEvent) -> void:
	var lr = Input.get_axis("ui_left", "ui_right")
	var ud = Input.get_axis("ui_up", "ui_down") if lr==0 else 0;
	var direction = Vector2( lr, ud)
	if direction:
		move(direction.normalized() * stepLen);
		
