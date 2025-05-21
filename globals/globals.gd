extends Node

var health = 100

var money = 100

var wave = 0

var waveInProgress = false

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
