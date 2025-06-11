extends Node

var levelpath:
	set(path):
		levelpath = path

var health = 100:
	set(hp):
		if(hp > health):
			health = 0
		else:
			health = hp
		if (health <= 0):
			TransitionLayer.changeScene("res://UI/deathScreen.tscn")

var money = 100

var wave = 0

signal waveEnd()

var waveInProgress = false:
	set(temp):
		waveInProgress = temp
		if(temp == false):
			waveEnd.emit()
		

var speed = 1

var squaresLeftInWave = 0:
	set(squaresLeft):
		squaresLeftInWave = squaresLeft
		if(squaresLeft == 0):
			waveInProgress = false
		else:
			waveInProgress = true

func reset():
	Tutorial = false
	health = 100
	money = 100
	wave = 0
	waveInProgress = false
	squaresLeftInWave = 0
	Engine.time_scale = 1.0

var Tutorial = false
