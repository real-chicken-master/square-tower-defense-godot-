extends Sprite2D

var can_place = false

var canPlaceCollision = true

var blockingObjects = []

signal placeTower(towerType,pos)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	global_position = get_global_mouse_position()
	if(Input.is_action_just_released("left click")):
		can_place = true
	if (can_place && !canPlaceCollision):
		if (Input.is_action_just_pressed("left click")):
			placeTower.emit("discShooter",global_position)
			queue_free()



func _on_area_2d_area_entered(area):
	blockingObjects.push_front(area)
	if(blockingObjects.size() != 0):
		canPlaceCollision = true


func _on_area_2d_area_exited(area):
	blockingObjects.erase(area)
	if(blockingObjects.size() == 0):
		canPlaceCollision = false


func _on_area_2d_body_entered(body):
	blockingObjects.push_front(body)
	if(blockingObjects.size() != 0):
		canPlaceCollision = true

func _on_area_2d_body_exited(body):
	blockingObjects.erase(body)
	if(blockingObjects.size() == 0):
		canPlaceCollision = false
