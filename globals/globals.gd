extends Node

var levelpath:
	set(path):
		print(path)
		levelpath = path

var health = 100:
	set(hp):
		if(hp > health):
			health = 0
		else:
			health = hp
		if (health == 0):
			get_tree().change_scene_to_file("res://UI/deathScreen.tscn")

var money = 100

var wave = 0

var waveInProgress = false

var speed = 1

var squaresLeftInWave = 0:
	set(squaresLeft):
		squaresLeftInWave = squaresLeft
		if(squaresLeft == 0):
			waveInProgress = false
		else:
			waveInProgress = true

func reset():
	health = 100
	money = 100
	wave = 0
	waveInProgress = false
	squaresLeftInWave = 0
	Engine.time_scale = 1.0
