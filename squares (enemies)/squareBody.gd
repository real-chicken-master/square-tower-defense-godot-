extends CharacterBody2D

signal createSquare(SquareType)

func getProgress():
	return $"..".progress

func hit():
	var type = $"..".SquareType
	if(type == "blue"):
		createSquare.emit("blue")
		queue_free()
	if(type == "red"):
		queue_free()
