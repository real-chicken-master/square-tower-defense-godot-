extends Node2D

var disc_scene = preload("res://towers/projectiles/disc.tscn")

var redSquare = preload("res://squares (enemies)/redSquare.tscn")

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
		$towers/towerImage.texture = "res://images/disc.png"
	


func createSquare(type):
	if(type == "blue"):
		$CanvasLayer/BoxContainer/SquarePath/path2d.add_child(redSquare)

func _on_disc_shooter_shoot_disc(pos, direction,damage):
	var disc = disc_scene.instantiate() as Area2D
	disc.global_position = pos
	disc.direction = direction
	disc.damage = damage
	$towers/projectiles.add_child(disc)

