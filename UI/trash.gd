extends Area2D

var node = null

var enabled = false:
	set(boolean):
		if(boolean == true):
			$AnimationPlayer.play("lid_off")
			monitoring = true
		if(boolean == false) :
			$AnimationPlayer.play_backwards("lid_off")
			monitoring = false
		enabled = boolean

func _process(_delta):
	if(node != null):
		if (Input.is_action_just_pressed("left click")):
			if(is_instance_valid(node)):
				node.sell()
				get_tree().get_first_node_in_group("ui").stopTowerPlace()

func _on_area_entered(area):
	node = area.get_parent()


func _on_area_exited(_area):
	node = null
