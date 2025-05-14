extends CharacterBody2D

signal createSquare(SquareType)

func getProgress():
	return $"..".progress

func hit(damage):
	$"..".hit(damage)
