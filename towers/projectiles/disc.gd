extends Area2D

@export var speed = 1000

@export var damage = 1

var direction = Vector2.UP

var canHit = true

var target = null

func _ready():
	$life.start()

func  _process(delta) -> void:
	if(target != null):
		look_at(target.global_position)
	global_position += direction * speed * delta

func _on_life_timeout():
	queue_free()

func _on_body_entered(body):
	if(canHit):
		if body.has_method("hit"):
			canHit = false
			body.hit(damage)
	queue_free()
