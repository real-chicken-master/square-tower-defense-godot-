extends Control

func _ready():
	$mainButtons.visible = true
	$levelButtons.visible = false
	Globals.reset()
func _on_start_button_button_down():
	showMaps()

func _on_exit_button_button_down():
	get_tree().quit()

func _process(_delta):
	$TitleScreen.scale *= 1.001
	if($TitleScreen.scale >= Vector2(10,10)):
		$TitleScreen.scale = Vector2(2,2)

func showMaps():
	$mainButtons.visible = false
	$levelButtons.visible = true


func hideMaps():
	$mainButtons.visible = true
	$levelButtons.visible = false

func _on_map_1_button_button_down():
	get_tree().change_scene_to_file("res://maps/Map1.tscn")


func _on_map_2_button_button_down():
	get_tree().change_scene_to_file("res://maps/Map2.tscn")


func _on_back_button_button_down():
	hideMaps()
