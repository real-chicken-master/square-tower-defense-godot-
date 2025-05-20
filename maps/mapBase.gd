extends Node

class_name levelParent


var disc_scene = preload("res://towers/projectiles/disc.tscn")

var Square_scene = preload("res://squares (enemies)/squareBase.tscn")

var discShooterPlace_scene = preload("res://towers/tower place/DiscShooterPlace.tscn")
var discShooter_scene = preload("res://towers/towers/discShooter.tscn")

var sniperPlace_scene = preload("res://towers/tower place/sniperPlace.tscn")
var sniper_scene = preload("res://towers/towers/sniper.tscn")

var sprayerPlace_scene = preload("res://towers/tower place/sprayerPlace.tscn")
var sprayer_scene = preload("res://towers/towers/sprayer.tscn")

func _ready():
	connectSignals()

func connectSignals():
	for Squares in get_tree().get_nodes_in_group("squares"):
		Squares.connect("createSquare",createSquare)
	$UI/UI.connect("towerplace",towerPlace)
	$UI/UI.connect("startNextWave" ,startNextWave)

func towerPlace(towerType):
	if(towerType == "disc Shooter"):
		var DiscShooterPlace = discShooterPlace_scene.instantiate() as Sprite2D
		DiscShooterPlace.connect("placeTower",placeTower)
		$towers/towerPlaceIcons.add_child(DiscShooterPlace)
	if(towerType == "sniper"):
		var sniperPlace = sniperPlace_scene.instantiate() as Sprite2D
		sniperPlace.connect("placeTower",placeTower)
		$towers/towerPlaceIcons.add_child(sniperPlace)
	if(towerType == "sprayer"):
		var sprayerPlace = sprayerPlace_scene.instantiate() as Sprite2D
		sprayerPlace.connect("placeTower",placeTower)
		$towers/towerPlaceIcons.add_child(sprayerPlace)

func upgradeStop():
	$UI/UI.upgradeStop()

func placeTower(towerType,pos):
	if(towerType == "discShooter"):
		var discShooter = discShooter_scene.instantiate() as CharacterBody2D
		discShooter.connect("discShooterUpgrade",towerUpgrade)
		discShooter.connect("shootDisc",shoot_disc)
		discShooter.connect("upgradeStop",upgradeStop)
		discShooter.global_position = pos
		$towers.add_child(discShooter)
	if(towerType == "sniper"):
		var sniper = sniper_scene.instantiate() as CharacterBody2D
		sniper.connect("sniperUpgrade",towerUpgrade)
		sniper.connect("upgradeStop",upgradeStop)
		sniper.global_position = pos
		$towers.add_child(sniper)
	if(towerType == "sprayer"):
		var sprayer = sprayer_scene.instantiate() as CharacterBody2D
		sprayer.connect("shootDisc",shoot_disc)
		sprayer.connect("sprayerUpgrade",towerUpgrade)
		sprayer.connect("upgradeStop",upgradeStop)
		sprayer.global_position = pos
		$towers.add_child(sprayer)

func createSquare(type):
	if(type == "red"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 1
		$SquarePath/SquarePath.add_child(square)
	if(type == "blue"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 2
		$SquarePath/SquarePath.add_child(square)
	if(type == "yellow"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 3
		$SquarePath/SquarePath.add_child(square)
	if(type == "green"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 6
		$SquarePath/SquarePath.add_child(square)
	if(type == "pink"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 9
		$SquarePath/SquarePath.add_child(square)
	if(type == "lightBlue"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 20
		$SquarePath/SquarePath.add_child(square)
	if(type == "orange"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 30
		$SquarePath/SquarePath.add_child(square)
	if(type == "black"):
		var square = Square_scene.instantiate() as PathFollow2D
		square.health = 100
		$SquarePath/SquarePath.add_child(square)

func shoot_disc(pos, direction,damage):
	var disc = disc_scene.instantiate() as Area2D
	disc.global_position = pos
	disc.direction = direction
	disc.damage = damage
	$towers/projectiles.add_child(disc)


func wave1():
	Globals.squaresLeftInWave += 50
	for num in 50:
		createSquare("red")
		await get_tree().create_timer(0.2).timeout

func wave2():
	Globals.squaresLeftInWave += 40
	for num in 20:
		createSquare("red")
		await get_tree().create_timer(0.2).timeout
	for num in 20:
		createSquare("blue")
		await get_tree().create_timer(0.2).timeout

func wave3():
	Globals.squaresLeftInWave += 50
	for num in 10:
		createSquare("red")
		await get_tree().create_timer(0.2).timeout
	for num in 20:
		createSquare("blue")
		await get_tree().create_timer(0.2).timeout
	for num in 20:
		createSquare("yellow")
		await get_tree().create_timer(0.2).timeout

func wave4():
	Globals.squaresLeftInWave += 10
	for num in 10:
		createSquare("green")
		await get_tree().create_timer(0.3).timeout

func wave5():
	Globals.squaresLeftInWave += 15
	for num in 10:
		createSquare("green")
		await get_tree().create_timer(0.3).timeout
	for num in 5:
		createSquare("pink")
		await get_tree().create_timer(0.2).timeout

func wave6():
	Globals.squaresLeftInWave += 12
	for num in 5:
		createSquare("green")
		await get_tree().create_timer(0.2).timeout
	for num in 5:
		createSquare("pink")
		await get_tree().create_timer(0.2).timeout
	for num in 2:
		createSquare("lightBlue")
		await get_tree().create_timer(0.2).timeout

func wave7():
	Globals.squaresLeftInWave += 150
	for num in 100:
		createSquare("red")
		await get_tree().create_timer(0.02).timeout
	await get_tree().create_timer(0.3).timeout
	for num in 50:
		createSquare("blue")
		await get_tree().create_timer(0.02).timeout

func wave8():
	Globals.squaresLeftInWave += 15
	for num in 5:
		createSquare("pink")
		await get_tree().create_timer(0.2).timeout
	for num in 5:
		createSquare("lightBlue")
		await get_tree().create_timer(0.2).timeout
	for num in 5:
		createSquare("orange")
		await get_tree().create_timer(0.4).timeout

func wave9():
	Globals.squaresLeftInWave += 30
	for num in 10:
		createSquare("pink")
		await get_tree().create_timer(0.2).timeout
	for num in 10:
		createSquare("lightBlue")
		await get_tree().create_timer(0.2).timeout
	for num in 10:
		createSquare("orange")
		await get_tree().create_timer(0.3).timeout

func wave10():
	Globals.squaresLeftInWave += 1
	createSquare("black")


func startNextWave(waveNumber):
	if(waveNumber == 1):
		Globals.waveInProgress = true
		wave1()
	if(waveNumber == 2):
		Globals.waveInProgress = true
		wave2()
	if(waveNumber == 3):
		Globals.waveInProgress = true
		wave3()
	if(waveNumber == 4):
		Globals.waveInProgress = true
		wave4()
	if(waveNumber == 5):
		Globals.waveInProgress = true
		wave5()
	if(waveNumber == 6):
		Globals.waveInProgress = true
		wave6()
	if(waveNumber == 7):
		Globals.waveInProgress = true
		wave7()
	if(waveNumber == 8):
		Globals.waveInProgress = true
		wave8()
	if(waveNumber == 9):
		Globals.waveInProgress = true
		wave9()
	if(!Globals.waveInProgress):
		Globals.wave = 0

func towerUpgrade(upgradeBranch1,tower,towerNode):
	$UI/UI.towerUpgrade(upgradeBranch1,tower,towerNode)


func _on_character_body_2d_shoot_disc(pos, direction, damage):
	shoot_disc(pos, direction, damage)


