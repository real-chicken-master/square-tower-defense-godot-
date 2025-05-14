extends Node2D

var disc_scene = preload("res://towers/projectiles/disc.tscn")

var Square_scene = preload("res://squares (enemies)/squareBase.tscn")

var discShooterPlace_scene = preload("res://towers/tower place/DiscShooterPlace.tscn")
var discShooter_scene = preload("res://towers/discShooter.tscn")

func _ready():
	connectSignals()

func connectSignals():
	for Squares in get_tree().get_nodes_in_group("squares"):
		Squares.connect("createSquare",createSquare)
	$UI/UI.connect("towerplace",towerPlace)

func towerPlace(towerType):
	if(towerType == "disc Shooter"):
		var DiscShooterPlace = discShooterPlace_scene.instantiate() as Sprite2D
		DiscShooterPlace.connect("placeTower",placeTower)
		$towers/towerPlaceIcons.add_child(DiscShooterPlace)

func placeTower(towerType,pos):
	if(towerType == "discShooter"):
		var discShooter = discShooter_scene.instantiate() as CharacterBody2D
		discShooter.connect("shootDisc",_on_disc_shooter_shoot_disc)
		discShooter.position = pos
		$towers.add_child(discShooter)
		pass

func createSquare(type):
	if(type == "red"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 1
		$SquarePath/path2d.add_child(square)

func _on_disc_shooter_shoot_disc(pos, direction,damage):
	var disc = disc_scene.instantiate() as Area2D
	disc.global_position = pos
	disc.direction = direction
	disc.damage = damage
	$towers/projectiles.add_child(disc)


func wave1():
	createSquare("red")


func _on_ui_start_next_wave(waveNumber):
	if(waveNumber == 1):
		wave1()


func _on_path_2d_child_exiting_tree(node):
	if ($SquarePath/path2d.get_child_count()==1):
		Globals.waveInProgress = false
