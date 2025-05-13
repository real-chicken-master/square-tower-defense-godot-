extends CharacterBody2D

func getProgress():
	return $"..".progress

func hit(damage):
	$"..".hit(damage)
