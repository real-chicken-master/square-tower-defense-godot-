extends CharacterBody2D

signal sniperUpgrade(int,String,Self)

signal upgradeStop()

var notice = false

var target = null

var canShoot = true

var targets = []

var Damage = 3

var upgradeBranch1 = 0

var attackSpeed = 1:
	set(attackspeed):
		attackSpeed = attackspeed
		$shootDelay.wait_time /= attackSpeed

func _process(_delta):
	getTarget()
	if(notice):
		look_at(target.global_position)
		rotation_degrees += 90
		if(canShoot):
			if target.has_method("hit"):
				target.hit(Damage)
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
			if($Sniper.is_pixel_opaque(get_local_mouse_position())):
				sniperUpgrade.emit(upgradeBranch1,"sniper",self)
				$noticeCircle.visible = true
			else:
				$noticeCircle.visible = false
				upgradeStop.emit()
