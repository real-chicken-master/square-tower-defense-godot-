extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	$"ColorRect/wavesSurvivedText".text = "you survived " + str(Globals.wave) + " waves"


func _on_quit_button_button_down():
	get_tree().quit()


func _on_menu_button_button_down():
	get_tree().change_scene_to_file("res://UI/title_screen.tscn")


func _on_restart_button_button_down():
	get_tree().change_scene_to_file(Globals.levelpath)
