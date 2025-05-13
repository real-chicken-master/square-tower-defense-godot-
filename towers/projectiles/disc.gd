extends Area2D

@export var speed = 2400

@export var damage = 1

var direction = Vector2.UP

var canHit = true

func _ready():
	$life.start()

func  _process(delta) -> void:
	global_position += direction * speed * delta

func _on_life_timeout():
	queue_free()

func _on_body_entered(body):
	if(canHit):
		if body.has_method("hit"):
			canHit = false
			body.hit(damage)
	queue_free()
