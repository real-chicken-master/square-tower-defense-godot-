extends Sprite2D

var can_place = false

signal placeTower(towerType,pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	global_position = get_global_mouse_position()
	if(Input.is_action_just_released("left click")):
		can_place = true
	if (can_place):
		if (Input.is_action_just_pressed("left click")):
			placeTower.emit("discShooter",global_position)
			queue_free()
