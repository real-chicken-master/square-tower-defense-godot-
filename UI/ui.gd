extends Control

signal towerplace(TowerType)

var towerType

func _on_button_button_down():
	towerType = "disc Shooter"
	towerplace.emit(towerType)
