extends CharacterBody2D

signal shootDisc(pos,direction,damage)

signal sprayerUpgrade(int,String,Self)

signal upgradeStop()

var upgradeBranch1 = 0

var attackSpeed = 1:
	set(attackspeed):
		attackSpeed = attackspeed
		$shootDelay.wait_time /= attackSpeed

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

func _input(event):
	if(event is InputEventMouseButton and event.pressed):
		if(event.button_index == MOUSE_BUTTON_LEFT):
			if($Sprayer.is_pixel_opaque(get_local_mouse_position())):
				sprayerUpgrade.emit(upgradeBranch1,"sprayer",self)
				$noticeCircle.visible = true
			else:
				$noticeCircle.visible = false
				upgradeStop.emit()



