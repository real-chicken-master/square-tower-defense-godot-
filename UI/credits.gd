extends Control

var active = false

var tempTime

func _on_timer_timeout():
	if(Engine.time_scale != 0):
		tempTime = Engine.time_scale
	if(active):
		Engine.time_scale = 0
		visible = true
		$VBoxContainer.global_position.y -= 3
		if($VBoxContainer.global_position.y < -2000):
			active = false
	else:
		Engine.time_scale = tempTime
		visible = false
		$VBoxContainer.global_position.y = 0
