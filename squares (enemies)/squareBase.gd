extends PathFollow2D

class_name Square

var speed = 0

@export var health = 2

var currentHealth

func _ready():
	currentHealth = health
	updateSquareColor()
	progress = 0

func _process(delta):
	if(progress_ratio == 1):
		Globals.health -= health
		queue_free()
	updateSquareColor()
	progress += speed*delta

func hit(damage):
	if(damage >= health):
		Globals.money += health
	else:
		Globals.money += floor(damage)
	currentHealth -= damage
	updateSquareColor()

func updateSquareColor():
	if(currentHealth <= 0):
		queue_free()
	if(currentHealth == 1):
		$CharacterBody2D.modulate = Color(255,0,0,255)
		speed = 200
	if(currentHealth == 2):
		$CharacterBody2D.modulate = Color(0,0,255,255)
		speed = 200
	if(currentHealth == 3):
		$CharacterBody2D.modulate = Color(255,255,0,255)
		speed = 500
	if(currentHealth >= 4 && currentHealth <= 6):
		$CharacterBody2D.modulate = Color(0,255,0,255)
		speed = 500



func _on_tree_exiting():
	Globals.squaresLeftInWave -= 1
