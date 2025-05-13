extends Square

signal createSquare(SquareType)

@export var SquareType = "red"

func _ready():
	speed = 50


func _process(delta):
	progress += speed*delta



func _on_character_body_2d_create_square(Type):
	createSquare.emit(Type)
