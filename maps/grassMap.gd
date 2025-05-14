extends Node2D

var disc_scene = preload("res://towers/projectiles/disc.tscn")

var redSquare_scene = preload("res://squares (enemies)/redSquare.tscn")

var discShooterPlace_scene = preload("res://towers/tower place/DiscShooterPlace.tscn")
var discShooter_scene = preload("res://towers/discShooter.tscn")

func _ready():
	connectSignals()

func connectSignals():
	for towers in get_tree().get_nodes_in_group("towers"):
		towers.connect("shootDisc",_on_disc_shooter_shoot_disc)
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
		discShooter.position = pos
		$towers.add_child(discShooter)
		pass

func createSquare(type):
	if(type == "blue"):
		var redSquare = redSquare_scene.instantiate() as PathFollow2D
		$CanvasLayer/BoxContainer/SquarePath/path2d.add_child(redSquare)

func _on_disc_shooter_shoot_disc(pos, direction,damage):
	var disc = disc_scene.instantiate() as Area2D
	disc.global_position = pos
	disc.direction = direction
	disc.damage = damage
	$towers/projectiles.add_child(disc)

