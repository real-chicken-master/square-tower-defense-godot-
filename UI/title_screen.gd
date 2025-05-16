extends Control

func _on_start_button_button_down():
	get_tree().change_scene_to_file("res://maps/grassMap.tscn")


func _on_button_button_down():
	get_tree().quit()
