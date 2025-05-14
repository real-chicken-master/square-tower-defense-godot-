extends PathFollow2D

class_name Square

var speed = 0

@export var health = 2

func _ready():
	updateSquareColor()
	progress = 0

func _process(delta):
	if(progress_ratio == 1):
		Globals.health -= health
		queue_free()
	updateSquareColor()
	progress += speed*delta

func hit(damage):
	Globals.money += damage
	health -= damage
	updateSquareColor()

func updateSquareColor():
	if(health <= 0):
		queue_free()
	if(health == 1):
		$CharacterBody2D.modulate = Color(255,0,0,255)
		speed = 200
	if(health == 2):
		$CharacterBody2D.modulate = Color(0,0,255,255)
		speed = 200
	if(health == 3):
		$CharacterBody2D.modulate = Color(255,255,0,255)
		speed = 500
	if(health >= 4 && health <= 6):
		$CharacterBody2D.modulate = Color(0,255,0,255)
		speed = 500
