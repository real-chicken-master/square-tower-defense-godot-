extends CanvasLayer

func _ready():
	$".".visible = false

func changeScene(target):
	$AnimationPlayer.play_backwards("fade_animation")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file(target)
	$AnimationPlayer.play("loading")
	var length = $AnimationPlayer.get_current_animation_length() / (randf_range(1,1.6))
	await get_tree().create_timer(length).timeout
	print("test")
	$AnimationPlayer.play("fade_animation")
