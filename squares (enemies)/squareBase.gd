extends PathFollow2D

class_name Square

var speed = 0

var type

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
	if(type == "black"):
		if((damage/2) >= health):
			Globals.money += health
		else:
			Globals.money += floor((damage/2))
		currentHealth -= (damage/2)
		updateSquareColor()
	else:
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
		type = "red"
		$CharacterBody2D.scale = Vector2(1,1)
		$CharacterBody2D.modulate = Color(255,0,0,255)
		speed = 200
	if(currentHealth == 2):
		type = "blue"
		$CharacterBody2D.scale = Vector2(1,1)
		$CharacterBody2D.modulate = Color(0,0,255,255)
		speed = 210
	if(currentHealth == 3):
		type = "yellow"
		$CharacterBody2D.scale = Vector2(1,1)
		$CharacterBody2D.modulate = Color(255,255,0,255)
		speed = 500
	if(currentHealth >= 4 && currentHealth <= 6):
		type = "green"
		$CharacterBody2D.scale = Vector2(1,1)
		$CharacterBody2D.modulate = Color(0,255,0,255)
		speed = 350
	if(currentHealth >= 7 && currentHealth <= 9):
		type = "pink"
		$CharacterBody2D.scale = Vector2(1,1)
		$CharacterBody2D.modulate = Color(255,0,255,255)
		speed = 400
	if(currentHealth >= 10 && currentHealth <= 20):
		type = "light blue"
		$CharacterBody2D.scale = Vector2(1,1)
		$CharacterBody2D.modulate = Color(0,255,255,255)
		speed = 300
	if(currentHealth >= 21 && currentHealth <= 30):
		type = "orange"
		$CharacterBody2D.scale = Vector2(1,1)
		$CharacterBody2D.modulate = Color(200,100,0,255)
		speed = 400
	if(currentHealth >= 31 && currentHealth <= 100):
		type = "black"
		$CharacterBody2D.scale = Vector2(1.8,1)
		$CharacterBody2D.modulate = Color(0,0,0)
		speed = 300



func _on_tree_exiting():
	Globals.squaresLeftInWave -= 1
