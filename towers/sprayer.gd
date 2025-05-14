extends CharacterBody2D

signal shootDisc(pos,direction,damage)

var notice = false

var target = null

var canShoot = true

var targets = []

var Damage = 1

func _process(_delta):
	getTarget()
	if(notice):
		if(canShoot):
			for marker in $Sprayer.get_children():
				var pos = marker.global_position
				var Direction = (marker.global_position - global_position).normalized()
				shootDisc.emit(pos, Direction,Damage)
				canShoot = false
				$shootDelay.start()


func getTarget():
	var TargetProgress
	for n in targets.size():
		TargetProgress = targets[n].getProgress()
		if(is_instance_valid(target)):
			if(target.getProgress()<TargetProgress):
				target = targets[n]
		else:
			target = targets[n]


func _on_notice_area_body_entered(body):
	if(target == null):
		target = body
	notice = true
	targets.push_front(body)


func _on_notice_area_body_exited(body):
	targets.erase(body)
	if(targets.size() == 0):
		target = null
		notice = false


func _on_shoot_delay_timeout():
	canShoot = true

